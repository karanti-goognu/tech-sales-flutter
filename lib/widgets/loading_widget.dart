import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        CircularProgressIndicator(),
        SizedBox(height: 20,),
        Text("Please wait...",style: TextStyles.robotoBold16,)
      ],),
    );
  }
}


class  MandatoryWidget{
  Widget txtMandatory(){
    return
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          "Mandatory",
          style: TextStyle(
            fontFamily: "Muli",
            color: ColorConstants.inputBoxHintColorDark,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
  }
}