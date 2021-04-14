import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';

class GiftType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: SizeConfig.screenHeight / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Gift type'),
          Expanded(
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(border: Border.all(color: HexColor('000000').withOpacity(0.12))),
                    child: ListTile(
                      title: Text("Gift Type Text"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
