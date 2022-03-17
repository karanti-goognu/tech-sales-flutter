


import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ConformationDialog extends StatefulWidget {
  final String? message;
  const ConformationDialog({Key? key, this.message}) : super(key: key);


  @override
  _ConformationDialogState createState() =>
      _ConformationDialogState( message);
}

class _ConformationDialogState extends State<ConformationDialog> {
   final String? message;
  double? textSize;
  _ConformationDialogState(this.message);
  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Padding(
      padding: new EdgeInsets.only(
          left: SizeConfig.screenWidth! * 0.07,
          right: SizeConfig.screenWidth! * 0.07,
          bottom: SizeConfig.screenHeight! * .04),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: new Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                getMessageText(SizeConfig.screenHeight!, SizeConfig.screenWidth!),
                getYesOrNo(SizeConfig.screenHeight!, SizeConfig.screenWidth!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*text filed Widget*/
  Widget getMessageText(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: parentHeight * .05,
        bottom: parentHeight * .06,
        left: parentWidth * .05,
        right: parentWidth * .05,
      ),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: new Text(message!,
                style: new TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Avenir_Black',
//                  fontSize: textSize
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                ),
                textScaleFactor: 1.3,
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  /*widget for yes or no field*/
  Widget getYesOrNo(double parentHeight, double parentWidth) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        getYesText(parentHeight, parentWidth),

      ],
    );
  }

  /*widget get yes*/
  Widget getYesText(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: ()  => {
        Get.back()
      },
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            right: parentWidth * .0, bottom: parentHeight * .02),
        child: Padding(
          padding: EdgeInsets.only(
            top: parentHeight * .02,
            right: parentWidth * .04,
            left: parentWidth * .04,
            bottom: parentHeight * .02,
          ),
          child: new Text("Ok",
              style: new TextStyle(
                color:  Colors.cyan,
                fontFamily: 'Avenir_Black',
                fontSize: SizeConfig.safeBlockHorizontal * 4.3,
              ),
              textScaleFactor: 1.3,
              textAlign: TextAlign.center),
        ),
      ),
    );
  }


}


