import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  LeadsFilterController _leadsFilterController = Get.find();
  SplashController _splashController = Get.find();

  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  @override
  Widget build(BuildContext context) {
    _leadsFilterController.getSecretKey(10);
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
          physics: NeverScrollableScrollPhysics(),
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
                      _leadsFilterController.selectedPosition = 0;
                    },
                    child: returnSelectedWidget("Assign Date", 0)),
                GestureDetector(
                    onTap: () {
                      _leadsFilterController.selectedPosition = 1;
                    },
                    child: returnSelectedWidget("Lead Stage", 1)),
                GestureDetector(
                    onTap: () {
                      _leadsFilterController.selectedPosition = 2;
                    },
                    child: returnSelectedWidget("Lead Status", 2)),
                GestureDetector(
                    onTap: () {
                      _leadsFilterController.selectedPosition = 3;
                    },
                    child: returnSelectedWidget("Lead Potential", 3)),
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
              child: returnSelectedWidgetBody(
                  _leadsFilterController.selectedPosition)),
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
                    _leadsFilterController.isFilterApplied=false;

                    //Navigator.pop(context);
                    setState(() {
                      _leadsFilterController.selectedLeadStage =
                          StringConstants.empty;
                      _leadsFilterController.selectedLeadStageValue =
                          StringConstants.empty;
                      _leadsFilterController.selectedLeadStatus =
                          StringConstants.empty;
                      _leadsFilterController.selectedLeadStatusValue =
                          StringConstants.empty;
                      _leadsFilterController.assignToDate =
                          StringConstants.empty;
                      _leadsFilterController.assignFromDate =
                          StringConstants.empty;
                      _leadsFilterController.selectedLeadPotential =
                          StringConstants.empty;
                      _leadsFilterController.selectedLeadPotentialValue =
                          StringConstants.empty;
                      _leadsFilterController.selectedFilterCount = 0;
                      Navigator.pop(context);
                      _leadsFilterController
                          .getAccessKey(RequestIds.GET_LEADS_LIST);
                    });
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyles.mulliBoldYellow18,
                  ),
                ),
                Spacer(),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _leadsFilterController.isFilterApplied=true;
                    _leadsFilterController.offset = 0;
                   // _leadsFilterController.leadsListResponse = [];
                    _leadsFilterController
                        .getAccessKey(RequestIds.GET_LEADS_LIST);
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
          color: (_leadsFilterController.selectedPosition == position)
              ? Colors.white
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (_leadsFilterController.selectedPosition == position)
                  ? Container(
                      width: 5,
                      height: 50,
                      color: ColorConstants.clearAllTextColor,
                    )
                  : Container(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16,8.0,8,8),
                  child: Text(
                    text,
                    style: (_leadsFilterController.selectedPosition == position)
                        ? TextStyles.mulliBold14
                        : TextStyle(color: Colors.black
                    ),
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
        child: (_leadsFilterController.selectedPosition == 0)
            ? returnAssignDateBody()
            : (_leadsFilterController.selectedPosition == 1)
                ? returnLeadStageBody()
                : (_leadsFilterController.selectedPosition == 2)
                    ? returnLeadStatusBody()
                    : returnLeadPotentialBody(),
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
                          "${_leadsFilterController.assignFromDate}",
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
                          "${_leadsFilterController.assignToDate}",
                          style: TextStyles.robotoBold16,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            if (_leadsFilterController.assignFromDate ==
                                StringConstants.empty) {
                              print('From date is empty');
                            } else {
                              String fromDate =
                                  _leadsFilterController.assignFromDate;
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
            itemCount: _splashController.splashDataModel.leadStageEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return leadStageListTile(
                  _splashController
                      .splashDataModel.leadStageEntity[index].leadStageDesc,
                  _splashController.splashDataModel.leadStageEntity[index].id
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
              groupValue: _leadsFilterController.selectedLeadStage as String,
              onChanged: (String value) {
                if (_leadsFilterController.selectedLeadStage ==
                    StringConstants.empty) {
                  _leadsFilterController.selectedFilterCount =
                      _leadsFilterController.selectedFilterCount + 1;
                }
                _leadsFilterController.selectedLeadStage = value;
                _leadsFilterController.selectedLeadStageValue = leadStageValue;

                ///filter issue
               // _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
              },
            ),
          )),
    );
  }

  Widget returnLeadStatusBody() {
    SplashController _splashController = Get.find();
    return Container(
        height: (SizeConfig.blockSizeVertical),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount:
                _splashController.splashDataModel.leadStatusEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return leadStatusListTile(
                  _splashController
                      .splashDataModel.leadStatusEntity[index].leadStatusDesc,
                  _splashController.splashDataModel.leadStatusEntity[index].id
                      .toString());
            }));
  }

  Widget leadStatusListTile(String statusValue, String leadStatusValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(
            statusValue,
            style: TextStyle(fontSize: 14),
          ),
          leading: Obx(
            () => Radio(
              value: statusValue,
              groupValue: _leadsFilterController.selectedLeadStatus as String,
              onChanged: (String value) {
                if (_leadsFilterController.selectedLeadStatus ==
                    StringConstants.empty) {
                  _leadsFilterController.selectedFilterCount =
                      _leadsFilterController.selectedFilterCount + 1;
                }

                _leadsFilterController.selectedLeadStatus = value;
                _leadsFilterController.selectedLeadStatusValue =
                    leadStatusValue;
                _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
              },
            ),
          )),
    );
  }

  Widget returnLeadPotentialBody() {
    List<String> leadPotentialLead = ["1-200", "201-500", "Above 500+"];
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: leadPotentialLead.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return leadPotentialListTile(
                  leadPotentialLead[index], (index).toString());
            }));
  }

  Widget leadPotentialListTile(
      String potentialValue, String leadPotentialValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(potentialValue),
          leading: Obx(
            () => Radio(
              value: potentialValue,
              groupValue:
                  _leadsFilterController.selectedLeadPotential as String,
              onChanged: (String value) {
                if (_leadsFilterController.selectedLeadPotential ==
                    StringConstants.empty) {
                  _leadsFilterController.selectedFilterCount =
                      _leadsFilterController.selectedFilterCount + 1;
                }
                _leadsFilterController.selectedLeadPotential = value;
                _leadsFilterController.selectedLeadPotentialValue =
                    leadPotentialValue;
                _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
              },
            ),
          )),
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
          _leadsFilterController.assignToDate = formattedDate;
        } else {
          _leadsFilterController.assignFromDate = formattedDate;
        }
        selectedDateString = formattedDate;
      });
  }
}
