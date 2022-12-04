import 'package:get/get.dart';
import 'package:cupdelivery/src/models/category_model.dart';
import 'package:cupdelivery/src/models/item_model.dart';
import 'package:cupdelivery/src/pages/home/repository/home_repository.dart';
import 'package:cupdelivery/src/pages/home/result/home_result.dart';
import 'package:cupdelivery/src/services/utils_services.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  bool isLoading = false;
  List<CategoryModel> allCategories = [
    CategoryModel(
      id: 1,
      title: 'Cupcakes',
      items: [],
    )
  ];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  RxString searchTitle = ''.obs;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    if (allCategories.isEmpty) return;
    selectCategory(allCategories.first);
  }

  void filterByTitle() {
    // Apagar todos os produtos das categorias
    //for (var category in allCategories) {
    //  category.items = [];
    //}

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == 0);

      if (c == null) {
        // Criar uma nova categoria com todos
        final allProductsCategory =
            CategoryModel(id: 0, title: 'Todos', items: []);
        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
      }
    }

    currentCategory = allCategories.first;
    update();
    getAllProducts();
  }

  Future<void> getAllProducts() async {
    setLoading(true);

    bool isFilter = false;
    String filter = '';

    if (searchTitle.value.isNotEmpty) {
      isFilter = true;
      filter = searchTitle.value;
    }

    HomeResult<ItemModel> result =
        await homeRepository.getAllProducts(isFilter: isFilter, filter: filter);

    setLoading(false);

    result.when(success: (data) {
      currentCategory!.items = data;
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }
}
