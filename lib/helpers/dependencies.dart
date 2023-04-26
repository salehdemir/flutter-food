import 'package:flutter_ui_project/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/card_controller.dart';
import '../controllers/pop_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/card_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';
Future<void> init()async {

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);
//  api client
Get.lazyPut(()=> ApiClient(appBaseUrl: AppConstants.BASE_URL));
//repos
Get.lazyPut(()=> RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo(sharedPreferences:Get.find()));
//controller
Get.lazyPut(()=> RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(()=> PopProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=> CartController(cartRepo: Get.find()));



}