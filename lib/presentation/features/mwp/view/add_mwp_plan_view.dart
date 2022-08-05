import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';


class AddMWPPlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMWPPlanScreenPageState();
  }
}

class AddMWPPlanScreenPageState extends State<AddMWPPlan> {
  MWPPlanController _mwpPlanController = Get.find();
  AppController _appController = Get.find();
  // bool isPlanSubmitted = false;

  @override
  void initState() {
    super.initState();
    _mwpPlanController.selectedMwpPlannigList =
        _mwpPlanController.mwpPlannigList;
  }

  @override
  void dispose() {
    // _connectivity?.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
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
                    itemCount: _mwpPlanController.mwpPlannigList.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    _mwpPlanController.getMWPResponse
                                        .mwpPlannigList[index].name,
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
                                        color:
                                            ColorConstants.lightOutlineColor)),
                                child: returnTextField(
                                    index,
                                    _mwpPlanController
                                        .getMWPResponse.mwpPlannigList),
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
                                        color:
                                            ColorConstants.lightOutlineColor),
                                  ),
                                  child: TextFormField(
                                      enabled: false,
                                      maxLength: 4,
                                      initialValue:
                                          (_mwpPlanController.getMWPResponse !=
                                                  null)
                                              ? (_mwpPlanController
                                                          .getMWPResponse
                                                          .mwpPlannigList !=
                                                      null)
                                                  ? returnActualValue(index)
                                                  : "0"
                                              : "0",
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.lightGreyColor,
                                          fontFamily: "Muli"),
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
          SizedBox(
            height: 16,
          ),
          Obx(() => (_mwpPlanController.getMWPResponse.mwpplanModel == null)
              ? returnSaveRow()
              : (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
                      "SAVE")
                  ? returnSaveRow()
                  : (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
                          "APPROVE")
                      ? returnApprovedRow()
                      : returnSubmitRow()),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget returnApprovedRow() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
      ),
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorConstants.greenText,
            ),
            onPressed: (_mwpPlanController.getMWPResponse.mwpplanModel == null)
                ? () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    internetChecking().then((result) => {
                          if (result == true)
                            {
                              _mwpPlanController.action = "SAVE",
                              _appController.getAccessKey(
                                  RequestIds.SAVE_MWP_PLAN, context),
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
                : (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
                        "SUBMIT")
                    ? null
                    : () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        internetChecking().then((result) => {
                              if (result == true)
                                {
                                  _mwpPlanController.action = "SAVE",
                                  _appController.getAccessKey(
                                      RequestIds.SAVE_MWP_PLAN, context),
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorConstants.buttonNormalColor,
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              internetChecking().then((result) => {
                    if (result == true)
                      {
                        _mwpPlanController.action = "SUBMIT",
                        _appController.getAccessKey(
                            RequestIds.SAVE_MWP_PLAN, context),
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
        // Visibility(
        //   visible: !isPlanSubmitted,
        //   child:
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorConstants.buttonNormalColor,
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                internetChecking().then((result) => {
                      if (result == true)
                        {
                          _mwpPlanController.action = "SUBMIT",
                          _appController.getAccessKey(
                              RequestIds.SAVE_MWP_PLAN, context),
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
                // setState(() => isPlanSubmitted = true);
                // Future.delayed(Duration(seconds: 5), () {
                //   isPlanSubmitted = false;
                // });
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
        // ),
      ],
    );
  }

  Widget returnTextField(int index, List<MwpPlannigList>? mwpPlannigList) {
    final node = FocusScope.of(context);
    return Obx(
      () => TextFormField(
        initialValue: (_mwpPlanController.getMWPResponse != null)
            ? (_mwpPlanController.getMWPResponse.mwpPlannigList != null)
                ? returnTargetValue(index)
                : ""
            : "",
        readOnly: (_mwpPlanController.getMWPResponse.mwpplanModel != null)
            ? (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
                    "APPROVE")
                ? true
                : false
            : false,
        maxLength: 4,
        textAlign: TextAlign.center,
        onEditingComplete: () => node.nextFocus(),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          counterStyle: TextStyle(fontSize: 0),
        ),
        onChanged: (_) {
          try {
            _mwpPlanController
                .getMWPResponse.mwpPlannigList[index].targetValue = _;
            _mwpPlanController.selectedMwpPlannigList =
                _mwpPlanController.mwpPlannigList;

            if (_mwpPlanController.selectedMwpPlannigList[index].id !=
                _mwpPlanController.mwpPlannigList[index].id) {
              _mwpPlanController.selectedMwpPlannigList.add(new MwpPlannigList(
                name: _mwpPlanController
                    .getMWPResponse.mwpPlannigList[index].name,
                id: _mwpPlanController.getMWPResponse.mwpPlannigList[index].id,
                actualValue: _mwpPlanController
                    .getMWPResponse.mwpPlannigList[index].actualValue
                    .toString(),
                targetValue: _mwpPlanController
                    .getMWPResponse.mwpPlannigList[index].targetValue
                    .toString(),
              ));
            }

            log('SELECTED: ${json.encode(_mwpPlanController.selectedMwpPlannigList)}');
          } catch (_) {
            _mwpPlanController
                .getMWPResponse.mwpPlannigList[index].targetValue = "0";
            _mwpPlanController.mwpPlannigList.add(new MwpPlannigList(
              name:
                  _mwpPlanController.getMWPResponse.mwpPlannigList[index].name,
              id: _mwpPlanController.getMWPResponse.mwpPlannigList[index].id,
              actualValue: _mwpPlanController
                  .getMWPResponse.mwpPlannigList[index].actualValue
                  .toString(),
              targetValue: _mwpPlanController
                  .getMWPResponse.mwpPlannigList[index].targetValue
                  .toString(),
            ));
          }
        },
        style: TextStyle(
            fontSize: 14,
            color: ColorConstants.lightGreyColor,
            fontFamily: "Muli"),
        keyboardType: TextInputType.numberWithOptions(signed: true),
        inputFormatters: (_mwpPlanController.mwpPlannigList[index].id == 14 ||
                _mwpPlanController.mwpPlannigList[index].id == 15 ||
                _mwpPlanController.mwpPlannigList[index].id == 16 ||
                _mwpPlanController.mwpPlannigList[index].id == 17)
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ]
            : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  /*Set the values in fields*/
  String returnActualValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpPlannigList != null) {
      return "${_mwpPlanController.getMWPResponse.mwpPlannigList[index].actualValue}";
    } else {
      return "0";
    }
  }

  /*Set the values in fields*/
  String returnTargetValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpPlannigList != null) {
      return "${_mwpPlanController.getMWPResponse.mwpPlannigList[index].targetValue}";
    } else {
      return "0";
    }
  }
}
