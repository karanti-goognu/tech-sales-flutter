import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PendingSupplyDetailScreen extends StatefulWidget {
  String siteId;
  String supplyHistoryId;

  PendingSupplyDetailScreen({this.siteId, this.supplyHistoryId});

  @override
  _PendingSupplyDetailScreenState createState() =>
      _PendingSupplyDetailScreenState();
}

class _PendingSupplyDetailScreenState extends State<PendingSupplyDetailScreen>
    with SingleTickerProviderStateMixin {
  String geoTagType;

  String siteCreationDate, visitRemarks;
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  var _supplyFloor = new TextEditingController();
  var _supplyStageOfConstruction = new TextEditingController();
  var _supplyStagePotential = new TextEditingController();
  var _supplyBrandInUse = new TextEditingController();
  var _supplyProductSold = new TextEditingController();
  var _supplyBrandPrice = new TextEditingController();
  var _supplyNoOfBags = new TextEditingController();
  var _supplyDate = new TextEditingController();


  SiteController _siteController = Get.find();


  PendingSupplyDetailsEntity pendingSupplyDetailsEntity;

   getPendingSupplyData() async {
    await _siteController
        .pendingSupplyDetails(widget.supplyHistoryId, widget.siteId)
        .then((data) async {
      setState(() {
          pendingSupplyDetailsEntity = data ;
         // print("Data-->" + json.encode(pendingSupplyDetailsEntity));
        // if(pendingSupplyDetailsEntity!=null){
        //
        //   if(pendingSupplyDetailsEntity.pendingSuppliesDetailsModel!=null){
        //     _supplyFloor.text = data.pendingSuppliesDetailsModel.floorText;
        //     _supplyStageOfConstruction.text = data.pendingSuppliesDetailsModel.stageConstructionDesc;
        //     _supplyStagePotential.text = data.pendingSuppliesDetailsModel.sitePotentialMt;
        //     _supplyBrandInUse.text = data.pendingSuppliesDetailsModel.brandName;
        //     _supplyProductSold.text = data.pendingSuppliesDetailsModel.productName;
        //     _supplyBrandPrice.text = data.pendingSuppliesDetailsModel.brandPrice;
        //     _supplyNoOfBags.text = data.pendingSuppliesDetailsModel.supplyQty;
        //     _supplyDate.text = data.pendingSuppliesDetailsModel.supplyDate;
        //   }
        // }
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPendingSupplyData();
    // internetChecking().then((result) => {
    //   if (result == true)
    //     {
    //       getPendingSupplyData()
    //     }
    //   else
    //     {
    //       Get.snackbar(
    //           "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
    //           colorText: Colors.white,
    //           backgroundColor: Colors.red,
    //           snackPosition: SnackPosition.BOTTOM),
    //       // fetchSiteList()
    //     }
    // });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
//            resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 15),
          child: Text(
            "Influencer Name ",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: HexColor("#006838"),
                fontFamily: "Muli"),
          ),
        ),
      ),
      body:visitDataView()
    );
  }

  Widget visitDataView() {
    return SingleChildScrollView(
        child: Container(
            child: Form(
                child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Site ID: " + widget.siteId.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: "Muli",
              ),
            ),
            SizedBox(height: 16),
            Obx(() =>TextFormField(
              controller: _supplyFloor..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.floorText:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Floor ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Floor",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16),
              Obx(() =>TextFormField(
              controller: _supplyStageOfConstruction..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.stageConstructionDesc:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Floor ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Stage of Construction",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16),
              Obx(() => TextFormField(
              controller: _supplyStagePotential..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.sitePotentialMt:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Site Built-Up Area ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Stage Potential",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16),
              Obx(() => TextFormField(
              controller: _supplyBrandInUse..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.brandName:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter brand ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Brand In Use",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16),
              Obx(() => TextFormField(
              controller: _supplyProductSold..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.productName:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Product Sold",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 16),
              Obx(() => TextFormField(
              controller: _supplyBrandPrice..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.brandPrice:"",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Brand Price ';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  try {
                    final text = newValue.text;
                    if (text.isNotEmpty) double.parse(text);
                    return newValue;
                  } catch (e) {}
                  return oldValue;
                }),
              ],
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Brand Price",
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Mandatory",
                style: TextStyle(
                  fontFamily: "Muli",
                  color: ColorConstants.inputBoxHintColorDark,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
              child: Text(
                "No. of Bags Supplied",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    // color: HexColor("#000000DE"),
                    fontFamily: "Muli"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Obx(() =>TextFormField(
                      controller: _supplyNoOfBags..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.supplyQty:"",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Bags ';
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "No. Of Bags",
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child:Obx(() => TextFormField(
                      controller: _supplyDate..text=_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel!=null?_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.supplyDate:"",
                      readOnly: true,
                      onChanged: (data) {
                        // setState(() {
                        //   _contactName.text = data;
                        // });
                      },
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Date ",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          ),
                          onPressed: () async {
                            print("here");
                            final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime.now(),
                            );

                            setState(() {
                              final DateFormat formatter =
                                  DateFormat("yyyy-MM-dd");
                              if (picked != null) {
                                final String formattedDate =
                                    formatter.format(picked);
                                // _supplyDate.text = formattedDate;
                              }
                            });
                          },
                        ),
                        filled: false,
                        focusColor: Colors.black,
                        isDense: false,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Mandatory",
                      style: TextStyle(
                        fontFamily: "Muli",
                        color: ColorConstants.inputBoxHintColorDark,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Mandatory",
                      style: TextStyle(
                        fontFamily: "Muli",
                        color: ColorConstants.inputBoxHintColorDark,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    child: Text(
                      "REJECT",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  onPressed: () async {},
                ),
                RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: HexColor("#1C99D4"),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
                    child: Text(
                      "ACCEPT",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  onPressed: () async {
                    print("Data1"+_supplyFloor.text);
                  },
                )
              ],
            ),
            SizedBox(height: 40),
          ]),
    ))));
  }

}