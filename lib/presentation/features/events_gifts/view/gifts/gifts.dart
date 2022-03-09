import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/gifts_controlller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gifts/gift_type.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gifts/view_logs.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:intl/intl.dart';

class GiftsView extends StatefulWidget {
  @override
  _GiftsViewState createState() => _GiftsViewState();
}

class _GiftsViewState extends State<GiftsView> {
  GiftController _giftController = Get.find();
  final List _giftsCategoriesNameList = [
    'Opening Stock',
    'Stock In Hand',
    'Utilized'
  ];
  String giftTypeText,_giftInHandQty;
  List _giftsCategoriesValueList = [];
  List _giftCategoriesList = [];
  TextEditingController _comments = TextEditingController();
  TextEditingController _giftInHandQtyNew = TextEditingController();

  addDateForGiftsView() async {
    _giftsCategoriesValueList = [];
    _giftCategoriesList = [];
    _giftsCategoriesValueList = [
      _giftController.giftStockModelList[_giftController.selectedDropdown].giftOpeningStockQty,
      _giftController.giftStockModelList[_giftController.selectedDropdown].giftInHandQty,
      _giftController.giftStockModelList[_giftController.selectedDropdown].giftUtilisedQty
    ];
    for (int i = 0; i < _giftsCategoriesNameList.length; i++) {
      _giftCategoriesList.add(GiftsCategories(
          _giftsCategoriesNameList[i], _giftsCategoriesValueList[i]));
     // print("print ->"+_giftCategoriesList[i].count.toString()+" "+_giftCategoriesList[i].text+",,"+_giftController.selectedDropdown.toString()+".."+ _giftController.giftStockModelList[0].giftInHandQty.toString()+" "+_giftController.giftStockModelList[1].giftInHandQty.toString()+"  "+_giftController.giftStockModelList[2].giftInHandQty.toString());
    }
    _giftInHandQtyNew.text=_giftCategoriesList[1].count.toString();
    _giftInHandQty=_giftCategoriesList[1].count.toString();
    setState(() {

    });
  }

  TextStyle _myFormFont() {
    return GoogleFonts.roboto(
        color: ColorConstants.inputBoxHintColorDark,
        fontWeight: FontWeight.normal,
        fontSize: 16.0);
  }

  @override
  void initState() {
    _giftController.getGiftStockData().whenComplete(() => addDateForGiftsView());
    final DateFormat formatter = DateFormat("MMMM");
    DateTime date = DateTime.now();
    var currentMonth = formatter.format(date);
    _giftController.monthYear='$currentMonth-${date.year.toString().substring(2)}';
//    _giftController.getViewLogsData("${_giftController.monthYear}");
    super.initState();
  }

  @override
  void dispose() {
    // _giftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.appBarColor,
        title: Text("Gifts".toUpperCase()),
        actions: [
          Transform.scale(
            scale: 0.6,
            child: TextButton(
              onPressed: () {
                Get.to(() => ViewLogs());
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    side: BorderSide(color: Colors.white)),
              ),
              child: Text(
                'VIEW LOGS',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12)]
              ),
              child: DropdownButtonHideUnderline(
                  child: Obx(() => _giftController.giftStockModelList.isEmpty ||
                          _giftController.giftStockModelList == null
                      ? Container()
                      : DropdownButton(
                          onChanged: (newValue) {
                            var x = _giftController.giftStockModelList
                                .toList()
                                .indexWhere((e) {
                              return e.giftTypeId == newValue;
                            });
                            setState(() {
                              _giftController.selectedDropdown = newValue;
                              giftTypeText = _giftController
                                  .giftStockModelList[x].giftTypeText;
                              _giftController.getGiftStockData().whenComplete(() => addDateForGiftsView());
                            });

                          },
                    value: _giftController.selectedDropdown,
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
              height: 10,
            ),
            Flexible(
                child:  ListView.separated(
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
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),

                            index == 1 && _giftController.selectedDropdown!=0
                                ? Container(
                                    padding: EdgeInsets.zero,
                                    width: 70,
                                    height: 40,
                                    child:
                                    TextFormField(
                                      controller: _giftInHandQtyNew,
                                      textAlign: TextAlign.right,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: '',
                                      ),
//                                      initialValue: _giftCategoriesList[index].count.toString(),
                                    ))
                                : Text(
                                    _giftCategoriesList[index].count.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
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
                    itemCount: _giftCategoriesList.length)),
            SizedBox(
              height: 14,
            ),
            Obx(
              () => _giftController.selectedDropdown == 0
                  ? Container()
                  : Container(
                color: Colors.white,
                    child: TextFormField(
                        controller: _comments,
//                        maxLength: 100,
                        onChanged: (value) async {},
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Comments"),
                      ),
                  ),
            ),
            SizedBox(
              height: 14,
            ),
            // RaisedButton(
            //   onPressed: () => _giftController.selectedDropdown == 0
            //       ? Get.bottomSheet(GiftTypeBottomSheet(giftController: _giftController),)
            //       : _giftController.addGiftStock(
            //           comment: _comments.text,
            //           giftTypeId: _giftController.selectedDropdown.toString(),
            //           giftTypeText: giftTypeText,giftInHandQty: _giftInHandQty, giftInHandQtyNew:_giftInHandQtyNew.text
            //
            //   ),
            //   color: HexColor("#1C99D4"),
            //   child: Text(
            //     "Update Inventory",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         // letterSpacing: 2,
            //         fontSize: 17),
            //   ),
            // ),
            buildBody(context),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(context){
    return Container(
      child: StatefulBuilder( builder: (BuildContext context, StateSetter setstates){
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: HexColor("#1C99D4"),
          ),
          onPressed: () => _giftController.selectedDropdown == 0
              ?
          _settingModalBottomSheet(context,setstates)
              : _giftInHandQtyNew.text.isEmpty?
          Get.dialog(CustomDialogs().showMessage("Please enter value"))
          :Get.dialog(showConfirmationDialog("Are you sure you want to submit this entry? ")),
          child: Text(
            "Update Inventory",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // letterSpacing: 2,
                fontSize: 17),
          ),
        );
      },
      ),
    );
  }

  void _settingModalBottomSheet(context,StateSetter setstates) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return GiftTypeBottomSheet(giftController: _giftController,setstates:setstates);
        }).whenComplete(() {

      _giftController.getGiftStockData().whenComplete(() => addDateForGiftsView());

    });
  }

  Widget showConfirmationDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  height: 1.4,
                  letterSpacing: .25,
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Yes',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                // fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            _giftController.addGiftStock(
                comment: _comments.text,
                giftTypeId: _giftController.selectedDropdown.toString(),
                giftTypeText: giftTypeText,giftInHandQty: _giftInHandQty, giftInHandQtyNew:_giftInHandQtyNew.text

            );
          }
        ),
        TextButton(
          child: Text(
            'NO',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                //  fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

}


class GiftsCategories {
  int count;
  String text;
  GiftsCategories(this.text, this.count);
}
