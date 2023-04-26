import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_project/controllers/recommended_product_controller.dart';

import 'package:flutter_ui_project/utils/app_constants.dart';
import 'package:flutter_ui_project/widgets/big_text.dart';

import '../../controllers/pop_product_controller.dart';
import '../../models/products_models.dart';
import '../../route/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../../widgets/app_column.dart';
import '../../widgets/small_text.dart';
import '../../widgets/text_icon_widget.dart';
import 'package:get/get.dart';

class FoodBodyScreen extends StatefulWidget {
  const FoodBodyScreen({Key? key}) : super(key: key);

  @override
  State<FoodBodyScreen> createState() => _FoodBodyScreenState();
}

class _FoodBodyScreenState extends State<FoodBodyScreen> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _hieght = Dimensions.pageViewContainer;


  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopProductController>(builder:(popProduct){
return
  popProduct.isLoaded?Container(
    // color: Colors.redAccent,
    height: Dimensions.pageView,
      child: PageView.builder(
          controller: pageController,
          itemCount: popProduct.poplarProductList.length,
          itemBuilder: (context, position) {
            return _buildPageItem(position,popProduct.poplarProductList[position]);
          },
      ),

  ):CircularProgressIndicator(
    color: AppColors.mainColor,
  );
        }),


        GetBuilder<PopProductController>(builder: (popProduct){
          return
    DotsIndicator(
            dotsCount: popProduct.poplarProductList.isEmpty?1:popProduct.poplarProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigTextWidget(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: BigTextWidget(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallTextWidget(text: 'Food Pairing'),
              ),
            ],
          ),
        ),
         SizedBox(height: Dimensions.height20,),

         GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?   ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context ,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index,'home'));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                ),
                              ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextConSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                  Radius.circular(Dimensions.radius20)),
                              color: Colors.white,),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigTextWidget(
                                      //in videos name has !
                                      text: recommendedProduct.recommendedProductList[index].name),

                                  // different
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallTextWidget(
                                      text: 'With chinese characteristics'),

                                  // different
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextAndIconWidget(
                                        icon: Icons.circle_sharp,
                                        text: 'Normal',
                                        iconColor: AppColors.iconColor1,
                                      ),
                                      TextAndIconWidget(
                                        icon: Icons.location_on,
                                        text: '1.7km',
                                        iconColor: AppColors.mainColor,
                                      ),
                                      TextAndIconWidget(
                                        icon: Icons.access_time_rounded,
                                        text: '32min',
                                        iconColor: AppColors.iconColor2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
         })



      ],
    );
  }
  Widget _buildPageItem(int index,ProductModel poplarProduct) {

    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _hieght * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getPopFood(index,'home'));

            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10 ),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(Dimensions.radiu30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                     AppConstants.BASE_URL+AppConstants.UPLOAD_URL+poplarProduct.img!
                  ),
                ),

              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right:Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ],


              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
                child: AppColumnWidget(text: poplarProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




















