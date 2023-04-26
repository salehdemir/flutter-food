import 'package:flutter/material.dart';

import '../../utils/dimension.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'food_body_screen.dart';


class MainFoodScreen extends StatefulWidget {
  const MainFoodScreen({Key? key}) : super(key: key);

  @override
  State<MainFoodScreen> createState() => _MainFoodScreenState();
}

class _MainFoodScreenState extends State<MainFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  children: [
                    BigTextWidget(
                      text: 'Afghanistan',
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallTextWidget(
                          text: 'Kabul',
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(
                   Icons.search,
                       color: Colors.white,

                     ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor
                    ),
                  ),
                )
              ],),
            ),
          ),
        Expanded(child: SingleChildScrollView(
          child:   FoodBodyScreen(),
        )),
        ],
      ),
    );
  }
}





























// import 'package:flutter/material.dart';
// import 'package:flutter_ui_project/utilis/colors.dart';
// import 'package:flutter_ui_project/utilis/dimension.dart';
// import 'package:flutter_ui_project/widgets/big_text.dart';
// import 'package:flutter_ui_project/widgets/small_text.dart';
//
// import 'food_body_screen.dart';
//
// class MainFoodScreen extends StatefulWidget {
//   const MainFoodScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainFoodScreen> createState() => _MainFoodScreenState();
// }
//
// class _MainFoodScreenState extends State<MainFoodScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: Column(
//       children: [
//         Container(
//           child: Container(
//             margin: EdgeInsets.only(top: Dimensions.Height45, bottom: Dimensions.Height15),
//             padding: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     BigTextWidget(
//                       text: 'Afghanistan',
//                       color: AppColors.mainColor,
//                     ),
//                     Row(
//                       children: [
//                         SmallTextWidget(
//                           text: 'Kabul',
//                           color: Colors.black54,
//                         ),
//                         Icon(Icons.arrow_drop_down_rounded)
//                       ],
//                     )
//                   ],
//                 ),
//                 Center(
//                   child: Container(
//                     width: Dimensions.Height45,
//                     height: Dimensions.Height45,
//                     child: Icon(
//                       Icons.search,
//                       color: Colors.white,
//                       size: Dimensions.IconSize24,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.mainColor,
//                       borderRadius: BorderRadius.circular(Dimensions.Radius15),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(child:
//         SingleChildScrollView(
//           child: FoodBodyScreen()
//           ,),),
//       ],
//     ));
//   }
// }
