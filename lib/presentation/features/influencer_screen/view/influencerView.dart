import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';

class AddInfluencerView extends StatefulWidget {
  @override
  _AddInfluencerViewState createState() => _AddInfluencerViewState();
}

class _AddInfluencerViewState extends State<AddInfluencerView> {
  Color _color= ColorConstants.backgroundColorBlue;
  final random = Random();
  Duration oneSec = const Duration(seconds:1);
  changeColors(){
    new Timer.periodic(oneSec, (Timer t) =>

    setState(() {
      _color = Color.fromRGBO(
        random.nextInt(100),
        random.nextInt(56),
        random.nextInt(256),
        0.1,
      );
    }));
  }
  @override
  void initState() {
    if(!this.mounted){
      changeColors();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BackFloatingButton(),
     body: AnimatedContainer(
       height: MediaQuery.of(context).size.height,
       width:MediaQuery.of(context).size.width,
       color: Colors.white,
       // color: _color,
       child: Center(child: Text("Page coming soon",),),
     duration: Duration(seconds: 4),curve: Curves.fastOutSlowIn,),
    );
  }

}
