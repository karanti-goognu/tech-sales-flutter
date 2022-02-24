import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomSimmerWidget extends StatelessWidget {

  final double width;
  final double? height;
  final ShapeBorder shapeBorder;

  const CustomSimmerWidget.rectangular({
    this.width = double.infinity,
    this.height
  }): this.shapeBorder = const RoundedRectangleBorder();

  const CustomSimmerWidget.circular({
    this.width = double.infinity,
    this.height,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context)  => Shimmer.fromColors(
    baseColor: ColorConstants.lightOutlineColor,
    highlightColor: Colors.grey[300]!,
    period: Duration(seconds: 2),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400],
        shape: shapeBorder,

      ),
    ),
  );
}