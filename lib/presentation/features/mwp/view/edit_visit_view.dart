import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditEventVisit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditEventVisitScreenPageState();
  }
}

class EditEventVisitScreenPageState extends State<EditEventVisit> {
  String dropdownValue = 'RETENTION SITE';
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();

  //TextEditingController _remarks = new TextEditingController();

  //VisitResponseModel visitResponseModel;

  String siteIdText = "Site Id";

  @override
  void initState() {
    _appController.getAccessKey(RequestIds.VIEW_VISIT, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.ADD_CALENDER_SCREEN);
        return true;
      },
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BackFloatingButton(),
        bottomNavigationBar: BottomNavigator(),
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
          child: _buildAddEventInterface(context),
        ),
      ),
    );
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
        child: Obx(() =>
                // (_addEventController.isLoadingVisitView == false) ?
                (_addEventController.visitResponseModel.mwpVisitModel != null)
                    ? Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "View Event",
                                    style: TextStyle(
                                        color: ColorConstants.greenText,
                                        fontFamily: "Muli-Semibold.ttf",
                                        fontSize: 20,
                                        letterSpacing: .15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorConstants
                                            .inputBoxBorderSideColor)),
                                child: Obx(
                                  () => (_addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitStartTime ==
                                                  null &&
                                              _addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitEndTime ==
                                                  null) ||
                                          (_addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitStartTime !=
                                                  null &&
                                              _addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitEndTime ==
                                                  null)
                                      ? DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _addEventController
                                                .visitSubType,
                                            onChanged: (String newValue) {
                                              if (_addEventController
                                                      .visitSubType ==
                                                  "RETENTION SITE") {
                                                siteIdText = "Site ID";
                                              } else if (_addEventController
                                                      .visitSubType ==
                                                  "LEADS") {
                                                siteIdText = "Lead ID";
                                              } else if (_addEventController
                                                      .visitSubType ==
                                                  "CONVERSION OPPORTUNITY") {
                                                siteIdText = "Site ID";
                                              } else if (_addEventController
                                                      .visitSubType ==
                                                  "COUNTER") {
                                                siteIdText = "COUNTER Code";
                                              } else if (_addEventController
                                                      .visitSubType ==
                                                  "TECHNOCRAT") {
                                                siteIdText =
                                                    "Influencer Contact";
                                              } else if (_addEventController
                                                      .visitSubType ==
                                                  "CONTRACTOR") {
                                                siteIdText =
                                                    "Influencer Contact";
                                              }
                                            },
                                            items: <String>[
                                              _addEventController.visitSubType
                                              // 'RETENTION SITE',
                                              // 'LEADS',
                                              // 'CONVERSION OPPORTUNITY',
                                              // 'COUNTER',
                                              // 'TECHNOCRAT'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: GoogleFonts.roboto(
                                                      color: ColorConstants
                                                          .inputBoxHintColorDark,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _addEventController.visitSubType,
                                            style: GoogleFonts.roboto(
                                                color: ColorConstants
                                                    .inputBoxHintColorDark,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  TextFormField(
                                    key: Key(_addEventController.visitSiteId),
                                    initialValue:
                                        _addEventController.visitSiteId,
                                    enabled: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Site ID can't be empty";
                                      }
                                      return null;
                                    },
                                    onChanged: (_) {
                                      _addEventController.visitSiteId =
                                          _.toString();
                                    },
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: _inputDecoration(
                                        "${_visitSubType(_addEventController.visitSubType)}",
                                        false),
                                  ),
                                  SizedBox(height: 16),

                                  ////Only in case of counter
                                  Obx(
                                    () => (_addEventController.visitSubType ==
                                            "COUNTER")
                                        ? Column(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0,
                                                          right: 3,
                                                          bottom: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            5.0) //                 <--- border radius here
                                                        ),
                                                  ),
                                                  child:
                                                  Obx(
                                                        () =>
                                                    (_addEventController.visitResponseModel.mwpVisitModel.visitEndTime != null) ?
                                                  CheckboxListTile(
                                                    onChanged: (_){},
                                                    title: Text(
                                                      "DSP Available",
                                                      style: TextStyles
                                                          .formfieldLabelText,
                                                    ),
                                                    activeColor: Colors.black,
                                                    dense: true,
                                                    value: (_addEventController
                                                        .isDspAvailable ==
                                                        "Y")
                                                        ? true
                                                        : false,

                                                    controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading, //  <-- leading Checkbox
                                                  ):
                                                  CheckboxListTile(
                                                    title: Text(
                                                      "DSP Available",
                                                      style: TextStyles
                                                          .formfieldLabelText,
                                                    ),
                                                    activeColor: Colors.black,
                                                    dense: true,
                                                    value: (_addEventController
                                                                .isDspAvailable ==
                                                            "Y")
                                                        ? true
                                                        : false,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        if (newValue == true) {
                                                          _addEventController
                                                                  .isDspAvailable =
                                                              "Y";
                                                        } else {
                                                          _addEventController
                                                                  .isDspAvailable =
                                                              "N";
                                                          _addEventController.dspAvailableQty = null;
                                                          print("******${_addEventController.dspAvailableQty}");

                                                        }
                                                      });
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading, //  <-- leading Checkbox
                                                  )),),
                                              SizedBox(height: 16),
                                              Visibility(
                                                visible: (_addEventController
                                                            .isDspAvailable ==
                                                        "Y")
                                                    ? true
                                                    : false,
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              bottom: 20,
                                                              left: 5),
                                                      child: Text(
                                                        "DSP Availble Quantity",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15,
                                                            // color: HexColor("#000000DE"),
                                                            fontFamily: "Muli"),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        10.0),
                                                            child:
                                                            Obx(
                                                                  () =>
                                                            (_addEventController.visitResponseModel.mwpVisitModel.visitEndTime != null)?
                                                            TextFormField(
                                                              controller: _addEventController.bagsController,
                                                              readOnly: true,

                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorConstants
                                                                      .inputBoxHintColor,
                                                                  fontFamily:
                                                                  "Muli"),
                                                              // keyboardType: TextInputType.text,
                                                              decoration:
                                                              FormFieldStyle
                                                                  .buildInputDecoration(
                                                                labelText:
                                                                "Bags",
                                                              ),
                                                            ):
                                                              TextFormField(
                                                                  controller: _addEventController.bagsController,
                                                              onChanged: (_) {
                                                                setState(() {
                                                                  if (_addEventController.bagsController.text == null || _addEventController.bagsController.text == "") {
                                                                    _addEventController.mtController.clear();
                                                                  } else {
                                                                    _addEventController.mtController.text = (int.parse(_addEventController.bagsController.text) / 20).toString();
                                                                  }
                                                                  _addEventController.dspAvailableQty = _.toString();
                                                                });
                                                              },
                                                              keyboardType:
                                                                  TextInputType
                                                                      .phone,
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return 'Please enter Bags ';
                                                                }

                                                                return null;
                                                              },

                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorConstants
                                                                      .inputBoxHintColor,
                                                                  fontFamily:
                                                                      "Muli"),
                                                              // keyboardType: TextInputType.text,
                                                              decoration:
                                                                  FormFieldStyle
                                                                      .buildInputDecoration(
                                                                labelText:
                                                                    "Bags",
                                                              ),
                                                            ),),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child:Obx(
                                                                  () =>
                                                            (_addEventController.visitResponseModel.mwpVisitModel.visitEndTime != null)?
                                                            TextFormField(
                                                              controller: _addEventController.mtController,
                                                              readOnly: true,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorConstants
                                                                      .inputBoxHintColor,
                                                                  fontFamily:
                                                                  "Muli"),

                                                              decoration:
                                                              FormFieldStyle
                                                                  .buildInputDecoration(
                                                                labelText: "MT",
                                                              ),
                                                            ):
                                                                 TextFormField(
                                                              controller: _addEventController.mtController,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  if (value == null || value == "") {
                                                                    _addEventController.bagsController.clear();
                                                                    _addEventController.dspAvailableQty = "";
                                                                  } else {
                                                                    _addEventController.dspAvailableQty = (double.parse(value) * 20).toInt().toString();
                                                                    _addEventController.bagsController.text = (double.parse(value) * 20).toInt().toString();
                                                                  }
                                                                });
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return 'Please enter MT ';
                                                                }

                                                                return null;
                                                              },
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorConstants
                                                                      .inputBoxHintColor,
                                                                  fontFamily:
                                                                      "Muli"),
                                                              keyboardType: TextInputType
                                                                  .numberWithOptions(
                                                                      decimal:
                                                                          true),
                                                              decoration:
                                                                  FormFieldStyle
                                                                      .buildInputDecoration(
                                                                labelText: "MT",
                                                              ),
                                                            ),
                                                          ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 0,
                                          ),
                                  ),

                                  Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorConstants
                                                  .inputBoxBorderSideColor)),
                                      child: Obx(
                                        () => (_addEventController
                                                            .visitResponseModel
                                                            .mwpVisitModel
                                                            .visitStartTime ==
                                                        null &&
                                                    _addEventController
                                                            .visitResponseModel
                                                            .mwpVisitModel
                                                            .visitEndTime ==
                                                        null) ||
                                                (_addEventController
                                                            .visitResponseModel
                                                            .mwpVisitModel
                                                            .visitStartTime !=
                                                        null &&
                                                    _addEventController
                                                            .visitResponseModel
                                                            .mwpVisitModel
                                                            .visitEndTime ==
                                                        null)
                                            ? DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: _addEventController
                                                      .visitType,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      _addEventController
                                                          .visitType = newValue;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'PHYSICAL',
                                                    'VIRTUAL',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: GoogleFonts.roboto(
                                                            color: ColorConstants
                                                                .inputBoxHintColorDark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16.0),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _addEventController.visitType,
                                                  style: GoogleFonts.roboto(
                                                      color: ColorConstants
                                                          .inputBoxHintColorDark,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                      )),
                                  SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: ColorConstants
                                                .lineColorFilter)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(
                                              () => Text(
                                                // "${this._addEventController.visitDateTime}",
                                                "${this._addEventController.visitViewDateTime}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontFamily: "Muli"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                              child: Icon(
                                                Icons.calendar_today_sharp,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              ColorConstants.lineColorFilter),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() => Text(
                                                  "${this._addEventController.nextVisitDate}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorConstants
                                                          .blackColor,
                                                      fontFamily: "Muli"),
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                _selectDateNextVisit(context);
                                              },
                                              child: Icon(
                                                Icons.calendar_today_sharp,
                                                color: Colors.orange,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  (_addEventController.visitSubType ==
                                              "COUNTER" &&
                                          _addEventController
                                                  .visitResponseModel
                                                  .mwpVisitModel
                                                  .visitStartTime ==
                                              null &&
                                          _addEventController.visitResponseModel
                                                  .mwpVisitModel.visitEndTime ==
                                              null)
                                      ? Container()
                                      : (_addEventController
                                                      .visitSubType ==
                                                  "COUNTER" &&
                                              _addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitStartTime !=
                                                  null &&
                                              _addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitEndTime ==
                                                  null)
                                          ? DropdownButtonFormField(
                                              validator: (value) => value ==
                                                      null
                                                  ? 'Please select Visit Outcome Type'
                                                  : null,

                                              onChanged: (value) {
                                                print(value);
                                                _addEventController
                                                    .visitOutcomes = value;
                                              },
                                              items: [
                                                'RAPPORT BUILDING',
                                                'DEMAND GENERATION',
                                                'EVENT PLANNING',
                                                'EVENT EXECUTION',
                                                'OTHERS'
                                              ]
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(
                                                          e.toUpperCase(),
                                                        ),
                                                        value: e,
                                                      ))
                                                  .toList(),
                                              style: FormFieldStyle
                                                  .formFieldTextStyle,
                                              decoration: FormFieldStyle
                                                  .buildInputDecoration(
                                                      labelText:
                                                          "Visit Outcome"),
                                              // ),
                                            )
                                          : _addEventController.visitSubType ==
                                                  "COUNTER"
                                              ? TextFormField(
                                                  readOnly: true,
                                                  decoration: FormFieldStyle
                                                      .buildInputDecoration(
                                                    hintText:
                                                        _addEventController
                                                            .visitOutcomes,
                                                  ),
                                                )
                                              : Container(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Obx(() => (_addEventController
                                                  .visitResponseModel
                                                  .mwpVisitModel
                                                  .visitStartTime ==
                                              null &&
                                          _addEventController.visitResponseModel
                                                  .mwpVisitModel.visitEndTime ==
                                              null)
                                      ? TextFormField(
                                          key: Key(
                                              _addEventController.visitRemarks),
                                          initialValue:
                                              _addEventController.visitRemarks ==
                                                      'null'
                                                  ? ''
                                                  : _addEventController
                                                      .visitRemarks,
                                          onSaved: (val) {
                                            print('saved' + val);
                                            _addEventController.visitRemarks =
                                                val;
                                          },
                                          // onChanged: (_) {
                                          //   _addEventController.visitRemarks =
                                          //       _.toString();
                                          // },

                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  ColorConstants.inputBoxHintColor,
                                              fontFamily: "Muli"),
                                          maxLines: 3,
                                          decoration: _inputDecoration("Remarks", false))
                                      : (_addEventController.visitResponseModel.mwpVisitModel.visitStartTime != null && _addEventController.visitResponseModel.mwpVisitModel.visitEndTime == null)
                                          ? TextFormField(
                                              key: Key(_addEventController.visitRemarks),
                                              initialValue: _addEventController.visitRemarks,
                                              onSaved: (val) {
                                                print('saved' + val);
                                                _addEventController
                                                    .visitRemarks = val;
                                              },
                                              // onChanged: (_) {
                                              //   _addEventController.visitRemarks =
                                              //       _.toString();
                                              // },

                                              style: TextStyle(fontSize: 18, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                              maxLines: 3,
                                              decoration: _inputDecoration("Remarks", false))
                                          : TextFormField(
                                              key: Key(_addEventController.visitRemarks),
                                              readOnly: true,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter remarks ';
                                                }
                                                return null;
                                              },
                                              initialValue: _addEventController.visitRemarks,
                                              onSaved: (val) {
                                                print('saved' + val);
                                                _addEventController
                                                    .visitRemarks = val;
                                              },
                                              style: TextStyle(fontSize: 18, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                              keyboardType: TextInputType.text,
                                              maxLines: 3,
                                              decoration: _inputDecoration("Remarks", false))),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Obx(() => (_addEventController
                                                  .visitResponseModel
                                                  .mwpVisitModel
                                                  .visitStartTime ==
                                              null &&
                                          _addEventController.visitResponseModel
                                                  .mwpVisitModel.visitEndTime ==
                                              null)
                                      ? returnUpdateRow()
                                      : (_addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitStartTime !=
                                                  null &&
                                              _addEventController
                                                      .visitResponseModel
                                                      .mwpVisitModel
                                                      .visitEndTime ==
                                                  null)
                                          ? returnEndRow()
                                          : Container()),
                                  SizedBox(height: 50),
                                ],
                              ),
                            )
                          ],
                        ))
                    : Container()
            // : Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: Text(
            //           "Please wait, Loading Data..",
            //           style: TextStyle(
            //               color: ColorConstants.greenText,
            //               fontFamily: "Muli-Semibold.ttf",
            //               fontSize: 20,
            //               letterSpacing: .15),
            //         ),
            //       ),
            //     ],
            //   ),
            ));
  }

  Widget returnUpdateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorConstants.buttonNormalColor,),
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              //afterRequestLayout(empId, mobileNumber);
              _formKey.currentState.save();
              _addEventController.visitActionType = "UPDATE";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT, context);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'UPDATE EVENT',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        ),
    ElevatedButton(
    style: ElevatedButton.styleFrom(
          primary: ColorConstants.buttonNormalColor,),
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              //afterRequestLayout(empId, mobileNumber);
              _formKey.currentState.save();
              _addEventController.visitActionType = "START";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT, context);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'START',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        )
      ],
    );
  }

  Widget returnEndRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
    ElevatedButton(
    style: ElevatedButton.styleFrom(          primary: ColorConstants.buttonNormalColor,
    ),          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _addEventController.visitActionType = "END";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT, context);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'END',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        )
      ],
    );
  }

  InputDecoration _inputDecoration(String labelText, bool suffixStatus) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      labelText: labelText,
      filled: true,
      suffixIcon: (suffixStatus == true)
          ? GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Icon(Icons.calendar_today_rounded,
                  color: Colors.deepOrangeAccent))
          : null,
      focusColor: Colors.black,
      labelStyle: GoogleFonts.roboto(
          color: ColorConstants.inputBoxHintColorDark,
          fontWeight: FontWeight.normal,
          fontSize: 16.0),
      fillColor: ColorConstants.backgroundColor,
    );
  }

  String _visitSubType(String visitSubType) {
    String visitSubTypeText = "";
    if (_addEventController.visitSubType == "RETENTION SITE") {
      visitSubTypeText = "Site ID";
    } else if (_addEventController.visitSubType == "LEADS") {
      visitSubTypeText = "Lead ID";
    } else if (_addEventController.visitSubType == "CONVERSION OPPORTUNITY") {
      visitSubTypeText = "Site ID";
    } else if (_addEventController.visitSubType == "COUNTER") {
      visitSubTypeText = "COUNTER Code";
    } else if (_addEventController.visitSubType == "TECHNOCRAT") {
      visitSubTypeText = "Influencer Contact";
    } else if (_addEventController.visitSubType == "CONTRACTOR") {
      visitSubTypeText = "Influencer Contact";
    }
    return visitSubTypeText;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateString = formattedDate;
        this._addEventController.visitDateTime = selectedDateString;
      });
  }

  Future<void> _selectDateNextVisit(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateString = formattedDate;
        this._addEventController.nextVisitDate = selectedDateString;
        print(this._addEventController.nextVisitDate);
      });
  }



}
