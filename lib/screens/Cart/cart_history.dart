import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/card_controller.dart';
import 'package:flutter_ui_project/models/cart_model.dart';
import 'package:flutter_ui_project/route/route_helper.dart';
import 'package:flutter_ui_project/utils/app_constants.dart';
import 'package:flutter_ui_project/utils/colors.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:flutter_ui_project/widgets/app_icon.dart';
import 'package:flutter_ui_project/widgets/big_text.dart';
import 'package:flutter_ui_project/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=> ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
      }
    }
    List<int> cartItemsPerOrderToList (){
      return cartItemsPerOrder.entries.map((e) =>e.value).toList();
    }
    List<String> cartOrderTimeToList (){
      return cartItemsPerOrder.entries.map((e) =>e.key).toList();
    }

     List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outPutDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss").parse(
            getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat = DateFormat("MM-dd-yyyy hh:mm a");
        outPutDate = outPutFormat.format(inputDate);
      }
      return BigTextWidget(text: outPutDate);
    }


    return Scaffold(
      body: Column(
        children: [
         Container(
           color: AppColors.mainColor,
           width: double.maxFinite,
           // difference 100
           height: Dimensions.height20*5,
           padding: EdgeInsets.only(
             // difference 45
             top: Dimensions.height15*3
           ),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               BigTextWidget(text: "Cart History",color: Colors.white,),
             AppIconWidget(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,)
             ],
           ),
         ),

          GetBuilder<CartController>(builder: (_cartController){
            var cartLength =_cartController.getCartHistoryList();
            return cartLength.length>0?Expanded(
              child:  Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,

              ),
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context, child: ListView(
                children: [
                  for(int i=0; i<itemsPerOrder.length; i++)
                    Container(

                      height: Dimensions.height120,
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          timeWidget(listCounter),
                          SizedBox(height: Dimensions.height10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if(listCounter<getCartHistoryList.length){
                                      listCounter++;
                                    }
                                    return index<=2?Container(
                                      height: Dimensions.height20*4,
                                      width: Dimensions.height20*4,
                                      margin: EdgeInsets.only(right: Dimensions.width5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                              )
                                          )
                                      ),
                                    ):Container();
                                  })
                              ),
                              Container(
                                height: Dimensions.height20*4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallTextWidget(text:'total',color: AppColors.titleColor),
                                    BigTextWidget(text: itemsPerOrder[i].toString()+ ' Items',color: AppColors.titleColor,),
                                    GestureDetector(
                                      onTap: (){
                                        var orderTime = cartOrderTimeToList();
                                        Map<int, CartModel> moreOrder ={};
                                        for(int j=0; j<getCartHistoryList.length; j++){
                                          if(getCartHistoryList[j].time==orderTime[i] ){
                                            moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                            );
                                          }
                                        }
                                        Get.find<CartController>().setItems = moreOrder;
                                        Get.find<CartController>().addToCartList();
                                        Get.toNamed(RouteHelper.getCartPage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width5,vertical: Dimensions.height5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                          border: Border.all(width: 1,color: AppColors.mainColor),

                                        ),
                                        child: Text('one more',style: TextStyle(color: AppColors.mainColor),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )],
                      ),

                    )

                ],
              )),
            ),):
            SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                    child: NoDataPage(text:"You didn't buy anything so far",imgPath: 'assets/image/emptybox.png',)));
          }),
        ],
      ),
    );
  }
}
