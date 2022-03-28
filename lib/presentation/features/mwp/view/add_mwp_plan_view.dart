

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/global.dart';
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
  
  @override
  void initState() {
    super.initState();
    _mwpPlanController.selectedMwpPlannigList = _mwpPlanController.mwpPlannigList;
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
                () =>
            (_mwpPlanController.isLoading)
                ? Container(
              height: SizeConfig.screenHeight,
            )
    //             :(_mwpPlanController.mwpPlannigList.leght == null)?
    //  Container(
    // child: Center(
    // child : Text("No data !!"),
    // ))
                : ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 2),
              //  padding: const EdgeInsets.all(8.0),
              // itemCount: mwpPlanList.length,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  color: ColorConstants.lightOutlineColor)),
                          child: returnTextField(index,
                              _mwpPlanController.getMWPResponse.mwpPlannigList),
                        ),
                        flex: 1,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Obx(
                            () =>
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConstants
                                          .lightOutlineColor),),
                                child: TextFormField(
                                    enabled: false,
                                    maxLength: 4,
                                    initialValue:
                                    (_mwpPlanController.getMWPResponse != null)
                                        ? (_mwpPlanController.getMWPResponse
                                        .mwpPlannigList != null)
                                        ? returnActualValue(index) : "0" : "0",
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      counterStyle: TextStyle(fontSize: 0),),
                                    style: TextStyle(fontSize: 14,
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
          SizedBox(height: 16,),
          Obx(() =>
          (_mwpPlanController.getMWPResponse.mwpplanModel == null)
              ? returnSaveRow() : (_mwpPlanController.getMWPResponse
              .mwpplanModel.status == "SAVE")
              ? returnSaveRow()
              : (_mwpPlanController.getMWPResponse.mwpplanModel.status ==
              "APPROVE")
              ? returnApprovedRow() : returnSubmitRow()
          ),
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
              internetChecking().then((result) =>
              {
                if (result == true){
                  _mwpPlanController.action = "SAVE",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN, context),
                } else
                  {
                    Get.snackbar(
                        "No internet connection.",
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
              internetChecking().then((result) =>
              {
                if (result == true)
                  {
                    _mwpPlanController.action = "SAVE",
                    _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN, context),
                  } else
                  {
                    Get.snackbar(
                        "No internet connection.",
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
              internetChecking().then((result) =>
              {
                if (result == true)
                  {
                    _mwpPlanController.action = "SUBMIT",
                    _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN, context),
                  } else
                  {
                    Get.snackbar(
                        "No internet connection.",
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
        Flexible(
          child:    ElevatedButton(
    style: ElevatedButton.styleFrom(
            primary: ColorConstants.buttonNormalColor,
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              internetChecking().then((result) =>
              {
                if (result == true)
                  {
                    _mwpPlanController.action = "SUBMIT",
                    _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN, context),
                  } else
                  {
                    Get.snackbar(
                        "No internet connection.",
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

  Widget returnTextField(int index, List<MwpPlannigList>? mwpPlannigList) {
    final node = FocusScope.of(context);
    return Obx(
          () =>
          TextFormField(

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
                  _mwpPlanController.getMWPResponse.mwpPlannigList[index].targetValue = _;
                  _mwpPlanController.selectedMwpPlannigList = _mwpPlanController.mwpPlannigList;

                  if(_mwpPlanController.selectedMwpPlannigList[index].id != _mwpPlanController.mwpPlannigList[index].id) {
                    _mwpPlanController.selectedMwpPlannigList.add(
                        new MwpPlannigList(
                          name: _mwpPlanController.getMWPResponse
                              .mwpPlannigList[index].name,
                          id: _mwpPlanController.getMWPResponse
                              .mwpPlannigList[index]
                              .id,
                          actualValue: _mwpPlanController.getMWPResponse
                              .mwpPlannigList[index].actualValue.toString(),
                          targetValue: _mwpPlanController.getMWPResponse
                              .mwpPlannigList[index].targetValue.toString(),
                        ));
                  }


                log('SELECTED: ${json.encode(_mwpPlanController.selectedMwpPlannigList)}');

              } catch (_) {
                _mwpPlanController.getMWPResponse.mwpPlannigList[index]
                    .targetValue = "0";
                _mwpPlanController.mwpPlannigList.add(new MwpPlannigList(
                  name: _mwpPlanController.getMWPResponse.mwpPlannigList[index].name,
                  id:_mwpPlanController.getMWPResponse.mwpPlannigList[index].id,
                  actualValue: _mwpPlanController.getMWPResponse.mwpPlannigList[index].actualValue.toString(),
                  targetValue: _mwpPlanController.getMWPResponse.mwpPlannigList[index].targetValue.toString(),
                ));
              }
            },

            style: TextStyle(
                fontSize: 14,
                color: ColorConstants.lightGreyColor,
                fontFamily: "Muli"),
            keyboardType: TextInputType.numberWithOptions(signed: true),
            inputFormatters:
            (_mwpPlanController.mwpPlannigList[index].id == 14 ||
            _mwpPlanController.mwpPlannigList[index].id == 15 ||
                _mwpPlanController.mwpPlannigList[index].id == 16 ||
            _mwpPlanController.mwpPlannigList[index].id == 17)?
            <TextInputFormatter> [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),]:
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
    );
  }

  /*Set the values in fields*/
  String returnActualValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpPlannigList != null) {
      return "${_mwpPlanController.getMWPResponse.mwpPlannigList[index]
          .actualValue}";
    } else {
      return "0";
    }
  }

  /*Set the values in fields*/
  String returnTargetValue(int index) {
    if (_mwpPlanController.getMWPResponse.mwpPlannigList != null) {
      return "${_mwpPlanController.getMWPResponse.mwpPlannigList[index]
          .targetValue}";
    } else {
      return "0";
    }
  }
}







/*
  @override
=======
>>>>>>> 88ca01f338712038aae7390a805d4097fc6f2cb2
  Widget build(BuildContext context) {

    List<String> mwpNames = [
      "0 Retention Volume (MT)",
      "1 New ILP members",
      "2 DSP Slabs Conv. (Nos.)",
      "3 DSP Conversion Vol (MT)",
      "4 Conversion Vol (MT)",
      "5 Site Conversion (Nos.)",
      "6 Site Visit (Total)",
      "7 Site Visits (Unique)",
/*
      "Influencer Visits",
*/
      "8 Mason Meet",
      "9 Counter Meet",
      "10 Contractor Meet",
      "11 Mini Contractor Meet",
      "12 Consumer Meet",
      "13 Contractor Visit",
      "14 Technocrat visit",
      "15 Tech Van Demo",
      "16 Tech Van Service",
       "17 Site Service - Slab Supervision",
       "18 Technocrat meet",
      "19 Block Level meet",
      "20 Head Mason meet",
      "21 New Influencer",
      //new
      "22 Counter Visit",
      "23 ILP Volume"
    ];

<<<<<<< HEAD
=======

>>>>>>> 88ca01f338712038aae7390a805d4097fc6f2cb2
    List<AddMwpModel> mwpPlanList = new List.empty(growable: true);
    for (int i = 0; i < mwpNames.length; i++) {
      mwpPlanList.add(
          new AddMwpModel(mwpNames[i], 10, 10, new TextEditingController()));
    }

    return GestureDetector(
      onTap: (){
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
              ? returnSaveRow(): (_mwpPlanController.getMWPResponse.mwpplanModel.status =="SAVE")
              ? returnSaveRow()
              : (_mwpPlanController.getMWPResponse.mwpplanModel.status == "APPROVE")
              ? returnApprovedRow() : returnSubmitRow()
              /*: (_mwpPlanController.getMWPResponse.mwpplanModel.status =="SUBMIT")
                  ? returnSubmitRow()
                  : (_mwpPlanController.getMWPResponse.mwpplanModel.status == "APPROVE")
                      ?
                   returnApprovedRow() : returnSaveRow()*/

          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget returnApprovedRow() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        ),        onPressed: () {},
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
              internetChecking().then((result) => {
                if (result == true){
                  _mwpPlanController.action = "SAVE",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN),
                  }else{
                  Get.snackbar(
                      "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM),
                  // fetchSiteList()
                }
              });
            }
                : (_mwpPlanController.getMWPResponse.mwpplanModel.status == "SUBMIT")
                    ? null
                    : () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        internetChecking().then((result) => {
                if (result == true)
                  {
                            _mwpPlanController.action = "SAVE",
                            _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN),
                  }else{
                  Get.snackbar(
                      "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
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
    ),            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              internetChecking().then((result) => {
                if (result == true)
                  {
                  _mwpPlanController.action = "SUBMIT",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN),
                  }else{
                  Get.snackbar(
                      "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
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
          child: ElevatedButton(
    style: ElevatedButton.styleFrom(
            primary: ColorConstants.buttonNormalColor,
    ),            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              internetChecking().then((result) => {
                if (result == true)
                  {
                  _mwpPlanController.action = "SUBMIT",
                  _appController.getAccessKey(RequestIds.SAVE_MWP_PLAN),
                  }else{
                  Get.snackbar(
                      "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
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

/*
            try {
              switch (index) {
                case 0:
                  _mwpPlanController.totalConversionVol = int.parse(_);

                  break;
                case 1:
                  _mwpPlanController.newILPMembers = int.parse(_);
                  break;
                case 2:
                  _mwpPlanController.dspSlab = int.parse(_);
                  break;
                case 3:
                  _mwpPlanController.dspConVol = double.parse(_);
                  break;
                  case 4:
                  _mwpPlanController.siteConVol = int.parse(_);
                  break;
                case 5:
                  _mwpPlanController.siteConNo = int.parse(_);
                  break;
                case 6:
                  _mwpPlanController.siteVisitsTotal = int.parse(_);
                  break;
                case 7:
                  _mwpPlanController.siteVisitsUnique = int.parse(_);
                  break;
                // case 8:
                //   _mwpPlanController.influencerVisit = int.parse(_);
                //   break;
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
                  case 13:
                  _mwpPlanController.contractorVisit = int.parse(_);
                  break;
                case 14:
                  print("onChanged    call  $index   $_");
                  _mwpPlanController.technocratVisit = int.parse(_);

                  break;
                case 15:
                  _mwpPlanController.techVanDemo = int.parse(_);
                  break;
                case 16:
                  _mwpPlanController.techVanService = int.parse(_);
                  break;
                case 17:
                  _mwpPlanController.slabServices = int.parse(_);
                  break;
                case 18:
                  _mwpPlanController.technocratMeet = int.parse(_);
                  break;
                case 19:
                  _mwpPlanController.blockLevelMeet = int.parse(_);
                  break;
                case 20:
                  _mwpPlanController.headMasonMeet = int.parse(_);
                  break;
                case 21:
                  _mwpPlanController.newInfluencer = int.parse(_);
                  break;
              }
            } catch (_) {
              print('In exception   $index');
              switch (index) {
                case 0:
                  _mwpPlanController.totalConversionVol = 0;

                  break;
                case 1:
                  _mwpPlanController.newILPMembers = 0;
                  break;
                case 2:
                  _mwpPlanController.dspSlab = 0;
                  break;
                case 3:
                  _mwpPlanController.dspConVol = 0.0;
                  break;
                case 4:
                  _mwpPlanController.siteConVol = 0;
                  break;
                case 5:
                  _mwpPlanController.siteConNo = 0;
                  break;
                case 6:
                  _mwpPlanController.siteVisitsTotal = 0;
                  break;
                case 7:
                  _mwpPlanController.siteVisitsUnique = 0;
                  break;
                // case 8:
                //   _mwpPlanController.influencerVisit = 0;
                //   break;
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
                case 13:
                  _mwpPlanController.contractorVisit = 0;
                  break;
                case 14:
                  _mwpPlanController.technocratVisit = 0;
                  break;
                case 15:
                  _mwpPlanController.techVanDemo = 0;
                  break;
                case 16:
                  _mwpPlanController.techVanService = 0;
                  break;
                case 17:
                  _mwpPlanController.slabServices = 0;
                  break;
                case 18:
                  _mwpPlanController.technocratMeet = 0;
                  break;
                  case 19:
                  _mwpPlanController.blockLevelMeet = 0;
                  break;
                case 20:
                  _mwpPlanController.headMasonMeet = 0;
                  break;
                case 21:
                  _mwpPlanController.newInfluencer = 0;
                  break;

              }
            }
            */



            try {
              switch (index) {
                case 0:
                  _mwpPlanController.siteVisitsTotal = int.parse(_);
                  break;
                case 1:
                  _mwpPlanController.siteVisitsUnique = int.parse(_);
                  break;
                case 2:
                  _mwpPlanController.contractorVisit = int.parse(_);
                  break;
                case 3:
                  _mwpPlanController.technocratVisit = int.parse(_);
                  break;
                case 4:
                  _mwpPlanController.counterVisit = int.parse(_);
                  break;
                case 5:
                  _mwpPlanController.masonMeet = int.parse(_);
                  break;
                case 6:
                  _mwpPlanController.headMasonMeet = int.parse(_);
                  break;
                case 7:
                  _mwpPlanController.contractorMeet = int.parse(_);
                  break;
                case 8:
                  _mwpPlanController.miniContractorMeet = int.parse(_);
                  break;
                case 9:
                  _mwpPlanController.counterMeet = int.parse(_);
                  break;
                case 10:
                  _mwpPlanController.consumerMeet = int.parse(_);
                  break;
                case 11:
                  _mwpPlanController.technocratMeet = int.parse(_);
                  break;
                case 12:
                  _mwpPlanController.blockLevelMeet = int.parse(_);
                  break;
                case 13:
                  _mwpPlanController.siteConVol = int.parse(_);
                  break;
                case 14:
                  _mwpPlanController.totalConversionVol = int.parse(_);
                  break;
                case 15:
                  _mwpPlanController.ilpVolume = int.parse(_);
                  break;
                case 16:
                  _mwpPlanController.dspConVol = double.parse(_);
                  break;
                case 17:
                  _mwpPlanController.siteConNo = int.parse(_);
                  break;
                case 18:
                  _mwpPlanController.dspSlab = int.parse(_);
                  break;
                case 19:
                  _mwpPlanController.newInfluencer = int.parse(_);
                  break;
                case 20:
                  _mwpPlanController.newILPMembers = int.parse(_);
                  break;
                case 21:
                  _mwpPlanController.slabServices = int.parse(_);
                  break;
                case 22:
                  _mwpPlanController.techVanDemo = int.parse(_);
                  break;
                case 23:
                  _mwpPlanController.techVanService = int.parse(_);
                  break;
              }
            } catch (_) {
              print('In exception   $index');
              switch (index) {
                case 0:
                  _mwpPlanController.siteVisitsTotal = 0;
                  break;
                case 1:
                  _mwpPlanController.siteVisitsUnique = 0;
                  break;
                case 2:
                  _mwpPlanController.contractorVisit = 0;
                  break;
                case 3:
                  _mwpPlanController.technocratVisit = 0;
                  break;
                case 4:
                  _mwpPlanController.counterVisit = 0;
                  break;
                case 5:
                  _mwpPlanController.masonMeet = 0;
                  break;
                case 6:
                  _mwpPlanController.headMasonMeet = 0;
                  break;
                case 7:
                  _mwpPlanController.contractorMeet = 0;
                  break;
                case 8:
                  _mwpPlanController.miniContractorMeet = 0;
                  break;
                case 9:
                  _mwpPlanController.counterMeet = 0;
                  break;
                case 10:
                  _mwpPlanController.consumerMeet = 0;
                  break;
                case 11:
                  _mwpPlanController.technocratMeet = 0;
                  break;
                case 12:
                  _mwpPlanController.blockLevelMeet = 0;
                  break;
                case 13:
                  _mwpPlanController.siteConVol = 0;
                  break;
                case 14:
                  _mwpPlanController.totalConversionVol = 0;
                  break;
                case 15:
                  _mwpPlanController.ilpVolume = 0;
                  break;
                case 16:
                  _mwpPlanController.dspConVol = 0.0;
                  break;
                case 17:
                  _mwpPlanController.siteConNo = 0;
                  break;
                case 18:
                  _mwpPlanController.dspSlab = 0;
                  break;
                case 19:
                  _mwpPlanController.newInfluencer = 0;
                  break;
                case 20:
                  _mwpPlanController.newILPMembers = 0;
                  break;
                case 21:
                  _mwpPlanController.slabServices = 0;
                  break;
                case 22:
                  _mwpPlanController.techVanDemo = 0;
                  break;
                case 23:
                  _mwpPlanController.techVanService = 0;
                  break;
              }
            }
          },

          style: TextStyle(
              fontSize: 14,
              color: ColorConstants.lightGreyColor,
              fontFamily: "Muli"),
          keyboardType: TextInputType.numberWithOptions(signed: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }


  /*Set the values in fields*/
  String returnActualValue(int index) {
   /* if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
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
                      ? _mwpPlanController.getMWPResponse.mwpplanModel.actualDspConversionVol
                       .toString()
                  : (index == 4)
                      ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvMt
                          .toString()
                      : (index == 5)
                          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvNo
                              .toString()
                          : (index == 6)
                              ? _mwpPlanController.getMWPResponse.mwpplanModel
                                  .actualSiteVisitesNo
                                  .toString()
                              : (index == 7)
                                  ? _mwpPlanController.getMWPResponse
                                      .mwpplanModel.actualSiteUniqueVisitsNo
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
                                                          .actualMiniContractorMeetNo
                                                          .toString()
                                                      : (index == 12)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .actualConsumerMeetNo
                                                              .toString()
                                                          :   (index == 13)
                                                             ? _mwpPlanController
                                                               .getMWPResponse
                                                               .mwpplanModel
                                                            .actualContractorVisit
                                                               .toString()
                                                         : (index == 14)
                                                            ? _mwpPlanController
                                                             .getMWPResponse
                                                              .mwpplanModel
                                                             .actualTechnocratVisit
                                                             .toString()
                                                          : (index == 15)
                                                           ? _mwpPlanController
                                                             .getMWPResponse
                                                              .mwpplanModel
                                                               .actualTechVanDemo
                                                               .toString()
          : (index == 16)
          ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel
          .actualTechVanService
          .toString()
          : (index == 17)
          ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel
          .actualSlabServices
          .toString()
          : (index == 18)
          ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel
          .actualTechnocratMeet
          .toString()
          : (index == 19) ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel
          .actualBlockLevelMeet
          .toString():(index == 20) ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel.actualHeadMasonMeet.toString():
          (index == 21) ?
          _mwpPlanController.getMWPResponse
          .mwpplanModel
          .actualNewInfluencer
          .toString(): "0";}
    else {
      return "0";
    }
*/
    if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
      return (index == 0)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteVisitesNo.toString()
          : (index == 1)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteUniqueVisitsNo.toString()
          : (index == 2)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualContractorVisit.toString()
          : (index == 3)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTechnocratVisit.toString()
          : (index == 4)
      /////
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualCounterVisit.toString()
          : (index == 5)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualMasonMeetNo.toString()
          : (index == 6)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualHeadMasonMeet.toString()
          : (index == 7)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualContractorMeetNo.toString()
          : (index == 8)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualMiniContractorMeetNo.toString()
          : (index == 9)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualCounterMeetNo.toString()
          : (index == 10)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualConsumerMeetNo.toString()
          : (index == 11)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTechnocratMeet.toString()
          : (index == 12)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualBlockLevelMeet.toString()
          : (index == 13)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvMt.toString()
          : (index == 14)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTotalConvMt.toString()
          : (index == 15)
      ///
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualIlpVolume.toString()
          : (index == 16)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualDspConversionVol.toString()
          : (index == 17)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSiteConvNo.toString()
          : (index == 18)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualDspSlabConvNo.toString()
          : (index == 19)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualNewInfluencer.toString()
          :(index == 20)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualNewIlpMembers.toString()
          : (index == 21)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualSlabServices.toString()
          : (index == 22)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTechVanDemo.toString()
          : (index == 23)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.actualTechVanService.toString()
          : "0";}
    else {
      return "0";
    }
  }

  /*Set the values in fields*/
  String returnTargetValue(int index) {
   /* if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
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
                  ? _mwpPlanController.getMWPResponse.mwpplanModel.dspConversionVol
                      .toString()
                  : (index == 4)
                      ? _mwpPlanController
                          .getMWPResponse.mwpplanModel.siteConvMt
                          .toString()
                      : (index == 5)
                          ? _mwpPlanController
                              .getMWPResponse.mwpplanModel.siteConvNo
                              .toString()
                          : (index == 6)
                              ? _mwpPlanController
                                  .getMWPResponse.mwpplanModel.siteVisitesNo
                                  .toString()
                              : (index == 7)
                                  ? _mwpPlanController.getMWPResponse
                                      .mwpplanModel.siteUniqueVisitsNo
                                      .toString()
                                 /* : (index == 8)
                                      ? _mwpPlanController.getMWPResponse
                                          .mwpplanModel.inflVisitsNo
                                          .toString()*/
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
                                                      : (index == 13)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .contractorVisit
                                                              .toString()
                                                  : (index == 14)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .technocratVisit
                                                              .toString()
                                                    : (index == 15)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .techVanDemo
                                                              .toString()
                                                   : (index == 16)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .techVanService
                                                              .toString()
                                                   : (index == 17)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .slabServices
                                                              .toString()
                                                    : (index == 18)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .technocratMeet
                                                              .toString()
                                                    : (index == 19)
                                                          ? _mwpPlanController
                                                              .getMWPResponse
                                                              .mwpplanModel
                                                              .blockLevelMeet
                                                              .toString()
                                                    :(index == 20) ? _mwpPlanController
          .getMWPResponse
          .mwpplanModel.headMasonMeet.toString():
           (index == 21) ?
           _mwpPlanController.getMWPResponse
          .mwpplanModel
          .newInfluencer
          .toString()
          : "0";
    } else {
      return "0";
    }*/

    if (_mwpPlanController.getMWPResponse.mwpplanModel != null) {
      return (index == 0)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.siteVisitesNo.toString()
          : (index == 1)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.siteUniqueVisitsNo.toString()
          : (index == 2)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.contractorVisit.toString()
          : (index == 3)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.technocratVisit.toString()
          : (index == 4)
      /////
          ? _mwpPlanController.getMWPResponse.mwpplanModel.counterVisit.toString()
          : (index == 5)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.masonMeetNo.toString()
          : (index == 6)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.headMasonMeet.toString()
          : (index == 7)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.contractorMeetNo.toString()
          : (index == 8)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.miniContractorMeetNo.toString()
          : (index == 9)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.counterMeetNo.toString()
          : (index == 10)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.consumerMeetNo.toString()
          : (index == 11)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.technocratMeet.toString()
          : (index == 12)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.blockLevelMeet.toString()
          : (index == 13)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.siteConvMt.toString()
          : (index == 14)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.totalConvMt.toString()
          : (index == 15)
      ///
          ? _mwpPlanController.getMWPResponse.mwpplanModel.newIlpVolume.toString()
          : (index == 16)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.dspConversionVol.toString()
          : (index == 17)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.siteConvNo.toString()
          : (index == 18)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.dspSlabConvNo.toString()
          : (index == 19)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.newInfluencer.toString()
          :(index == 20)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.newIlpMembers.toString()
          : (index == 21)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.slabServices.toString()
          : (index == 22)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.techVanDemo.toString()
          : (index == 23)
          ? _mwpPlanController.getMWPResponse.mwpplanModel.techVanService.toString()
          : "0";
    } else {
      return "0";
    }
  }
}*/

