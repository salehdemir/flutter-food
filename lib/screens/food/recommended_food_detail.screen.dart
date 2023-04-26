import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/pop_product_controller.dart';
import 'package:flutter_ui_project/controllers/recommended_product_controller.dart';
import 'package:flutter_ui_project/utils/app_constants.dart';
import 'package:flutter_ui_project/utils/colors.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:flutter_ui_project/widgets/app_icon.dart';
import 'package:flutter_ui_project/widgets/big_text.dart';
import 'package:flutter_ui_project/widgets/long_text.dart';
import 'package:get/get.dart';

import '../../controllers/card_controller.dart';
import '../../route/route_helper.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId,required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopProductController>().initProduct(product,  Get.find<CartController>());


    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if(page=='cartPage'){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());

                    }
                  },
                  child: AppIconWidget(icon: Icons.clear),
                ),
                 // AppIconWidget(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      // if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIconWidget(icon: Icons.shopping_cart_outlined,),
                        //Get.find<PopProductController>().total>1? in video
                        controller.totalItems>=1?
                        Positioned(
                          right:0, top:0,

                            child: AppIconWidget(
                              icon: Icons.circle,
                              size: Dimensions.radius20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),

                        )
                            :Container(),
                        Get.find<PopProductController>().totalItems>=1?
                        Positioned(

                          right:Dimensions.width3, top:Dimensions.height3,
                          child: BigTextWidget(text: Get.find<PopProductController>().totalItems.toString(),
                            size: Dimensions.font12,color: Colors.white,
                          ),
                        )
                            :Container()
                      ],
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                child: Center(
                  child: BigTextWidget(
                    size: Dimensions.font26,
                    text: product.name,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.height5, bottom: Dimensions.height10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.buttonBackgroundColor,
            expandedHeight: Dimensions.height300,
            // stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: LongTextWidget(text: product.description),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIconWidget(
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      icon: Icons.remove,
                    ),
                  ),
                  BigTextWidget(
                    text: '\$ ${product.price} X ${controller.inCardItems}',
                    size: Dimensions.font26,
                    color: AppColors.mainBlackColor,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIconWidget(
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      icon: Icons.add,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: BigTextWidget(
                        text: "\$ ${product.price!} | add to card",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

