import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/card_controller.dart';
import 'package:flutter_ui_project/utils/app_constants.dart';
import 'package:flutter_ui_project/utils/dimension.dart';

import '../../controllers/pop_product_controller.dart';
import '../../route/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/long_text.dart';
import 'package:get/get.dart';



class FoodDetailScreen extends StatelessWidget {
  final int pageId;
  final String page;
   const FoodDetailScreen({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var product = Get.find<PopProductController>().poplarProductList[pageId];
    Get.find<PopProductController>().initProduct(product,  Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
body: Stack(
  children: [
    // background image
    Positioned(
        left: 0,
        right: 0,
        child: Container(
      width: double.maxFinite,
          height: Dimensions.popularFoodImgSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover ,
              image: NetworkImage(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
              )
            )
          ),

    )),
    // Icon widget
    Positioned(
      top: Dimensions.height45,
        left: Dimensions.width20,
        right: Dimensions.width20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap:(){
           if(page=='cartPage'){
             Get.toNamed(RouteHelper.getCartPage());
           }else{
             Get.toNamed(RouteHelper.getInitial());

           }
    },
            child: AppIconWidget(icon: Icons.arrow_back_ios,)
        ),

        GetBuilder<PopProductController>(builder: (controller){
          return GestureDetector(
            onTap: (){
              // if( controller .totalItems>=1)
              Get.toNamed(RouteHelper.getCartPage());

            },
            child: Stack(
              children: [
                AppIconWidget(icon: Icons.shopping_cart_outlined,),
                controller .totalItems>=1?
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
    )),
    // Introduction of food
    Positioned(
        left: 0,
        right: 0,
        bottom: 0,

        top: Dimensions.popularFoodImgSize-20,
        child: Container(
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white,

          ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             AppColumnWidget(text: product.name!),
             SizedBox(height: Dimensions.height20,),
             BigTextWidget(text: 'Introduce'),
             SizedBox(height: Dimensions.height20,),
             Expanded(child: SingleChildScrollView(child: LongTextWidget(text: product.description! )))
             
           ],
         ),
        )),
  ],
),
      bottomNavigationBar: GetBuilder<PopProductController>(builder: (popProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(

                topLeft:Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),

              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigTextWidget(text: popProduct.inCardItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                        popProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,)),
                  ],),
              ),
              GestureDetector(
                onTap: (){
                  popProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                      child: BigTextWidget(text: "\$ ${product.price} | add to card",color: Colors.white,),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}
