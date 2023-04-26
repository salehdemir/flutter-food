import 'package:flutter_ui_project/screens/food/food_detail.dart';
import 'package:flutter_ui_project/screens/home/main_food_screen.dart';
import 'package:flutter_ui_project/screens/splash/splash_page.dart';
import 'package:get/get.dart';


import '../screens/Cart/cart_page.dart';
import '../screens/food/recommended_food_detail.screen.dart';
import '../screens/home/home_page.dart';

class RouteHelper{
  static const String splashPage ='/splash-page';
  static const String initial ='/';
  static const String popFood ='/pop-food';
  static const String recommendedFood ='/recommended-food';
  static const String cartPage ='/cart-page';

  static  String getSplashPage()=>'$splashPage';
  static  String getInitial ()=>'$initial';
  static  String getPopFood (int pageId,String page)=>'$popFood?pageId=$pageId&page=$page';
  static  String getRecommendedFood (int pageId,String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static  String getCartPage ()=>'$cartPage';
  


  static List<GetPage> routes = [

    GetPage(name: splashPage, page: ()=> SplashScreen()),
    GetPage(name: initial, page: ()=> HomePage()),

    GetPage(name: popFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];

      return FoodDetailScreen(pageId:int.parse(pageId!),page:page!);
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: recommendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return RecommendedFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn
    )
  ];
}