import 'package:flutter/material.dart';
import 'package:flutter_ui_project/widgets/small_text.dart';
import 'package:flutter_ui_project/widgets/text_icon_widget.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import 'big_text.dart';

class AppColumnWidget extends StatelessWidget {
  final String text;
  const AppColumnWidget({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigTextWidget(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) {
                  return Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  );
                },
              ),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallTextWidget(text: '4.5'),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallTextWidget(text: '1287'),
            SizedBox(width: Dimensions.width10),
            SmallTextWidget(text: 'comments')
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],),
      ],
    );
  }
}
