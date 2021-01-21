import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';

class BackFloatingButton extends StatelessWidget {
  const BackFloatingButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.0,
      width: 68.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: ColorConstants.checkinColor,
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}