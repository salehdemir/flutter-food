import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/card_controller.dart';
import 'package:get/get.dart';
import 'controllers/pop_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helpers/dependencies.dart' as dep;
import './route/route_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData();
    return GetBuilder<PopProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
           return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });

  }
}
