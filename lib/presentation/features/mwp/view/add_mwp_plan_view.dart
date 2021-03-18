import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/AddMWPPlanModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMWPPlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMWPPlanScreenPageState();
  }
}

class AddMWPPlanScreenPageState extends State<AddMWPPlan> {
  MWPPlanController _mwpPlanController = Get.find();
  AppController _appController = Get.find();

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }


  @override
  void initState() {

    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<String> mwpNames = [
      "Total Conversion Vol. (MT)",
      "New ILP members",
      "DSP Slabs Conv. Nos.",
      "Site Conv. (Vol MT)",
      "Site Conv. (No. of sites)",
      "Site Visits (Total)",
      "Site Visits (Unique)",
      "Influencer Visits",
      "Mason Meet",
      "Counter Meet",
      "Contractor Meet",
      "Mini Contractor Meet",
      "Consumer Meet"
    ];
    List<AddMwpModel> mwpPlanList = new List();
    for (int i = 0; i < mwpNames.length; i++) {
      mwpPlanList.add(
          new AddMwpModel(mwpNames[i], 10, 10, new TextEditingController()));
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[],
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  "Target",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.lightGreyColor,
                  ),
                ),
              ),
              flex: 1,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  //_mwpPlanController.getMWPResponse.respCode,
                  "Actual",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.lightGreyColor,
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
        Obx(
          () => (_mwpPlanController.isLoading)
              ? Container(
            height: SizeConfig.screenHeight,
          )
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 2),
                  //  padding: const EdgeInsets.all(8.0),
                  itemCount: mwpPlanList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 64,
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  mwpPlanList[index].title,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: ColorConstants.lightGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            flex: 5,
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConstants.lightOutlineColor)),
                              child: returnTextField(index, mwpPlanList),
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Obx(
                            () => Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: ColorConstants.lightOutlineColor),),
                                child: TextFormField(
                                    enabled: false,
                                    maxLength: 4,
                                    initialValue:
                                        (_mwpPlanController.getMWPResponse !=null)
                                            ? (_mwpPlanController.getMWPResponse.mwpplanModel !=null)
                                            ? returnActualValue(index): "0" : "0",
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: InputBorder.none,  counterText: '',  counterStyle: TextStyle(fontSize: 0),),
                                    style: TextStyle(fontSize: 14, color: ColorConstants.lightGreyColor, fontFamily: "Muli"),
                                    keyboardType: TextInputType.number),
                              ),
                              flex: 1,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    );
                  },
                ),
        ),
        SizedBox(height: 16,),
        Obx(() => (_mwpPlanController.getMWPResponse.mwpplanModel == null)
            ? returnSaveRow()
            : (_mwpPlanController.getMWPResponse.mwpplanModel.status =="SUBMIT")
                ? returnSubmitRow()
                : (_mwpPlanController.getMWPResponse.mwpplanModel.status == "APPROVE")
                    ?
        // Text(_mwpPlanController.getMWPResponse.mwpplanModel.status)
        returnApprovedRow()
                    : returnSaveRow()),
        SizedBox(height: 30),
      ],
    );
  }

  Widget returnApprovedRow() {
    return RaisedButton(
        color: Colors.orange,
        highlightColor: ColorConstants.buttonPressedColor,
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Text(
            'APPROVED',
            style: ButtonStyles.buttonStyleBlue,
          ),
        ),
      );
  }

  Widget returnSaveRow() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: RaisedButton(
            color: ColorConstants.greenText,
            highlightColor: ColorConstants.buttonPressedColor,
            onPressed: (_mwpPlanController.getMWPResponse.mwpplanModel == null)
                ? () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    _mwpPlanController.action = "SAVE";
                    _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN);
                  }
                : (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
                        "SUBMIT")
                    ? null
                    : () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        _mwpPlanController.action = "SAVE";
                        _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN);
                      },
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text(
                'SAVE',
                style: ButtonStyles.buttonStyleBlue,
              ),
            ),
          ),
          flex: 5,
        ),
        SizedBox(
          width: 4,
        ),
        Flexible(
          child: RaisedButton(
            color: ColorConstants.buttonNormalColor,
            highlightColor: ColorConstants.buttonPressedColor,
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.


              internetChecking().then((result) => {
                if (result == true)
                  {
                  _mwpPlanController.action = "SUBMIT",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN)
                  }
                else
                  {
                    Get.snackbar(
                        "No internet connection.", "",
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM),

                    // fetchSiteList()
                  }
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text(
                'SUBMIT',
                style: ButtonStyles.buttonStyleBlue,
              ),
            ),
          ),
          flex: 5,
        ),
      ],
    );
  }

  Widget returnSubmitRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: RaisedButton(
            color: ColorConstants.buttonNormalColor,
            highlightColor: ColorConstants.buttonPressedColor,
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              internetChecking().then((result) => {
                if (result == true)
                  {
                  _mwpPlanController.action = "SUBMIT",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN)
                  }
                else
                  {
                    Get.snackbar(
                        "No internet connection.", "",
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM),

                    // fetchSiteList()
                  }
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text(
                'SUBMIT',
                style: ButtonStyles.buttonStyleBlue,
              ),
            ),
          ),
          flex: 5,
        ),
      ],
    );
  }

  Widget returnTextField(int index, List<AddMwpModel> mwpPlanList) {
    final node = FocusScope.of(context);
    return Obx(
      () => TextFormField(

          initialValue: (_mwpPlanController.getMWPResponse != null)
              ? (_mwpPlanController.getMWPResponse.mwpplanModel != null)
                  ? returnTargetValue(index)
                  : ""
              : "",
          readOnly: (_mwpPlanController.getMWPResponse.mwpplanModel != null)
              ? (_mwpPlanController.getMWPResponse.mwpplanModel.status=="APPROVE")
              ? true
              : false
              : false,
          maxLength: 4,
          textAlign: TextAlign.center,
          onEditingComplete: ()=>node.nextFocus(),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            counterStyle: TextStyle(fontSize: 0),
          ),
          onChanged: (_) {
            try {
              switch (index) {
                case 0:
                  _mwpPlanController.totalConversionVol = int.parse(_);
                  print('${_mwpPlanController.totalConversionVol}');
                  break;
                case 1:
                  _mwpPlanController.newILPMembers = int.parse(_);
                  break;
                case 2:
                  _mwpPlanController.dspSlab = int.parse(_);
                  break;
                case 3:
                  _mwpPlanController.siteConVol = int.parse(_);
                  break;
                case 4:
                  _mwpPlanController.siteConNo = int.parse(_);
                  break;
                case 5:
                  _mwpPlanController.siteVisitsTotal = int.parse(_);
                  break;
                case 6:
                  _mwpPlanController.siteVisitsUnique = int.parse(_);
                  break;
                case 7:
                  _mwpPlanController.influencerVisit = int.parse(_);
                  break;
                case 8:
                  _mwpPlanController.masonMeet = int.parse(_);
                  break;
                case 9:
                  _mwpPlanController.counterMeet = int.parse(_);
                  break;
                case 10:
                  _mwpPlanController.contractorMeet = int.parse(_);
                  break;
                case 11:
                  _mwpPlanController.miniContractorMeet = int.parse(_);
                  break;
                case 12:
                  _mwpPlanController.consumerMeet = int.parse(_);
                  break;
              }
            } catch (_) {
              print('In exception');
              switch (index) {
                case 0:
                  _mwpPlanController.totalConversionVol = 0;
                  print('${_mwpPlanController.totalConversionVol}');
                  break;
                case 1:
                  _mwpPlanController.newILPMembers = 0;
                  break;
                case 2:
                  _mwpPlanController.dspSlab = 0;
                  break;
                case 3:
                  _mwpPlanController.siteConVol = 0;
                  break;
                case 4:
                  _mwpPlanController.siteConNo = 0;
                  break;
                case 5:
                  _mwpPlanController.siteVisitsTotal = 0;
                  break;
                case 6:
                  _mwpPlanController.siteVisitsUnique = 0;
                  break;
                case 7:
                  _mwpPlanController.influencerVisit = 0;
                  break;
                case 8:
                  _mwpPlanController.masonMeet = 0;
                  break;
                case 9:
                  _mwpPlanController.counterMeet = 0;
                  break;
                case 10:
                  _mwpPlanController.contractorMeet = 0;
                  break;
                case 11:
                  _mwpPlanController.miniContractorMeet = 0;
                  break;
                case 12:
                  _mwpPlanController.consumerMeet = 0;
                  break;
              }
            }
          },
          style: TextStyle(
              fontSize: 14,
              color: ColorConstants.lightGreyColor,
              fontFamily: "Muli"),
          keyboardType: TextInputType.number),
    );
  }

  String returnActualValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
      return (index == 0)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTotalConvMt
              .toString()
          : (index == 1)
              ? _mwpPlanController.getMWPResponse.mwpplanModel.actualNewIlpMembers
                  .toString()
              : (index == 2)
                  ? _mwpPlanController.getMWPResponse.mwpplanModel.actualDspSlabConvNo
                      .toString()
                  : (index == 3)
                      ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvMt
                          .toString()
                      : (index == 4)
                          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvNo
                              .toString()
                          : (index == 5)
                              ? _mwpPlanController.getMWPResponse.mwpplanModel
                                  .actualSiteVisitesNo
                                  .toString()
                              : (index == 6)
                                  ? _mwpPlanController.getMWPResponse
                                      .mwpplanModel.actualSiteUniqueVisitsNo
                                      .toString()
                                  : (index == 7)
                                      ? _mwpPlanController.getMWPResponse
                                          .mwpplanModel.actualInflVisitsNo
                                          .toString()
                                      : (index == 8)
                                          ? _mwpPlanController.getMWPResponse
                                              .mwpplanModel.actualMasonMeetNo
                                              .toString()
                                          : (index == 9)
                                              ? _mwpPlanController
                                                  .getMWPResponse
                                                  .mwpplanModel
                                                  .actualCounterMeetNo
                                                  .toString()
                                              : (index == 10)
                                                  ? _mwpPlanController
                                                      .getMWPResponse
                                                      .mwpplanModel
                                                      .actualContractorMeetNo
                                                      .toString()
                                                  : (index == 11)
                                                      ? _mwpPlanController
                                                          .getMWPResponse
                                                          .mwpplanModel
                                                          .actualConsumerMeetNo
                                                          .toString()
                                                      : (index == 12)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .actualConsumerMeetNo
                                                              .toString()
                                                          : "0";}
    else {
      return "0";
    }
  }

  String returnTargetValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
      return (index == 0)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.totalConvMt
              .toString()
          : (index == 1)
              ? _mwpPlanController.getMWPResponse.mwpplanModel.newIlpMembers
                  .toString()
              : (index == 2)
                  ? _mwpPlanController.getMWPResponse.mwpplanModel.dspSlabConvNo
                      .toString()
                  : (index == 3)
                      ? _mwpPlanController
                          .getMWPResponse.mwpplanModel.siteConvMt
                          .toString()
                      : (index == 4)
                          ? _mwpPlanController
                              .getMWPResponse.mwpplanModel.siteConvNo
                              .toString()
                          : (index == 5)
                              ? _mwpPlanController
                                  .getMWPResponse.mwpplanModel.siteVisitesNo
                                  .toString()
                              : (index == 6)
                                  ? _mwpPlanController.getMWPResponse
                                      .mwpplanModel.siteUniqueVisitsNo
                                      .toString()
                                  : (index == 7)
                                      ? _mwpPlanController.getMWPResponse
                                          .mwpplanModel.inflVisitsNo
                                          .toString()
                                      : (index == 8)
                                          ? _mwpPlanController.getMWPResponse
                                              .mwpplanModel.masonMeetNo
                                              .toString()
                                          : (index == 9)
                                              ? _mwpPlanController
                                                  .getMWPResponse
                                                  .mwpplanModel
                                                  .counterMeetNo
                                                  .toString()
                                              : (index == 10)
                                                  ? _mwpPlanController
                                                      .getMWPResponse
                                                      .mwpplanModel
                                                      .contractorMeetNo
                                                      .toString()
                                                  : (index == 11)
                                                      ? _mwpPlanController
                                                          .getMWPResponse
                                                          .mwpplanModel
                                                          .miniContractorMeetNo
                                                          .toString()
                                                      : (index == 12)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .consumerMeetNo
                                                              .toString()
                                                          : "0";
    } else {
      return "0";
    }
  }
}
