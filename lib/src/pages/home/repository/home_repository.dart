import 'package:cupdelivery/src/constants/endpoints.dart';
import 'package:cupdelivery/src/models/item_model.dart';
import 'package:cupdelivery/src/pages/home/result/home_result.dart';
import 'package:cupdelivery/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<ItemModel>> getAllProducts(
      {required bool isFilter, String? filter = ''}) async {
    final result = await _httpManager.restRequest(
      url: !isFilter
          ? Endpoints.getAllProducts
          : Endpoints.getAllProductsByTitle + filter!,
      method: HttpMethods.get,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(ItemModel.fromMap)
          .toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocrreu um erro inesperado ao recuperar os itens');
    }
  }
}
