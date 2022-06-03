

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/updated_values.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SiteInfluencerWidget extends StatefulWidget {
  ViewSiteDataResponse? viewSiteDataResponse;

  SiteInfluencerWidget({this.viewSiteDataResponse});

  SiteInfluencerWidgetState createState() => SiteInfluencerWidgetState();
}

class SiteInfluencerWidgetState extends State<SiteInfluencerWidget> {
  int initialInfluencerLength = 0;
  List<SiteInfluencerEntity>? siteInfluencerEntity = new List.empty(growable: true);
  List<InfluencerTypeEntity>? influencerTypeEntity = new List.empty(growable: true);
  List<InfluencerCategoryEntity>? influencerCategoryEntity = new List.empty(growable: true);
  List<SiteStageEntity> siteStageEntity = new List.empty(growable: true);
  List<InfluencerEntity>? influencerEntity = new List.empty(growable: true);
  List<InfluencerDetail>? _listInfluencerDetail = new List.empty(growable: true);

  ViewSiteDataResponse? viewSiteDataResponse = new ViewSiteDataResponse();

  setInfluencerData() {
    setState(() {
      viewSiteDataResponse = widget.viewSiteDataResponse;
      influencerTypeEntity = viewSiteDataResponse!.influencerTypeEntity;
      influencerCategoryEntity = viewSiteDataResponse!.influencerCategoryEntity;

      influencerEntity = viewSiteDataResponse!.influencerEntity;
      siteInfluencerEntity = viewSiteDataResponse!.siteInfluencerEntity;

      if (viewSiteDataResponse!.influencerEntity != null &&
          viewSiteDataResponse!.influencerEntity!.length > 0) {
        for (int i = 0; i < viewSiteDataResponse!.influencerEntity!.length; i++) {
          int? originalId;
          for (int j = 0; j < siteInfluencerEntity!.length; j++) {
            if (viewSiteDataResponse!.influencerEntity![i].id ==
                siteInfluencerEntity![j].inflId) {
              viewSiteDataResponse!.influencerEntity![i].isPrimary =
                  siteInfluencerEntity![j].isPrimary;
              originalId = siteInfluencerEntity![j].id;
              break;
            }
          }

          _listInfluencerDetail!.add(new InfluencerDetail(
              originalId: originalId,
              isPrimary: viewSiteDataResponse!.influencerEntity![i].isPrimary,
              isPrimarybool:
                  viewSiteDataResponse!.influencerEntity![i].isPrimary == "Y"
                      ? true
                      : false,
              id: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].id.toString()),
              inflContact: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflContact),
              //createdBy: new TextEditingController(text: viewSiteDataResponse.influencerEntity[i].inflContact),
              inflTypeId: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflTypeId
                      .toString()),
              inflTypeValue: inflTypeValue(new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflTypeId
                      .toString())),
              inflCatId: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflCatId
                      .toString()),
              inflCatValue: inflCatValue(new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflCatId
                      .toString())),
              inflName: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].inflName),
              ilpIntrested: new TextEditingController(
                  text: viewSiteDataResponse!.influencerEntity![i].ilpIntrested),
              createdOn: new TextEditingController(
                  text:
                      viewSiteDataResponse!.influencerEntity![i].createdOn.toString()),
              isExpanded: false));

          UpdatedValues.setSiteInfluencerDetails(_listInfluencerDetail);
        }
        initialInfluencerLength = viewSiteDataResponse!.influencerEntity!.length;
      }

      if(UpdatedValues.getSiteInfluencerDetails()!=null && UpdatedValues.getSiteInfluencerDetails()!.length>0 && (UpdatedValues.getSiteInfluencerDetails()!.length>=_listInfluencerDetail!.length )){
        _listInfluencerDetail = UpdatedValues.getSiteInfluencerDetails();
      }
    });
  }

  @override
  void initState() {
    setInfluencerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return influencerView();
  }

  Widget influencerView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listInfluencerDetail!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_listInfluencerDetail!= null && index>=_listInfluencerDetail!.length) {
                          return const Offstage ();
                        }else{
                        if (!_listInfluencerDetail![index].isExpanded!) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Influencer Details ${(index + 1)} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),



                                  (widget.viewSiteDataResponse?.sitesModal!.isMemberAddded == "A")?
                                  Switch(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value) {
                                          for (int i = 0;
                                              i < _listInfluencerDetail!.length;
                                              i++) {
                                            if (i == index) {
                                              _listInfluencerDetail![i]
                                                  .isPrimarybool = value;
                                            } else {
                                              _listInfluencerDetail![i]
                                                  .isPrimarybool = !value;
                                            }
                                          }
                                        } else {
                                          Get.dialog(CustomDialogs.showMessage(
                                              "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                        }
                                      });
                                    },
                                    value: _listInfluencerDetail![index]
                                        .isPrimarybool!,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                        HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ):
                                  Switch(
                                    onChanged: (value) {
                                      // setState(() {
                                      //   if (value) {
                                      //     for (int i = 0;
                                      //     i < _listInfluencerDetail!.length;
                                      //     i++) {
                                      //       if (i == index) {
                                      //         _listInfluencerDetail![i]
                                      //             .isPrimarybool = value;
                                      //       } else {
                                      //         _listInfluencerDetail![i]
                                      //             .isPrimarybool = !value;
                                      //       }
                                      //     }
                                      //   } else {
                                      //     Get.dialog(CustomDialogs.showMessage(
                                      //         "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                      //   }
                                      // });
                                    },
                                    value: _listInfluencerDetail![index]
                                        .isPrimarybool!,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                    HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),


                                  _listInfluencerDetail![index].isExpanded!
                                      ? TextButton.icon(

                                          icon: Icon(
                                            Icons.remove,
                                            color: HexColor("#F9A61A"),
                                            size: 18,
                                          ),
                                          label: Text(
                                            "COLLAPSE",
                                            style: TextStyle(
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 15),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail![index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail![index]
                                                      .isExpanded!;
                                            });
                                          },
                                        )
                                      : TextButton.icon(
                                          icon: Icon(
                                            Icons.add,
                                            color: HexColor("#F9A61A"),
                                            size: 18,
                                          ),
                                          label: Text(
                                            "EXPAND",
                                            style: TextStyle(
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail![index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail![index]
                                                      .isExpanded!;
                                            });
                                          },
                                        ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Influencer Details ${(index + 1)} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                        SizeConfig.safeBlockHorizontal *
                                            4.8),
                                  ),
                                  _listInfluencerDetail![index].isExpanded!
                                      ? TextButton.icon(
                                    icon: Icon(
                                      Icons.remove,
                                      color: HexColor("#F9A61A"),
                                      size:
                                      SizeConfig.safeBlockHorizontal *
                                          4,
                                    ),
                                    label: Text(
                                      "COLLAPSE",
                                      style: TextStyle(
                                          color: HexColor("#F9A61A"),
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig
                                              .safeBlockHorizontal *
                                              4.5),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _listInfluencerDetail![index]
                                            .isExpanded =
                                        !_listInfluencerDetail![index]
                                            .isExpanded!;
                                      });
                                    },
                                  )
                                      : TextButton.icon(
                                    icon: Icon(
                                      Icons.add,
                                      color: HexColor("#F9A61A"),
                                      size: 18,
                                    ),
                                    label: Text(
                                      "EXPAND",
                                      style: TextStyle(
                                          color: HexColor("#F9A61A"),
                                          fontWeight: FontWeight.bold,
                                          // letterSpacing: 2,
                                          fontSize: 17),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _listInfluencerDetail![index]
                                            .isExpanded =
                                        !_listInfluencerDetail![index]
                                            .isExpanded!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Secondary",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: (value) {
                                      //setState(() {
                                      //   if (value) {
                                      //     for (int i = 0;
                                      //     i < _listInfluencerDetail!.length;
                                      //     i++) {
                                      //       if (i == index) {
                                      //         _listInfluencerDetail![i]
                                      //             .isPrimarybool = value;
                                      //       } else {
                                      //         _listInfluencerDetail![i]
                                      //             .isPrimarybool = !value;
                                      //       }
                                      //     }
                                      //   } else {
                                      //     Get.dialog(
                                      //         CustomDialogs.showMessage(
                                      //             "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                      //   }
                                      // });
                                    },
                                    value: _listInfluencerDetail![index]
                                        .isPrimarybool!,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                    HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Primary",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: _listInfluencerDetail![index]
                                            .isPrimarybool!
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller:
                                _listInfluencerDetail![index].inflContact,
                                maxLength: 10,
                                onChanged: (value) async {
                                  bool match = false;
                                  if (value.length < 10) {
                                    if (_listInfluencerDetail![index].inflName !=
                                        null) {
                                      _listInfluencerDetail![index]
                                          .inflName!
                                          .clear();
                                      _listInfluencerDetail![index]
                                          .inflTypeValue!
                                          .clear();
                                      _listInfluencerDetail![index]
                                          .inflCatValue!
                                          .clear();
                                    }
                                  } else if (value.length == 10) {
                                    for (int i = 0;
                                    i < _listInfluencerDetail!.length - 1;
                                    i++) {
                                      if (value ==
                                          _listInfluencerDetail![i]
                                              .inflContact!
                                              .text) {
                                        match = true;
                                        break;
                                      }
                                    }

                                    if (match) {
                                      Get.dialog(CustomDialogs.showMessage(
                                          "Already added influencer : " +
                                              value));
                                    } else {
                                      String? empId;
                                      Future<SharedPreferences> _prefs =
                                      SharedPreferences.getInstance();
                                      await _prefs
                                          .then((SharedPreferences prefs) {
                                        empId = prefs.getString(
                                            StringConstants.employeeId) ??
                                            "empty";
                                      });
                                      AddLeadsController _addLeadsController =
                                      Get.find();
                                      _addLeadsController.phoneNumber = value;
                                      AccessKeyModel accessKeyModel =
                                      new AccessKeyModel();
                                      await _addLeadsController
                                          .getAccessKeyOnly()
                                          .then((data) async {
                                        accessKeyModel = data;
                                        print("AccessKey :: " +
                                            accessKeyModel.accessKey!);
                                        await _addLeadsController
                                            .getInfNewData(
                                            accessKeyModel.accessKey)
                                            .then((data) {
                                          InfluencerDetailModel
                                          _infDetailModel = data!;
                                          if (_infDetailModel.respCode ==
                                              "DM1002") {
                                            InfluencerModel? inflDetail =
                                                _infDetailModel.influencerModel;
                                            // print(inflDetail.inflName);
                                            setState(() {
                                              if (inflDetail!.inflName !=
                                                  "null") {
                                                _listInfluencerDetail![index]
                                                    .inflContact =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .inflName =
                                                new TextEditingController();
                                                FocusScope.of(context)
                                                    .unfocus();
                                                //  print(inflDetail.inflName.text);
                                                _listInfluencerDetail![index]
                                                    .inflTypeId =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .inflCatId =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .inflTypeValue =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .inflCatValue =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .id =
                                                new TextEditingController();
                                                _listInfluencerDetail![index]
                                                    .ilpIntrested =
                                                new TextEditingController();

                                                // print(inflDetail.inflName);

                                                _listInfluencerDetail![index]
                                                    .inflContact!
                                                    .text =
                                                    inflDetail.inflContact!;
                                                _listInfluencerDetail![index]
                                                    .inflName!
                                                    .text = inflDetail.inflName!;
                                                _listInfluencerDetail![index]
                                                    .id!
                                                    .text =
                                                    inflDetail.inflId
                                                        .toString();
                                                _listInfluencerDetail![index]
                                                    .ilpIntrested!
                                                    .text =
                                                    inflDetail.ilpRegFlag!;
                                                // _listInfluencerDetail[
                                                //             index]
                                                //         .createdOn =
                                                //     inflDetail.createdOn;
                                                _listInfluencerDetail![index]
                                                    .inflTypeValue!
                                                    .text =
                                                    inflDetail
                                                        .influencerTypeText!;
                                                _listInfluencerDetail![index]
                                                    .inflCatValue!
                                                    .text =
                                                    inflDetail
                                                        .influencerCategoryText!;
                                                _listInfluencerDetail![index]
                                                    .createdBy = empId;
                                                print(
                                                    _listInfluencerDetail![index]
                                                        .inflName);
                                                for (int i = 0;
                                                i <
                                                    influencerTypeEntity!
                                                        .length;
                                                i++) {
                                                  if (influencerTypeEntity![i]
                                                      .inflTypeId
                                                      .toString() ==
                                                      inflDetail.inflTypeId
                                                          .toString()) {
                                                    _listInfluencerDetail![index]
                                                        .inflTypeId!
                                                        .text =
                                                        inflDetail.inflTypeId
                                                            .toString();
                                                    //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                    _listInfluencerDetail![index]
                                                        .inflTypeValue!
                                                        .text =
                                                        influencerTypeEntity![
                                                        influencerTypeEntity![
                                                        i]
                                                            .inflTypeId! -
                                                            1]
                                                            .inflTypeDesc!;
                                                    break;
                                                  } else {
                                                    // _listInfluencerDetail[
                                                    // index]
                                                    //     .inflContact
                                                    //     .clear();
                                                    // _listInfluencerDetail[
                                                    // index]
                                                    //     .inflName
                                                    //     .clear();
                                                    _listInfluencerDetail![index]
                                                        .inflTypeId!
                                                        .clear();
                                                    _listInfluencerDetail![index]
                                                        .inflTypeValue!
                                                        .clear();
                                                  }
                                                }
                                                print(
                                                    _listInfluencerDetail![index]
                                                        .inflName);
                                                // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].inflTypeDesc;

                                                for (int i = 0;
                                                i <
                                                    influencerCategoryEntity!
                                                        .length;
                                                i++) {
                                                  if (influencerCategoryEntity![
                                                  i]
                                                      .inflCatId
                                                      .toString() ==
                                                      inflDetail.inflCatId
                                                          .toString()) {
                                                    _listInfluencerDetail![index]
                                                        .inflCatId!
                                                        .text =
                                                        inflDetail.inflCatId
                                                            .toString();
                                                    //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                    _listInfluencerDetail![index]
                                                        .inflCatValue!
                                                        .text =
                                                        influencerCategoryEntity![
                                                        influencerCategoryEntity![
                                                        i]
                                                            .inflCatId! -
                                                            1]
                                                            .inflCatDesc!;
                                                    break;
                                                  } else {
                                                    _listInfluencerDetail![index]
                                                        .inflCatId!
                                                        .clear();
                                                    _listInfluencerDetail![index]
                                                        .inflCatValue!
                                                        .clear();
                                                  }
                                                }
                                              } else {
                                                if (_listInfluencerDetail![index]
                                                    .inflContact !=
                                                    null) {
                                                  _listInfluencerDetail![index]
                                                      .inflContact!
                                                      .clear();
                                                  _listInfluencerDetail![index]
                                                      .inflName!
                                                      .clear();
                                                }
                                                 Get.dialog(
                                                    CustomDialogs.showDialog(
                                                        "No influencer registered with this number"));
                                              }
                                            });
                                          } else {
                                            if (_listInfluencerDetail![index]
                                                .inflContact !=
                                                null) {
                                              _listInfluencerDetail![index]
                                                  .inflContact!
                                                  .clear();
                                              _listInfluencerDetail![index]
                                                  .inflName!
                                                  .clear();
                                            }
                                            return Get.dialog(CustomDialogs
                                                .showDialog(
                                                _infDetailModel.respMsg!));
                                          }
                                          Get.back();
                                        });
                                      });
                                    }
                                  }
                                  // setState(() {
                                  //   _totalBags = value as int;
                                  // });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Influencer Number ';
                                  }

                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        ColorConstants.backgroundColorBlue,
                                        //color: HexColor("#0000001F"),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  labelText: "Mobile Number",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                      ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                //  initialValue: _listInfluencerDetail[index].inflName,
                                controller:
                                _listInfluencerDetail![index].inflName,

                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
                                //   }
                                //
                                //   return null;
                                // },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        ColorConstants.backgroundColorBlue,
                                        //color: HexColor("#0000001F"),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  labelText: "Name",
                                  enabled: false,
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                      ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller:
                                _listInfluencerDetail![index].inflTypeValue,
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
                                //   }
                                //
                                //   return null;
                                // },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        ColorConstants.backgroundColorBlue,
                                        //color: HexColor("#0000001F"),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Type",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                      ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller:
                                _listInfluencerDetail![index].inflCatValue,
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
                                //   }
                                //
                                //   return null;
                                // },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        ColorConstants.backgroundColorBlue,
                                        //color: HexColor("#0000001F"),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.4),
                                        width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Category",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                      ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                            ],
                          );
                        }
                        }
                      }),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Colors.black26)),
                backgroundColor: Colors.transparent,),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
                  child: Text(
                    "ADD MORE INFLUENCER",
                    style: TextStyle(
                        color: HexColor("#1C99D4"),
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 2,
                        fontSize: 17),
                  ),
                ),
                onPressed: () async {
                  // //  print(_listInfluencerDetail[
                  //   _listInfluencerDetail.length - 1]
                  //       .inflName);
                  if (_listInfluencerDetail!.length == 0) {
                    setState(() {
                      _listInfluencerDetail!.add(new InfluencerDetail(
                          isExpanded: true, isPrimarybool: true));
                      UpdatedValues.setSiteInfluencerDetails(
                          _listInfluencerDetail);
                    });
                  } else if (_listInfluencerDetail![
                                  _listInfluencerDetail!.length - 1]
                              .inflName !=
                          null &&
                      _listInfluencerDetail![_listInfluencerDetail!.length - 1]
                              .inflName!
                              .text !=
                          "null" &&
                      !_listInfluencerDetail![_listInfluencerDetail!.length - 1]
                          .inflName!
                          .text
                          .isBlank!) {
                    InfluencerDetail infl = new InfluencerDetail(
                        isExpanded: true, isPrimarybool: false);
                    setState(() {
                      _listInfluencerDetail![_listInfluencerDetail!.length - 1]
                          .isExpanded = false;
                      _listInfluencerDetail!.add(infl);
                      UpdatedValues.setSiteInfluencerDetails(
                          _listInfluencerDetail);
                    });
                  } else {
                    print("Error : Please fill previous influencer first");
                    Get.dialog(CustomDialogs
                        .showMessage("Please fill previous influencer first"));
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#1C99D4"),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 17),
                  ),
                ),
                onPressed: () async {

                  UpdatedValues updateRequest = new UpdatedValues();
                  updateRequest.updateRequest(context);
                },
              ),
            ),
            SizedBox(height: 40),
          ],
        )),
      ),
    );
  }

  inflTypeValue(TextEditingController inflTypeId) {
    for (int i = 0; i < influencerTypeEntity!.length; i++) {
      if (influencerTypeEntity![i].inflTypeId == int.parse(inflTypeId.text)) {
        return new TextEditingController(
            text: influencerTypeEntity![i].inflTypeDesc);
      }
    }
  }

  inflCatValue(TextEditingController inflCatId) {
    for (int i = 0; i < influencerCategoryEntity!.length; i++) {
      if (influencerCategoryEntity![i].inflCatId == int.parse(inflCatId.text)) {
        return new TextEditingController(
            text: influencerCategoryEntity![i].inflCatDesc);
      }
    }
  }
}
