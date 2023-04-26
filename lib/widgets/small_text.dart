import 'package:flutter/cupertino.dart';

class SmallTextWidget extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;


  SmallTextWidget(
      {Key? key,
        this.color = const Color(0xFFccc7c5),
        required this.text,
        this.height=1.2,
        this.size = 12,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height
      ),
    );
  }
}
