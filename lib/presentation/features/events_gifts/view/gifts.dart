import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gift_type.dart';


class GiftsView extends StatelessWidget {

  final List _giftsCategoriesList=[
    GiftsCategories('Gift in Hand', 0),
    GiftsCategories('Inwarded', 0),
    GiftsCategories('Utilized', 0),
    GiftsCategories('Balance', 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gifts".toUpperCase()),
        backgroundColor: ColorConstants.appBarColor ,
        actions: [
          FlatButton(
            onPressed: () {
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
                side: BorderSide(color: Colors.white)),
            color: Colors.transparent,
            child: Text(
              'VIEW LOGS',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            _giftsCategoriesList[index].text
                        ),
                        Text(_giftsCategoriesList[index].count.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,),)
                      ],
                    ),
                  );
                }, separatorBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(),
                  );
            }, itemCount: _giftsCategoriesList.length),
          ),
          RaisedButton(
            onPressed: ()=>Get.bottomSheet(GiftType()),
            color: HexColor("#1C99D4"),
            child: Text(
              "Update Inventory",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}

class GiftsCategories{
  int count;
  String text;
  GiftsCategories(this.text, this.count);

}