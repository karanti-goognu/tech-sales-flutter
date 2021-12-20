import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SiteFilterWidget extends StatefulWidget {
  SiteDistrictListModel siteDistrictListModel;

  SiteFilterWidget({this.siteDistrictListModel});
  @override
  _SiteFilterWidgetState createState() => _SiteFilterWidgetState();
}

class _SiteFilterWidgetState extends State<SiteFilterWidget> {
  SiteController _siteController = Get.find();
  AppController _appController = Get.find();
  SplashController _splashController = Get.find();
  List<SitesEntity> siteList = new List();

  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(0),
          topRight: const Radius.circular(0),
        ),
      ),
      child: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              bottomSheetTop(),
              Container(
                height: 1.0,
                width: SizeConfig.screenWidth,
                color: ColorConstants.lineColorFilter,
              ),
              bodyOfBottomSheet(),
            ],
          ),
        ),
        bottomOfBottomSheet(),
      ]),
    );
  }

  Widget bottomSheetTop() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Filters",
              style: TextStyles.mulliBold18,
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  size: 24,
                ),
              )),
        ],
      ),
    );
  }

  Widget bodyOfBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: ColorConstants.lightGeyColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      _siteController.selectedPosition = 0;
                    },
                    child: returnSelectedWidget("Assign Date", 0)),
                /*GestureDetector(
                    onTap: () {
                      _siteController.selectedPosition = 1;
                    },
                    child: returnSelectedWidget("Type of site", 1)),*/
                GestureDetector(
                    onTap: () {
                      _siteController.selectedPosition = 1;
                    },
                    child: returnSelectedWidget("Site Stage", 1)),
                GestureDetector(
                    onTap: () {
                      _siteController.selectedPosition = 2;
                    },
                    child: returnSelectedWidget("Site Status", 2)),
                GestureDetector(
                  onTap: () {
                    _siteController.selectedPosition = 3;
                  },
                  child: returnSelectedWidget("Pincode", 3),
                ),
                GestureDetector(
                  onTap: () {
                    _siteController.selectedPosition = 4;
                  },
                  child: returnSelectedWidget("Influencer Cat.", 4),
                ),
                GestureDetector(
                  onTap: () {
                    _siteController.selectedPosition = 5;
                  },
                  child: returnSelectedWidget("District", 5),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 1,
            color: ColorConstants.lineColorFilter,
          ),
          new Expanded(
              flex: 2,
              child:
                  returnSelectedWidgetBody(_siteController.selectedPosition)),
        ],
      ),
    );
  }

  Widget bottomOfBottomSheet() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 1.0,
            width: SizeConfig.screenWidth,
            color: ColorConstants.lineColorFilter,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 8, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _siteController.isFilterApplied = false;
                    //Navigator.pop(context);
                    _siteController.selectedSiteStage = StringConstants.empty;
                    _siteController.selectedSiteStageValue =
                        StringConstants.empty;
                    _siteController.selectedSiteStatus = StringConstants.empty;
                    _siteController.selectedSiteStatusValue =
                        StringConstants.empty;
                    _siteController.selectedSiteInfluencerCat =
                        StringConstants.empty;
                    _siteController.selectedSiteInfluencerCatValue =
                        StringConstants.empty;
                    _siteController.assignToDate = StringConstants.empty;
                    _siteController.assignFromDate = StringConstants.empty;
                    _siteController.selectedSitePincode = StringConstants.empty;
                    _siteController.selectedSiteDistrict = StringConstants.empty;
                    _siteController.selectedFilterCount = 0;
                    _siteController.offset = 0;
                    _siteController.sitesListResponse.sitesEntity = null;
                    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
                    // _siteController.getAccessKey(RequestIds.GET_SITES_LIST);
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyles.mulliBoldYellow18,
                  ),
                ),
                Spacer(),
                RaisedButton(
                  onPressed: () {
                    // setState(() {
                    Navigator.pop(context, siteList);
                    _siteController.isFilterApplied = true;
                    _siteController.offset = 0;
                    _siteController.sitesListResponse.sitesEntity = null;
                    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
                    // _siteController.offset = 0;
                    //_siteController.getAccessKey(RequestIds.GET_SITES_LIST);
                    // });
                  },
                  color: ColorConstants.buttonNormalColor,
                  child: Text(
                    "APPLY",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget returnSelectedWidget(String text, int position) {
    return Obx(() => Container(
          // height: 50,
          color: (_siteController.selectedPosition == position)
              ? Colors.white
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (_siteController.selectedPosition == position)
                  ? Container(
                      width: 5,
                      height: 50,
                      color: ColorConstants.clearAllTextColor,
                    )
                  : Container(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                  child: Text(
                    text,
                    style: (_siteController.selectedPosition == position)
                        ? TextStyles.mulliBold14
                        : TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget returnSelectedWidgetBody(int position) {
    return Obx(
      () => Container(
        height: double.maxFinite,
        color: Colors.white,
        child: (_siteController.selectedPosition == 0)
            ? returnAssignDateBody()
            : (_siteController.selectedPosition == 1)
                ? returnLeadStageBody()
                : (_siteController.selectedPosition == 2)
                    ? returnLeadStatusBody()
                    : (_siteController.selectedPosition == 3)
                        ? returnPincodeBody()
                        //  :returnSiteInfluencerBody()

                        : (_siteController.selectedPosition == 4)
                            ? returnSiteInfluencerBody()
                            : returnDistrictBody(),
      ),
    );
  }

  Widget returnAssignDateBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 28, 18, 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(19, 0, 19, 6),
              child: Text(
                "From Date",
                style: TextStyles.robotoRegular14,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                width: double.infinity,
                height: 51,
                decoration: myBoxDecoration(),
                //       <--- BoxDecoration here
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${_siteController.assignFromDate}",
                          style: TextStyles.robotoBold16,
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            _selectDate(context, "from", DateTime(2015, 8));
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          ),
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(19, 31, 19, 6),
              child: Text(
                "To Date",
                style: TextStyles.robotoRegular14,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                width: double.infinity,
                height: 51,
                decoration: myBoxDecoration(),
                //       <--- BoxDecoration here
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${_siteController.assignToDate}",
                          style: TextStyles.robotoBold16,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            if (_siteController.assignFromDate ==
                                StringConstants.empty) {
                              print('From date is empty');
                            } else {
                              String fromDate = _siteController.assignFromDate;
                              List<String> toDate = fromDate.split("-");
                              int intYear = int.parse(toDate[0]);
                              int intMonth = int.parse(toDate[1]);
                              int intDay = int.parse(toDate[2]);
                              _selectDate(context, "to",
                                  DateTime(intYear, intMonth, intDay));
                            }
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          )),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget returnLeadStageBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _splashController.splashDataModel.siteStageEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return leadStageListTile(
                  _splashController
                      .splashDataModel.siteStageEntity[index].siteStageDesc,
                  _splashController.splashDataModel.siteStageEntity[index].id
                      .toString());
            }));
  }

  Widget leadStageListTile(String stageValue, String leadStageValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(stageValue),
          leading: Obx(
            () => Radio(
              value: stageValue,
              groupValue: _siteController.selectedSiteStage as String,
              onChanged: (String value) {
                if (_siteController.selectedSiteStage ==
                    StringConstants.empty) {
                  _siteController.selectedFilterCount =
                      _siteController.selectedFilterCount + 1;
                }
                _siteController.selectedSiteStage = value;
                _siteController.selectedSiteStageValue = leadStageValue;
                fetchFilterData("", "", leadStageValue, "", "", "");
                // _siteController.getSitesData(this._appController.accessKeyResponse.accessKey);
                _siteController.offset = 0;
                _siteController.sitesListResponse.sitesEntity = null;
                _appController.getAccessKey(RequestIds.GET_SITES_LIST);
                // _siteController.getAccessKey(RequestIds.GET_SITES_LIST);
              },
            ),
          )),
    );
  }

  Widget returnLeadStatusBody() {
    return Container(
        height: (SizeConfig.blockSizeVertical),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 28),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount:
                _splashController.splashDataModel.siteStatusEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return leadStatusListTile(
                  _splashController
                      .splashDataModel.siteStatusEntity[index].siteStatusDesc,
                  _splashController.splashDataModel.siteStatusEntity[index].id
                      .toString());
            }));
  }

  Widget leadStatusListTile(String statusValue, String leadStatusValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(statusValue),
          leading: Obx(
            () => Radio(
              value: statusValue,
              groupValue: _siteController.selectedSiteStatus as String,
              onChanged: (String value) {
                if (_siteController.selectedSiteStatus ==
                    StringConstants.empty) {
                  _siteController.selectedFilterCount =
                      _siteController.selectedFilterCount + 1;
                }
                _siteController.selectedSiteStatus = value;
                _siteController.selectedSiteStatusValue = leadStatusValue;
                _siteController.offset = 0;
                _siteController.sitesListResponse.sitesEntity = null;
                _appController.getAccessKey(RequestIds.GET_SITES_LIST);
                // _siteController.getAccessKey(RequestIds.GET_SITES_LIST);
              },
            ),
          )),
    );
  }

  Widget returnPincodeBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 28, 18, 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Pincode",
              style: TextStyles.robotoRegular14,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 10, 10),
              width: double.infinity,
              height: 100,
              //       <--- BoxDecoration here
              child: TextFormField(
                onChanged: (_) {
                  _siteController.selectedSitePincode = _;
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.phone,
                maxLength: 6,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.focusedInputTextColor,
                        width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.4),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.4),
                        width: 1.0),
                  ),
                  labelText: "Enter the Pincode",
                  filled: true,
                  focusColor: Colors.black,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
          ],
        ));
  }

  Widget returnSiteInfluencerBody() {
    return Container(
        height: (SizeConfig.blockSizeVertical),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 28),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _splashController
                .splashDataModel.influencerCategoryEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return siteInfluencerListTile(
                  _splashController.splashDataModel
                      .influencerCategoryEntity[index].inflCatDesc,
                  _splashController
                      .splashDataModel.influencerCategoryEntity[index].inflCatId
                      .toString());
            }));
  }

  Widget siteInfluencerListTile(String statusValue, String siteStatusValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(statusValue),
          leading: Obx(
            () => Radio(
              value: statusValue,
              groupValue: _siteController.selectedSiteInfluencerCat as String,
              onChanged: (String value) {
                if (_siteController.selectedSiteInfluencerCat ==
                    StringConstants.empty) {
                  _siteController.selectedFilterCount =
                      _siteController.selectedFilterCount + 1;
                }
                _siteController.selectedSiteInfluencerCat = value;
                _siteController.selectedSiteInfluencerCatValue =
                    siteStatusValue;
                _siteController.offset = 0;
                _siteController.sitesListResponse.sitesEntity = null;
                _appController.getAccessKey(RequestIds.GET_SITES_LIST);
                // _siteController.getAccessKey(RequestIds.GET_SITES_LIST);
              },
            ),
          )),
    );
  }

  Widget returnDistrictBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 28, 18, 28),
        child: DropdownButtonFormField(
          onChanged: (_) {
            //setState(() {
            if (_siteController.selectedSiteDistrict ==
                StringConstants.empty) {
              _siteController.selectedFilterCount =
                  _siteController.selectedFilterCount + 1;
              }
              _siteController.selectedSiteDistrict = _;
              _siteController.isFilterApplied = true;
                _siteController.offset = 0;
                _siteController.sitesListResponse.sitesEntity = null;
                _appController.getAccessKey(RequestIds.GET_SITES_LIST);
           // });
          },
          items: (widget.siteDistrictListModel == null ||
              widget.siteDistrictListModel.districtList == null)
              ? []
                  : widget.siteDistrictListModel.districtList
              .map((e) =>DropdownMenuItem(
                    value: e.name,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(e.name)),
          ))
              .toList(),
          style: FormFieldStyle.formFieldTextStyle,
          decoration: FormFieldStyle.buildInputDecoration(labelText: "District"),
          //validator: (value) => value == null ? 'Please select member type' : null,
        ),
   );
  }


  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  Future<void> _selectDate(
      BuildContext context, String type, DateTime fromDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: fromDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        if (type == "to") {
          _siteController.assignToDate = formattedDate;
        } else {
          _siteController.assignFromDate = formattedDate;
        }
        selectedDateString = formattedDate;
      });
  }

  List<SitesEntity> fetchFilterData(
      String assignDateFromReq,
      String assignDateToReq,
      String siteStageReq,
      String siteStatusReq,
      String sitePincodeReq,
      String siteInflCatReq,
     // String siteDistrictReq
      ) {
    String appendQuery = "";
    String whereArgs = "";
    final db = SiteListDBHelper();
    if (assignDateFromReq != null && assignDateFromReq != "") {
      appendQuery == ""
          ? appendQuery = "siteCreationDate>=?"
          : appendQuery = appendQuery + "and siteCreationDate>=?";
      whereArgs == ""
          ? whereArgs = "'" + assignDateFromReq + "'"
          : whereArgs = whereArgs + "'" + assignDateFromReq + "'" + ",";
    }

    if (assignDateToReq != null && assignDateToReq != "") {
      appendQuery == ""
          ? appendQuery = "siteCreationDate<=?"
          : appendQuery = appendQuery + " and siteCreationDate<=?";
      whereArgs == ""
          ? whereArgs = "'" + assignDateToReq + "'"
          : whereArgs = whereArgs + "'" + assignDateToReq + "'" + ",";
    }

    if (siteStageReq != null && siteStageReq != "") {
      appendQuery == ""
          ? appendQuery = "siteStageId=?"
          : appendQuery = appendQuery + " and siteStageId=?";
      whereArgs == ""
          ? whereArgs = siteStageReq
          : whereArgs = whereArgs + siteStageReq + ",";
    }

    if (siteStatusReq != null && siteStatusReq != "") {
      appendQuery == ""
          ? appendQuery = "siteStatusId=?"
          : appendQuery = appendQuery + " and siteStatusId=?";
      whereArgs == ""
          ? whereArgs = siteStatusReq
          : whereArgs = whereArgs + siteStatusReq + ",";
    }

    if (sitePincodeReq != null && sitePincodeReq != "") {
      appendQuery == ""
          ? appendQuery = "sitePincode=?"
          : appendQuery = appendQuery + " and sitePincode=?";
      whereArgs == ""
          ? whereArgs = "'" + sitePincodeReq + "'"
          : whereArgs = whereArgs + "'" + sitePincodeReq + "'" + ",";
    }

    // if (siteDistrictReq != null && siteDistrictReq != "") {
    //   appendQuery == ""
    //       ? appendQuery = "siteDistrict=?"
    //       : appendQuery = appendQuery + " and siteDistrict=?";
    //   whereArgs == ""
    //       ? whereArgs = "'" + siteDistrictReq + "'"
    //       : whereArgs = whereArgs + "'" + siteDistrictReq + "'" + ",";
    // }

    print(whereArgs.runtimeType);
    db.filterSiteEntityList(appendQuery, whereArgs).then((value) {
      _siteController.fetchFliterSiteList1(value);
      setState(() {
        siteList = value;
        print("Filter-->" +
            appendQuery +
            ".." +
            whereArgs +
            "..." +
            siteList.length.toString());
      });
    });

    return siteList;
  }
}
