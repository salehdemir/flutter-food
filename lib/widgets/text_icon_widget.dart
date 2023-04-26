import 'package:flutter/cupertino.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:flutter_ui_project/widgets/small_text.dart';

class TextAndIconWidget extends StatelessWidget {

  final IconData icon;
  final String text;

  final Color iconColor;

  const TextAndIconWidget({Key? key,
    required this.icon,
    required this.text,

    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallTextWidget(text: text),
      ],
    );
  }
}
