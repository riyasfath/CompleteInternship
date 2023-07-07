import 'package:get/get.dart';
import 'package:my_grocery/model/ad_banner.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/services/local_service/local_ad_banner_service.dart';
import 'package:my_grocery/services/local_service/local_product_sevice.dart';
import 'package:my_grocery/services/remote_service/remote_banner_service.dart';
import 'package:my_grocery/services/remote_service/remote_popular_product_service.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/services/local_service/local_category_service.dart';
import 'package:my_grocery/services/remote_service/remote_popular_category_service.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Categories> popularCategory =
      List<Categories>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;

  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    print("started");
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();

    getAdBanners();
    getPopularCategories();
    getPopularProducts();

    super.onInit();
  }

  void getAdBanners() async {
    try {
      isBannerLoading(true);
      //assigning local ad banners before call api
      if (_localAdBannerService.getAdBanners().isNotEmpty) {
        bannerList.assignAll(_localAdBannerService.getAdBanners());
      }
//call api
      var result = await RemoteBannerService().get();
      if (result != null) {
        //assign api result
        bannerList.assignAll(adBannerListFromJson(result.body));
        //save api result to local db
        _localAdBannerService.assignAllAdBanners(
            adBanners: adBannerListFromJson(result.body));
      }
    } finally {
      isBannerLoading(false);
    }
  }

  void getPopularCategories() async {
    print('not loaded');

    try {
      isPopularCategoryLoading(true);
      if (_localCategoryService.getPopularCategories().isNotEmpty) {
        popularCategory.assignAll(_localCategoryService.getPopularCategories());
      }
      print('not ld');

      var result = await RemotePopularCategoryService().get();
      if (result != null) {
        popularCategory.assignAll(popularCategoryFromJson(result.body));
        _localCategoryService.assignAllPopularCategories(
            popularCategories: popularCategoryFromJson(result.body));
      }
    } finally {
      print(popularCategory.length);
      isPopularCategoryLoading(false);
    }
  }

  void getPopularProducts() async {
    try {
      isPopularProductLoading(true);
      if (_localProductService.getPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }

      var result = await RemotePopularProductService().get();
      if (result != null) {
        popularProductList.assignAll(popularProductListFromJson(result.body));
        _localProductService.assignAllPopularProducts(
            popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      print(popularProductList.length);
      isPopularProductLoading(false);
    }
  }
}
