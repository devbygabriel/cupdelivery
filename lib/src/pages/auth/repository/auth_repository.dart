import 'package:cupdelivery/src/constants/endpoints.dart';
import 'package:cupdelivery/src/models/user_model.dart';
import 'package:cupdelivery/src/pages/auth/result/auth_result.dart';
import 'package:cupdelivery/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['id'] != null) {
      final user = UserModel.fromMap(result.cast());
      return AuthResult.success(user);
    } else {
      return AuthResult.error(result['error']);
    }
  }

  Future getToken() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getToken,
      method: HttpMethods.get,
      headers: {'Authorization': authUsername},
    );

    if (result['access_token'] != null) {
      token = result['access_token'];
      refreshToken = result['refresh_token'];
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.singup,
      method: HttpMethods.post,
      headers: {'Authorization': 'Bearer $token'},
      body: user.toMap(),
    );

    return handleUserOrError(result);
  }

  Future<void> updateUser(UserModel user) async {
    await _httpManager.restRequest(
      url: Endpoints.updateUser,
      method: HttpMethods.put,
      headers: {'Authorization': 'Bearer $token'},
      body: user.toMap(),
    );
  }

  Future<bool> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HttpMethods.put,
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'id': userId,
        'password': currentPassword,
        'newPassword': newPassword,
      },
    );

    return result['error'] == null;
  }
}
