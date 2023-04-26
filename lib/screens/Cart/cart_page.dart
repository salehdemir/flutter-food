import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/card_controller.dart';
import 'package:flutter_ui_project/controllers/pop_product_controller.dart';
import 'package:flutter_ui_project/utils/app_constants.dart';
import 'package:flutter_ui_project/utils/colors.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:flutter_ui_project/widgets/app_icon.dart';
import 'package:flutter_ui_project/widgets/big_text.dart';
import 'package:flutter_ui_project/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../route/route_helper.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              right: Dimensions.width20,
              left: Dimensions.width20,
              height: Dimensions.height20*5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIconWidget(icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize:Dimensions.iconSize24,
                  ),
                  // dimension.Width 20*5
                  SizedBox(width: Dimensions.width30*9,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIconWidget(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:Dimensions.iconSize24,
                    ),
                  ),
                  AppIconWidget(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize:Dimensions.iconSize24,
                  )
                ],
              )),

          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var popularIndex = Get.find<PopProductController>()
                                          .poplarProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex>= 0){
                                        Get.toNamed(RouteHelper.getPopFood(popularIndex,'cartPage'));
                                      }else{
                                        var recommendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar('History Product', 'Product review is not available for history product',
                                              backgroundColor: AppColors.mainColor,colorText: Colors.white);
                                        }else{

                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,'cartPage'));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: Dimensions.height20*6,
                                      width: Dimensions.height20*5,
                                      margin: EdgeInsets.only(top: Dimensions.height5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigTextWidget(text: cartController.getItems[index].name!,color: Colors.black54,),
                                        SmallTextWidget(text: 'spicy'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigTextWidget(text: cartController.getItems[index].price.toString(),color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  BigTextWidget(text: _cartList[index].quantity.toString()),

                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                        print('being tapped');

                                                      },
                                                      child: Icon(Icons.add,color: AppColors.signColor,)),
                                                ],),
                                            )
                                          ],
                                        )

                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    },),
                  ),
                )):NoDataPage( text: 'Your cart is empty',);
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
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
            child: cartController.getItems.length>0?Row(
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

                      SizedBox(width: Dimensions.width10/2,),
                      BigTextWidget(text: '\$ '+cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width10/2,),

                    ],),
                ),
                GestureDetector(
                  onTap: (){
                    // popProduct.addItem(product);
                    print('tapped');
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                    child: BigTextWidget(text: "Check Out",color: Colors.white,),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ):Container(),
          );
        },)
    );
  }
}
