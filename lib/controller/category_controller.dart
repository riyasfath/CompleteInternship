import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/services/local_service/local_category_service.dart';
import 'package:my_grocery/services/remote_service/remote_category_service.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find<CategoryController>();
  RxList<Categories> categoryList = List<Categories>.empty(growable: true).obs;
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  RxBool isCategoryLoading = false.obs;

  @override
  void onInit() async {
    await _localCategoryService.init();
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    try {
      isCategoryLoading(true);

      if (_localCategoryService.getCategories().isNotEmpty) {
        categoryList.assignAll(_localCategoryService.getCategories());
      }
      var result = await RemoteCategoryService().get();
      if (result != null) {
        categoryList.assignAll(categoryListFromJson(result.body));
        _localCategoryService.assignAllCategories(
            categories: categoryListFromJson(result.body));
      }
    } finally {
      isCategoryLoading(false);
    }
  }
}
