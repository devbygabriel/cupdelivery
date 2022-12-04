import 'package:get/get.dart';
import 'package:cupdelivery/src/constants/storage_keys.dart';
import 'package:cupdelivery/src/models/user_model.dart';
import 'package:cupdelivery/src/pages/auth/repository/auth_repository.dart';
import 'package:cupdelivery/src/pages/auth/result/auth_result.dart';
import 'package:cupdelivery/src/pages_routes/app_pages.dart';
import 'package:cupdelivery/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  Future<void> getToken() async {
    await authRepository.getToken();
    await validateUser();
  }

  Future<void> validateUser() async {
    String? email = await utilsServices.getLocalData(
      key: StorageKeys.email,
    );

    String? password = await utilsServices.getLocalData(
      key: StorageKeys.password,
    );

    if (email == null || password == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    result.when(
      success: (user) {
        this.user = user;
        saveDataAndProceedToBase(email: email, password: password);
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();
    // Remover os dados locais
    utilsServices.removeLocalData(key: StorageKeys.email);
    utilsServices.removeLocalData(key: StorageKeys.password);
    // Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveDataAndProceedToBase({
    required String email,
    required String password,
  }) {
    utilsServices.saveLocalData(key: StorageKeys.email, data: email);
    utilsServices.saveLocalData(key: StorageKeys.password, data: password);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> singUp() async {
    isLoading.value = true;

    final password = user.password!;
    final email = user.email!;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveDataAndProceedToBase(
          email: email,
          password: password,
        );
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveDataAndProceedToBase(email: email, password: password);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> updateUser() async {
    isLoading.value = true;

    await authRepository.updateUser(user);

    utilsServices.showToast(message: 'Atualização realizada');

    isLoading.value = false;
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await authRepository.changePassword(
      userId: user.id!,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    isLoading.value = false;

    if (result) {
      // Mensagem
      utilsServices.showToast(message: 'A senha foi atualizada com sucesso');
      // Logout
      signOut();
    } else {
      utilsServices.showToast(
        message: 'A senha atual está incorreta',
        isError: true,
      );
    }
  }
}
