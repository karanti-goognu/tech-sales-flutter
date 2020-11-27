import 'package:flutter/material.dart';
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