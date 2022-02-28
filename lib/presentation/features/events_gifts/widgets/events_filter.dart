import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventsFilterWidget extends StatefulWidget {
  @override
  _EventsFilterWidgetState createState() => _EventsFilterWidgetState();
}

class _EventsFilterWidgetState extends State<EventsFilterWidget> {
  SplashController _splashController = Get.find();
  AllEventController _eventController = Get.find();

  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  @override
  Widget build(BuildContext context) {
//    _leadsFilterController.getSecretKey(10);
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
          physics: NeverScrollableScrollPhysics(),
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
                      _eventController.selectedPosition = 0;
                    },
                    child: returnSelectedWidget("Date Range", 0)),
                GestureDetector(
                    onTap: () {
                      _eventController.selectedPosition = 1;
                    },
                    child: returnSelectedWidget("Event Status", 1)),
                GestureDetector(
                    onTap: () {
                      _eventController.selectedPosition = 2;
                    },
                    child: returnSelectedWidget("Event Type", 2)),
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
                  _eventController.selectedPosition)),
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
                    _eventController.isFilterApplied=false;

                    //Navigator.pop(context);
                    setState(() {
                      _eventController.eventStatus =
                          StringConstants.empty;
                      _eventController.eventStatusValue =
                          StringConstants.empty;
                      _eventController.eventType =
                          StringConstants.empty;
                      _eventController.eventTypeValue =
                          StringConstants.empty;
                      _eventController.assignToDate =
                          StringConstants.empty;
                      _eventController.assignFromDate =
                          StringConstants.empty;
                      _eventController.selectedFilterCount = 0;
                      Navigator.pop(context);
//                      _eventController.getAccessKey(RequestIds.GET_LEADS_LIST);
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
                    _eventController.isFilterApplied=true;
                    _eventController.getAllEventData();
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
      color: (_eventController.selectedPosition == position)
          ? Colors.white
          : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (_eventController.selectedPosition == position)
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
                style: (_eventController.selectedPosition == position)
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
        child: (_eventController.selectedPosition == 0)
            ? returnAssignDateBody()
            : (_eventController.selectedPosition == 1)
            ? returnEventStatusBody()
            :  returnEventTypeBody()
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
                      "${_eventController.assignFromDate}",
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
                      "${_eventController.assignToDate}",
                      style: TextStyles.robotoBold16,
                    )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            if (_eventController.assignFromDate ==
                                StringConstants.empty) {
                              print('From date is empty');
                            } else {
                              String fromDate =
                                  _eventController.assignFromDate;
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

  Widget returnEventStatusBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _splashController.splashDataModel.statusEntitieList.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return eventStatusListTile(
                  _splashController
                      .splashDataModel.statusEntitieList[index].eventStatusText,
                  _splashController.splashDataModel.statusEntitieList[index].eventStatusId
                      .toString());
            }));
  }

  Widget eventStatusListTile(String eventStatus, String leadStageValue) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(eventStatus),
          leading: Obx(
                () => Radio(
              value: eventStatus,
              groupValue: _eventController.eventStatus as String,
              onChanged: (String value) {
                if (_eventController.eventStatus ==
                    StringConstants.empty) {
                  _eventController.selectedFilterCount =
                      _eventController.selectedFilterCount + 1;
                }
                _eventController.eventStatus = value;

                _eventController.eventStatusValue = leadStageValue;
//                _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
              },
            ),
          )),
    );
  }

  Widget returnEventTypeBody() {
    SplashController _splashController = Get.find();
    return Container(
        height: (SizeConfig.blockSizeVertical),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount:
            _splashController.splashDataModel.eventTypeModels.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return eventTypeListTile(
                  _splashController
                      .splashDataModel.eventTypeModels[index].eventTypeText,
                  _splashController.splashDataModel.eventTypeModels[index].eventTypeId
                      .toString());
            }));
  }

  Widget eventTypeListTile(String eventTypeText, String eventTypeId) {
    return Container(
      height: 40,
      child: ListTile(
          title: Text(
            eventTypeText,
            style: TextStyle(fontSize: 14),
          ),
          leading: Obx(
                () => Radio(
              value: eventTypeText,
              groupValue: _eventController.eventType as String,
              onChanged: (String value) {
      //          print(value);
                if (_eventController.eventType ==
                    StringConstants.empty) {
                  _eventController.selectedFilterCount =
                      _eventController.selectedFilterCount + 1;
                }
                _eventController.eventType = value;
                _eventController.eventTypeValue = eventTypeId;
//                _leadsFilterController.selectedLeadStatus = value;
//                _leadsFilterController.selectedLeadStatusValue =
//                    leadStatusValue;
//                _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
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
 //   print(type);
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
          _eventController.assignToDate = formattedDate;
        } else {
          _eventController.assignFromDate = formattedDate;
        }
        selectedDateString = formattedDate;
      });
  }
}
