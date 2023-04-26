import 'package:flutter/material.dart';
import 'package:flutter_ui_project/utils/dimension.dart';
import 'package:flutter_ui_project/widgets/small_text.dart';

import '../utils/colors.dart';

class LongTextWidget extends StatefulWidget {
  final String text;
  const LongTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<LongTextWidget> createState() => _LongTextWidgetState();
}

class _LongTextWidgetState extends State<LongTextWidget> {
  //
  late String firstHalf;
  late String secondHalf;
  //
  bool hiddenText = true;
  //
  // double textHeight = Dimensions.screenHeight/5.63;
  //
  @override
  void initState() {
    super.initState();
    if(widget.text.length> 150){
      firstHalf =widget.text.substring(0,150 );
      secondHalf = widget.text.substring(151,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:secondHalf.length== ""? Text(widget.text,style: TextStyle(fontSize: Dimensions.font16,color: AppColors.paraColor),):
      Column(
        children: [
       Text(style: TextStyle(fontSize: Dimensions.font16,color: AppColors.paraColor,height: 1.5),hiddenText?firstHalf:widget.text),
SizedBox(height: Dimensions.height10,),
            InkWell(
              onTap: (){
                setState(() {
                  hiddenText =!hiddenText;
                });
              },
              child: Row(
                 children: [
               hiddenText?    SmallTextWidget(text: 'Show more',color: AppColors.mainColor,):SmallTextWidget(text: 'Show less',color: AppColors.mainColor,),
                   Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
                 ],
              ),
            )
        ],
      ),
    );



  }
}











