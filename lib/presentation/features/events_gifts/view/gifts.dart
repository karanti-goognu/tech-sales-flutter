import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/gifts_controlller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gift_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';

class GiftsView extends StatefulWidget {
  @override
  _GiftsViewState createState() => _GiftsViewState();
}

class _GiftsViewState extends State<GiftsView> {
  GiftController _giftController = Get.find();

  TextStyle _myFormFont() {
    return GoogleFonts.roboto(
        color: ColorConstants.inputBoxHintColorDark,
        fontWeight: FontWeight.normal,
        fontSize: 16.0);
  }

  @override
  void initState() {
    _giftController.getGiftStockData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List _giftsCategoriesNameList = [
      'Gift in Hand',
      'Inwarded',
      'Utilized',
      'Balance'
    ];
    final List _giftsCategoriesValueList = [
      _giftController
          .giftStockModelList[_giftController.selectedDropdown].giftInHandQty,
      _giftController
          .giftStockModelList[_giftController.selectedDropdown].giftUtilisedQty,
      _giftController
          .giftStockModelList[_giftController.selectedDropdown].giftUtilisedQty,
      _giftController.giftStockModelList[_giftController.selectedDropdown]
          .giftOpeningStockQty
    ];
    List _giftCategoriesList = [];
    for (int i = 0; i < _giftsCategoriesNameList.length; i++) {
      _giftCategoriesList.add(GiftsCategories(
          _giftsCategoriesNameList[i], _giftsCategoriesValueList[i]));
    }

    return Scaffold(
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Gifts".toUpperCase()),
        backgroundColor: ColorConstants.appBarColor,
        actions: [
          Transform.scale(
            scale: 0.6,
            child: FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                  side: BorderSide(color: Colors.white)),
              color: Colors.transparent,
              child: Text(
                'VIEW LOGS',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                  child: Obx(() => _giftController.giftStockModelList.isEmpty ||
                          _giftController.giftStockModelList == null
                      ? Container()
                      : DropdownButton(
                          value: _giftController
                              .giftStockModelList[_giftController.selectedDropdown].giftTypeId,
                          onChanged: (newValue) {
                            print(newValue);
                            print("Selected dropdown before: ${_giftController.selectedDropdown}");
                            _giftController.selectedDropdown=newValue;
                            print("Selected dropdown after: ${_giftController.selectedDropdown}");
                          },
                          items: _giftController.giftStockModelList
                              .map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                              value: value.giftTypeId,
                              child: Text(
                                value.giftTypeText.toString(),
                                style: _myFormFont(),
                              ),
                            );
                          }).toList(),
                        ))),
            ),
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _giftCategoriesList[index].text,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: index == 0 || index == 3
                                    ? FontWeight.bold
                                    : null),
                          ),
                          Text(
                            _giftCategoriesList[index].count.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(),
                    );
                  },
                  itemCount: _giftCategoriesList.length),
            ),
            RaisedButton(
              onPressed: () => Get.bottomSheet(
                  GiftTypeBottomSheet(giftController: _giftController)),
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
      ),
    );
  }
}

class GiftsCategories {
  int count;
  String text;
  GiftsCategories(this.text, this.count);
}
