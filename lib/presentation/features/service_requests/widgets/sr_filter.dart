import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  SplashController _splashController = Get.find();
  SRListController _srListController = Get.find();
  SplashDataModel splashDataModel;
  int selectedPosition = 0;
  int totalFilters = 0;

  @override
  void initState() {
  //  print("Filter Widget");
    setState(() {
      splashDataModel = _splashController.splashDataModel;
    });
    splashDataModel.srctRequestEntity.forEach((element) {
    //  print(element.toJson());
    });
    splashDataModel.srComplainResolutionEntity.forEach((element) {
    //  print(element.toJson());
    });
  //  print(splashDataModel.severity);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Container(
      // height: MediaQuery.of(context).size.height * 0.70,
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
                  Get.back(result: [resolutionStatus,severityGroup,requestGroup, totalFilters]);
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
                      setState(() {
                        selectedPosition = 0;
                      });
                    },
                    child: returnSelectedWidget("Resolution \nStatus", 0)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPosition = 1;
                      });
                    },
                    child: returnSelectedWidget("Severity", 1)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPosition = 2;
                      });
                    },
                    child: returnSelectedWidget("Type of \nRequest", 2)),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 1,
            color: ColorConstants.lineColorFilter,
          ),
          new Expanded(
              flex: 2, child: returnSelectedWidgetBody(selectedPosition)),
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
                    //Navigator.pop(context);
                    setState(() {
                      requestGroup='';
                      severityGroup='';
                      severityGroup='';
                      totalFilters=0;
                      Get.back(result: [resolutionStatus,severityGroup,requestGroup, totalFilters]);

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
                 //   print(requestGroup);
                    Get.back(result: [resolutionStatus,severityGroup,requestGroup, totalFilters]);
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
    return Container(
      height: 55,
      color: (selectedPosition == position) ? Colors.white : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (selectedPosition == position)
              ? Container(
                  width: 5,
                  height: 50,
                  color: ColorConstants.clearAllTextColor,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
            child: Center(
              child: Text(
                text,
                style: (selectedPosition == position)
                    ? TextStyles.mulliBold14
                    : TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget returnSelectedWidgetBody(int position) {
    return Container(
      height: double.maxFinite,
      color: Colors.white,
      child: (selectedPosition == 0)
          ? returnResolutionStatusBody()
          : (selectedPosition == 1)
              ? returnSeverityBody()
              : returnRequestTypeBody(),
    );
  }

  Widget returnResolutionStatusBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: splashDataModel.srComplainResolutionEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return filterBodyListTile(
                  splashDataModel
                      .srComplainResolutionEntity[index].resolutionText,
                  splashDataModel.srComplainResolutionEntity[index].id
                      .toString());
            }));
  }

  String resolutionStatus='';
  Widget filterBodyListTile(String text, String id) {
    return Container(
      height: 40,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
        leading: Radio(
          value: id,
          groupValue: resolutionStatus,
          // _srFilterController.selectedLeadStage as String,
          onChanged: (String value) {
            setState(() {
              resolutionStatus = value;
              totalFilters++;
            });
          },
        ),
      ),
    );
  }

  Widget returnSeverityBody() {
    SplashController _splashController = Get.find();
    return Container(
        height: (SizeConfig.blockSizeVertical),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: splashDataModel.severity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return severityListTile(
                  splashDataModel.severity[index],
                  _splashController.splashDataModel.leadStatusEntity[index].id
                      .toString());
            }));
  }

  String severityGroup='';
  Widget severityListTile(String severity, String id) {
    return Container(
      height: 40,
      child: ListTile(
        title: Text(
          severity,
          style: TextStyle(fontSize: 14),
        ),
        leading: Radio(
          value: severity,
          groupValue: severityGroup,
          onChanged: (String value) {
            setState(() {
              severityGroup = value;
              totalFilters++;
            });
          },
        ),
      ),
    );
  }

  Widget returnRequestTypeBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: splashDataModel.srctRequestEntity.length,
            itemExtent: 50,
            itemBuilder: (context, index) {
              return requestTypeListTile(
                  splashDataModel
                      .srctRequestEntity[index].requestText,
                  splashDataModel
                      .srctRequestEntity[index].id.toString());
            }));
  }

  String requestGroup='';
  Widget requestTypeListTile(String requestType, String id) {
    return Container(
      height: 40,
      child: ListTile(
        title: Text(requestType, style: TextStyle(fontSize: 14)),
        leading: Radio(
          value: id,
          groupValue: requestGroup,
          onChanged: (String value) {
            setState(() {
              requestGroup = value;
              totalFilters++;
            });
          //  print(totalFilters);
          },
        ),
      ),
    );
  }
}
