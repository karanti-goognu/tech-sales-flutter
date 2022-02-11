import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SiteController _siteController = Get.find();
  final db = BrandNameDBHelper();
  List<DealerForDb> dealerEntityForDb = new List();
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();
  String siteCreationDate, visitRemarks, infName = "";
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  KittyBagsListModel _kittyBagsListModel;
  String claimableKittyBagsAvailable = "0";
  String reservedKittyBagsAvailable = "0";
  ConstStage _selectedConstructionType;
  SiteFloorlist _selectedFloorType;
  bool isExpanded = true;
  String _selectedRadioValue = 'Y';

  getPendingSupplyData() async {
    var data = await _siteController.pendingSupplyDetails(
        widget.supplyHistoryId, widget.siteId);
    // .then((PendingSupplyDetailsEntity data) async { });
    print(data);
    // _selectedConstructionType= _siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.constStage[0];
    print(_selectedConstructionType);
    print(_selectedFloorType);
    // _selectedFloorType= _siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.siteFloorlist[0];
  }

  @override
  void dispose() {
    _siteController.counterId = StringConstants.empty;
    super.dispose();
  }

  getKittyBags(String partyCode) {
    print("Called now");
    //String productCode
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController.getSiteKittyBags(partyCode).then((data) {
                setState(() {
                  if (data != null) {
                    _kittyBagsListModel = data;
                    claimableKittyBagsAvailable =
                        '${_kittyBagsListModel.response.totalKittyBagsForKittyPointsList}';
                    reservedKittyBagsAvailable =
                        '${_kittyBagsListModel.response.totalKittyBagsForReservePoolList}';
                  }
                });
                print('RESPONSE, ${data}');
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
            }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetChecking().then((result) => {
          if (result == true)
            {
              getPendingSupplyData(),
              _appController.getAccessKey(RequestIds.GET_DEALERS_LIST),
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        body: supplyDetailsDataView());
  }

  Widget supplyDetailsDataView() {
    return Obx(
      () => (_siteController == null)
          ? Container(
              child: Center(
                child: Text("Sites controller  is empty!!"),
              ),
            )
          : (_siteController.pendingSupplyDetailsResponse == null)
              ? Container(
                  child: Center(
                    child: Text("Supply detail response  is empty!!"),
                  ),
                )
              : (_siteController.pendingSupplyDetailsResponse
                          .pendingSuppliesDetailsModel ==
                      null)
                  ? Container(
                      child: Center(
                        child: Text("Loading supply detail data..."),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Obx(
                                  //   () => Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 50.0, bottom: 20, left: 0),
                                  //     child: Center(
                                  //       child: Text(
                                  //         _siteController
                                  //                 .pendingSupplyDetailsResponse
                                  //                 .pendingSuppliesDetailsModel
                                  //                 .influencerName ??
                                  //             "",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.normal,
                                  //             fontSize: 20,
                                  //             color: HexColor("#006838"),
                                  //             fontFamily: "Muli"),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, bottom: 10, left: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "SITE INFO : " +
                                              widget.siteId.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: HexColor("#006838"),
                                            fontFamily: "Muli",
                                          ),
                                        ),
                                        (isExpanded)
                                            ? Column(
                                                children: [
                                                  FlatButton.icon(
                                                    color: Colors.transparent,
                                                    icon: Icon(
                                                      Icons.add,
                                                      color:
                                                          HexColor("#F9A61A"),
                                                      size: 18,
                                                    ),
                                                    label: Text(
                                                      "EXPAND",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#F9A61A"),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // letterSpacing: 2,
                                                          fontSize: 15),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        isExpanded =
                                                            !isExpanded;
                                                      });
                                                      // _getCurrentLocation();
                                                    },
                                                  ),
                                                ],
                                              )
                                            : FlatButton.icon(
                                                color: Colors.transparent,
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: HexColor("#F9A61A"),
                                                  size: 18,
                                                ),
                                                label: Text(
                                                  "COLLAPSE",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#F9A61A"),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // letterSpacing: 2,
                                                      fontSize: 15),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isExpanded = !isExpanded;
                                                  });
                                                  // _getCurrentLocation();
                                                },
                                              )
                                      ],
                                    ),
                                  ),
                                  //SizedBox(height: 16),
                                  Visibility(
                                      visible: !isExpanded,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Owner Number : ${_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.siteOwnerNumber ?? ""}"),
                                              Text(
                                                  "Influencer Name : ${_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.influencerName ?? ""}"),
                                              Text(
                                                  "Influencer Number :${_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.influencerContactNumber ?? ""} "),
                                              Text(
                                                  "Request Initiated By : ${_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.requestInitiatedBy ?? ""}"),
                                            ],
                                          ),
                                        ),
                                      )),
                                  //SizedBox(height: 16),
                                  Text(
                                    "Owner Name : ${_siteController.pendingSupplyDetailsResponse.pendingSuppliesDetailsModel.siteOwnerName ?? ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, right: 10),
                                        child: Text(
                                          "Award Loyalty Point",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 'Y',
                                                  groupValue:
                                                      _selectedRadioValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedRadioValue =
                                                          value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      // color: HexColor("#000000DE"),
                                                      fontFamily: "Muli"),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 'N',
                                                  groupValue:
                                                      _selectedRadioValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedRadioValue =
                                                          value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      // color: HexColor("#000000DE"),
                                                      fontFamily: "Muli"),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                  SizedBox(height: 16),
                                  Obx(() => _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .shipToPartyName ==
                                          null
                                      ? DropdownButtonFormField<SiteFloorlist>(
                                          value: _selectedFloorType,
                                          items: _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .siteFloorlist
                                              .map<
                                                      DropdownMenuItem<
                                                          SiteFloorlist>>(
                                                  (SiteFloorlist label) =>
                                                      DropdownMenuItem<
                                                          SiteFloorlist>(
                                                        child: Text(
                                                          label.siteFloorTxt,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: ColorConstants
                                                                  .inputBoxHintColor,
                                                              fontFamily:
                                                                  "Muli"),
                                                        ),
                                                        value: label,
                                                      ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _siteController.floorId =
                                                  value.id;
                                              _selectedFloorType = value;
                                              print(_siteController.floorId);
                                              print(_selectedFloorType.id);
                                              // UpdatedValues.setSiteConstructionId(_selectedConstructionType);
                                            });
                                            print(value.id);
                                          },
                                          decoration: FormFieldStyle
                                              .buildInputDecoration(
                                                  labelText: "Floor"),
                                        )
                                      : TextFormField(
                                          controller: _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .floorText,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter Floor ';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstants
                                                  .inputBoxHintColor,
                                              fontFamily: "Muli"),
                                          readOnly: true,
                                          decoration: FormFieldStyle
                                              .buildInputDecoration(
                                            labelText: "Floor",
                                          ),
                                        )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .shipToPartyName ==
                                          null
                                      ? DropdownButtonFormField<ConstStage>(
                                          value: _selectedConstructionType,
                                          items: _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .constStage
                                              .map<
                                                      DropdownMenuItem<
                                                          ConstStage>>(
                                                  (ConstStage label) =>
                                                      DropdownMenuItem<
                                                          ConstStage>(
                                                        child: Text(
                                                          label
                                                              .constructionStageText,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: ColorConstants
                                                                  .inputBoxHintColor,
                                                              fontFamily:
                                                                  "Muli"),
                                                        ),
                                                        value: label,
                                                      ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedConstructionType = value;
                                              // UpdatedValues.setSiteConstructionId(_selectedConstructionType);
                                            });
                                            print(value.id);
                                            print(_selectedConstructionType
                                                .constructionStageText);
                                          },
                                          decoration: FormFieldStyle
                                              .buildInputDecoration(
                                                  labelText:
                                                      "Stage of Construction"),
                                        )
                                      : TextFormField(
                                          controller: _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .stageConstructionDesc,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter Floor ';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstants
                                                  .inputBoxHintColor,
                                              fontFamily: "Muli"),
                                          readOnly: true,
                                          decoration: FormFieldStyle
                                              .buildInputDecoration(
                                            labelText: "Stage of Construction",
                                          ),
                                        )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => TextFormField(
                                        controller: _siteController
                                            .pendingSupplyDetailsResponse
                                            .pendingSuppliesDetailsModel
                                            .sitePotentialMt,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Site Built-Up Area ';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.number,
                                        //readOnly: true,
                                        decoration:
                                            FormFieldStyle.buildInputDecoration(
                                          labelText: "Stage Potential",
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => TextFormField(
                                        controller: _siteController
                                            .pendingSupplyDetailsResponse
                                            .pendingSuppliesDetailsModel
                                            .brandName,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter brand ';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        decoration:
                                            FormFieldStyle.buildInputDecoration(
                                          labelText: "Brand In Use",
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .shipToPartyName !=
                                          null
                                      ? TextFormField(
                                          controller: _siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .counter,
                                          readOnly: true,
                                          decoration: FormFieldStyle
                                              .buildInputDecoration(
                                            labelText: "Counter",
                                          ),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstants
                                                  .inputBoxHintColor,
                                              fontFamily: "Muli"),
                                        )
                                      : _siteController
                                                  .pendingSupplyDetailsResponse
                                                  .pendingSuppliesDetailsModel
                                                  .requestInitiatedBy ==
                                              "Influencer"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DropdownButtonFormField(
                                                    decoration: FormFieldStyle
                                                        .buildInputDecoration(
                                                            labelText:
                                                                "Counter"),
                                                    items: _addEventController
                                                        .dealerList
                                                        .map<
                                                            DropdownMenuItem<
                                                                dynamic>>((val) {
                                                      return DropdownMenuItem(
                                                        value: val,
                                                        child: SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth -
                                                                100,
                                                            child: Text(
                                                                '${val.dealerName} (${val.dealerId})')),
                                                      );
                                                    }).toList(),
                                                    onChanged: (val) {
                                                      _siteController
                                                              .counterId =
                                                          val.dealerId;
                                                      getKittyBags(
                                                          val.dealerId);
                                                    }),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    "Mandatory",
                                                    style: TextStyle(
                                                      fontFamily: "Muli",
                                                      color: ColorConstants
                                                          .inputBoxHintColorDark,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                  _siteController.counterId.toString().isEmpty
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 20,
                                              left: 5,
                                              right: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Reserved Kitty Bags Available",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            HexColor("#168A08"),
                                                        fontFamily: "Muli"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                          CustomDialogs()
                                                              .showDialogForKittiPoints(
                                                                  _kittyBagsListModel,
                                                                  context),
                                                          barrierDismissible:
                                                              false);
                                                    },
                                                    child: Text(
                                                      reservedKittyBagsAvailable,
                                                      // "${availableKittyPoint1()}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // fontSize: 16,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.blue,
                                                          fontFamily: "Muli"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Claimable Kitty Bags Available",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            HexColor("#168A08"),
                                                        fontFamily: "Muli"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                          CustomDialogs()
                                                              .showDialogForKittiPoints(
                                                                  _kittyBagsListModel,
                                                                  context),
                                                          barrierDismissible:
                                                              false);
                                                    },
                                                    child: Text(
                                                      claimableKittyBagsAvailable,
                                                      // "${availableKittyPoint1()}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // fontSize: 16,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.blue,
                                                          fontFamily: "Muli"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(height: 16),
                                  Obx(() => TextFormField(
                                        controller: _siteController
                                            .pendingSupplyDetailsResponse
                                            .pendingSuppliesDetailsModel
                                            .productName,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter product ';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        decoration:
                                            FormFieldStyle.buildInputDecoration(
                                          labelText: "Product Sold",
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => TextFormField(
                                        controller: _siteController
                                            .pendingSupplyDetailsResponse
                                            .pendingSuppliesDetailsModel
                                            .brandPrice,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Brand Price ';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"[0-9.]")),
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            try {
                                              final text = newValue.text;
                                              if (text.isNotEmpty)
                                                double.parse(text);
                                              return newValue;
                                            } catch (e) {}
                                            return oldValue;
                                          }),
                                        ],
                                        decoration:
                                            FormFieldStyle.buildInputDecoration(
                                          labelText: "Brand Price",
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Mandatory",
                                      style: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10, left: 5),
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
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Obx(() => TextFormField(
                                                readOnly: true,
                                                controller: _siteController
                                                    .pendingSupplyDetailsResponse
                                                    .pendingSuppliesDetailsModel
                                                    .supplyQty,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter Bags ';
                                                  }
                                                  return null;
                                                },
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: ColorConstants
                                                        .inputBoxHintColor,
                                                    fontFamily: "Muli"),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: FormFieldStyle
                                                    .buildInputDecoration(
                                                  labelText: "No. Of Bags",
                                                ),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Obx(() => TextFormField(
                                                controller: _siteController
                                                    .pendingSupplyDetailsResponse
                                                    .pendingSuppliesDetailsModel
                                                    .supplyDate,
                                                readOnly: true,
                                                onChanged: (data) {
                                                  // setState(() {
                                                  //   _contactName.text = data;
                                                  // });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: ColorConstants
                                                        .inputBoxHintColor,
                                                    fontFamily: "Muli"),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .backgroundColorBlue,
                                                        //color: HexColor("#0000001F"),
                                                        width: 1.0),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black26,
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black26,
                                                        width: 1.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.0),
                                                  ),
                                                  labelText: "Date ",
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.date_range_rounded,
                                                      size: 22,
                                                      color: ColorConstants
                                                          .clearAllTextColor,
                                                    ),
                                                    onPressed: () async {
                                                      // final DateTime picked = await showDatePicker(
                                                      //   context: context,
                                                      //   initialDate: DateTime.now(),
                                                      //   firstDate: DateTime(2001),
                                                      //   lastDate: DateTime.now(),
                                                      // );
                                                      //
                                                      // setState(() {
                                                      //   final DateFormat formatter =
                                                      //   DateFormat("yyyy-MM-dd");
                                                      //   if (picked != null) {
                                                      //     final String formattedDate =
                                                      //     formatter.format(picked);
                                                      //     // _supplyDate.text = formattedDate;
                                                      //   }
                                                      // });
                                                    },
                                                  ),
                                                  filled: false,
                                                  focusColor: Colors.black,
                                                  isDense: false,
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Muli",
                                                      color: ColorConstants
                                                          .inputBoxHintColorDark,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0),
                                                  fillColor: ColorConstants
                                                      .backgroundColor,
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
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Mandatory",
                                            style: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          child: Text(
                                            "Mandatory",
                                            style: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 35),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RaisedButton(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, bottom: 5, top: 5),
                                          child: Text(
                                            "REJECT",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        onPressed: () async {
                                          String empId = await getEmpId();
                                          if (_siteController
                                                  .pendingSupplyDetailsResponse
                                                  .pendingSuppliesDetailsModel
                                                  .shipToPartyName ==
                                              null) {
                                            if (_selectedFloorType == null) {
                                              Get.dialog(CustomDialogs()
                                                  .showMessage(
                                                      "Please select Floor !"));
                                              return;
                                            }
                                            if (_selectedConstructionType ==
                                                null) {
                                              Get.dialog(CustomDialogs()
                                                  .showMessage(
                                                      "Please select a Construction Stage !"));
                                              return;
                                            }

                                            if (_siteController
                                                    .pendingSupplyDetailsResponse
                                                    .pendingSuppliesDetailsModel
                                                    .requestInitiatedBy ==
                                                "Influencer") {
                                              if (_siteController.counterId
                                                  .toString()
                                                  .isEmpty) {
                                                Get.dialog(CustomDialogs()
                                                    .showMessage(
                                                        "Please select a Counter !"));
                                                return;
                                              }
                                            } else {
                                              _siteController.counterId = "";
                                            }
                                          } else if (_siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .brandPrice
                                              .text
                                              .isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Please enter brand price !"));
                                            return;
                                          }

                                          if (_siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .supplyQty
                                              .text
                                              .isEmpty) {
                                            Get.dialog(CustomDialogs()
                                                .showMessage(
                                                    "Please enter supply qty !"));
                                            return;
                                          }

                                          if (empId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Please enter reference Id!"));
                                            return;
                                          }

                                          if (widget.siteId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Site id can't be null or empty!"));
                                            return;
                                          }

                                          if (widget.supplyHistoryId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "supplyHistory id can't be null or empty!"));
                                            return;
                                          }

                                          final Map<String, dynamic> jsonData =
                                              {
                                            "approveOrReject": "R",
                                            "floor": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .floorText
                                                .text,
                                            "floorId":
                                                _selectedFloorType == null
                                                    ? null
                                                    : _siteController.floorId,
                                            "brandPrice": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .brandPrice
                                                .text,
                                            "referenceId": empId,
                                            "siteId": widget.siteId,
                                            "supplyHistoryId":
                                                widget.supplyHistoryId,
                                            "supplyQty": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .supplyQty
                                                .text,
                                            "consStageText":
                                                _selectedConstructionType ==
                                                        null
                                                    ? ""
                                                    : _selectedConstructionType
                                                        .constructionStageText,
                                            "consStageId":
                                                _selectedConstructionType ==
                                                        null
                                                    ? null
                                                    : _selectedConstructionType
                                                        .id,
                                            "counterId":
                                                _siteController.counterId,
                                            "awardLoyaltyPoint":
                                                _selectedRadioValue,
                                          };
                                          print(jsonEncode(jsonData));
                                          _siteController
                                              .updatePendingSupplyDetails(
                                                  jsonData);
                                        },
                                      ),
                                      RaisedButton(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        color: HexColor("#1C99D4"),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, bottom: 5, top: 5),
                                          child: Text(
                                            "ACCEPT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        onPressed: () async {
                                          String empId = await getEmpId();
                                          if (_siteController
                                                  .pendingSupplyDetailsResponse
                                                  .pendingSuppliesDetailsModel
                                                  .shipToPartyName ==
                                              null) {
                                            if (_selectedFloorType == null) {
                                              Get.dialog(CustomDialogs()
                                                  .showMessage(
                                                      "Please select Floor !"));
                                              return;
                                            }
                                            if (_selectedConstructionType ==
                                                null) {
                                              Get.dialog(CustomDialogs()
                                                  .showMessage(
                                                      "Please select a Construction Stage !"));
                                              return;
                                            }
                                            if (_siteController
                                                    .pendingSupplyDetailsResponse
                                                    .pendingSuppliesDetailsModel
                                                    .requestInitiatedBy ==
                                                "Influencer") {
                                              if (_siteController.counterId
                                                  .toString()
                                                  .isEmpty) {
                                                Get.dialog(CustomDialogs()
                                                    .showMessage(
                                                        "Please select a Counter !"));
                                                return;
                                              } else {
                                                _siteController.counterId = "";
                                              }
                                            }
                                          } else if (_siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .brandPrice
                                              .text
                                              .isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Please enter brand price !"));
                                            return;
                                          }

                                          if (_siteController
                                              .pendingSupplyDetailsResponse
                                              .pendingSuppliesDetailsModel
                                              .supplyQty
                                              .text
                                              .isEmpty) {
                                            Get.dialog(CustomDialogs()
                                                .showMessage(
                                                    "Please enter supply qty !"));
                                            return;
                                          }

                                          if (empId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Please enter reference Id!"));
                                            return;
                                          }

                                          if (widget.siteId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "Site id can't be null or empty!"));
                                            return;
                                          }

                                          if (widget.supplyHistoryId.isEmpty) {
                                            Get.dialog(CustomDialogs().showMessage(
                                                "supplyHistory id can't be null or empty!"));
                                            return;
                                          }
                                          final Map<String, dynamic> jsonData =
                                              {
                                            "approveOrReject": "A",
                                            "floor": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .floorText
                                                .text,
                                            "floorId":
                                                _selectedFloorType == null
                                                    ? null
                                                    : _siteController.floorId,
                                            "brandPrice": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .brandPrice
                                                .text,
                                            "referenceId": empId,
                                            "siteId": widget.siteId,
                                            "supplyHistoryId":
                                                widget.supplyHistoryId,
                                            "supplyQty": _siteController
                                                .pendingSupplyDetailsResponse
                                                .pendingSuppliesDetailsModel
                                                .supplyQty
                                                .text,
                                            "consStageText":
                                                _selectedConstructionType ==
                                                        null
                                                    ? ""
                                                    : _selectedConstructionType
                                                        .constructionStageText,
                                            "consStageId":
                                                _selectedConstructionType ==
                                                        null
                                                    ? null
                                                    : _selectedConstructionType
                                                        .id,
                                            "counterId":
                                                _siteController.counterId,
                                            "awardLoyaltyPoint":
                                                _selectedRadioValue
                                          };
                                          print(jsonEncode(jsonData));
                                          _siteController
                                              .updatePendingSupplyDetails(
                                                  jsonData);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 40),
                                ]),
                          ),
                        ),
                      ),
                    ),
    );
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }
}
