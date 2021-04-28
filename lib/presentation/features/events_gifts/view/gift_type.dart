import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/gifts_controlller.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';

class GiftTypeBottomSheet extends StatelessWidget {
  const GiftTypeBottomSheet({
    Key key,
    @required GiftController giftController,
  }) : _giftController = giftController, super(key: key);

  final GiftController _giftController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: SizeConfig.screenHeight / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Gift type', style: TextStyle(fontSize: 18),),
              Expanded(child: Container())
            ],
          ),
          SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
                itemCount: _giftController.giftTypeModelList.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    decoration: BoxDecoration(border: Border.all(color: HexColor('000000').withOpacity(0.12))),
                    child: ListTile(
                      title: Text('${_giftController.giftTypeModelList[index].giftTypeText} (Bal-${_giftController.giftTypeModelList[index].giftStockInHand})', style: TextStyle(fontSize: 14),),
                      trailing: Icon(Icons.arrow_forward_ios,size: 14,),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
