import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ui_project/route/route_helper.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:get/get.dart';
import '../../controllers/pop_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

 Future<void> _loadResource() async {
    await Get.find<PopProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =  AnimationController(
        vsync: this, duration: const Duration(seconds: 2,
    ))..forward();
    animation = CurvedAnimation(
        parent: controller, curve: Curves.linear,);

  Timer(
    const Duration(seconds:3),
        ()=> Get.offNamed(RouteHelper.getInitial()),
);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/image/yummy logo.jpg',width: Dimensions.splashImg,)),
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset('assets/image/yummy text.jpg',width: Dimensions.splashImg,))),
        ],
      ),
    );
  }
}
