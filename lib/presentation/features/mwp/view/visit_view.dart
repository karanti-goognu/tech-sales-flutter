import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';

class AddEventVisit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventVisitScreenPageState();
  }
}

class AddEventVisitScreenPageState extends State<AddEventVisit> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? selectedDateString;
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();
  var _nameController = TextEditingController();
  var _typeController = TextEditingController();
  var _categoryController = TextEditingController();
  var _ilpController = TextEditingController();
  var _siteCountController = TextEditingController();
  var _mPotentialController = TextEditingController();
  var _mLiftingController = TextEditingController();
  bool isFormSubmitted = false;

  @override
  void initState() {
    _addEventController.visitRemarks = null;
    _appController.getAccessKey(RequestIds.GET_DEALERS_LIST, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      // context:
      context,

      // BoxConstraints(
      //     maxWidth: MediaQuery.of(context).size.width,
      //     maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(360, 690),
      minTextAdapt: true,
      // orientation: Orientation.portrait,
    );

    final name = TextFormField(
      controller: _nameController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Influencer Name  "),
    );

    final type = TextFormField(
      controller: _typeController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Member Type"),
    );

    final category = TextFormField(
      controller: _categoryController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Influencer category"),
    );

    final iplMember = TextFormField(
      controller: _ilpController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Membership "),
    );

    final sitesCount = TextFormField(
      controller: _siteCountController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "No. of active sites "),
    );

    final mPotential = TextFormField(
      controller: _mPotentialController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Monthly potential"),
    );

    final mLifting = TextFormField(
      controller: _mLiftingController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Monthly Lifting"),
    );

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(
                      color: ColorConstants.inputBoxBorderSideColor)),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _addEventController.visitSubType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _addEventController.visitSubType = newValue;
                      });
                    },
                    items: <String>[
                      'LEADS',
                      'COUNTER',
                      'CONTRACTOR',
                      'TECHNOCRAT'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.roboto(
                              color: ColorConstants.inputBoxHintColorDark,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                        onTap: () {
                          setState(() {
                            switch (value) {
                              case "LEADS":
                                _addEventController.isVisibleContact = false;
                                _addEventController.siteIdText = "Lead ID";
                                break;
                              case "COUNTER":
                                _addEventController.isVisibleContact = false;
                                _addEventController.siteIdText = "Counter Code";
                                break;
                              case "CONTRACTOR":
                                _addEventController.siteIdText =
                                    "Influencer Contact";
                                break;
                              case "TECHNOCRAT":
                                _addEventController.siteIdText =
                                    "Influencer Contact";
                                break;
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _addEventController.siteIdText == "Counter Code"
                    ? DropdownButtonFormField(
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Counters"),
                        items: _addEventController.dealerList
                            .map<DropdownMenuItem<dynamic>>((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: SizedBox(
                                width: SizeConfig.screenWidth! - 100,
                                child: Text(
                                    '${val.dealerName} (${val.dealerId})')),
                          );
                        }).toList(),
                        onChanged: (dynamic val) {
                          _addEventController.visitSiteId = val.dealerId;
                        })
                    : TextFormField(
                        controller: _addEventController.contactController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "${_addEventController.siteIdText} can't be empty";
                          }
                          if (_addEventController.siteIdText ==
                              "Influencer Contact") {
                            if (value.isEmpty) {
                              return "Enter valid Contact number";
                            }
                          }
                          return null;
                        },
                        onChanged: (_) {
                          _addEventController.visitSiteId = _.toString();
                          if (_addEventController.siteIdText ==
                              "Influencer Contact") {
                            apiCallForGetInf(_);
                          }
                        },
                        maxLength: _addEventController.siteIdText ==
                                "Influencer Contact"
                            ? 10
                            : _addEventController.siteIdText == "Lead ID"
                                ? 6
                                : null,
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: _addEventController.siteIdText ==
                                "Influencer Contact"
                            ? TextInputType.numberWithOptions(signed: true)
                            : TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: _inputDecoration(
                            "${_addEventController.siteIdText}", false),
                      ),
                SizedBox(height: 16),
                Obx(
                  () => Visibility(
                    visible: _addEventController.isVisibleContact,
                    child: Column(
                      children: [
                        name,
                        SizedBox(height: 16),
                        category,
                        SizedBox(height: 16),
                        iplMember,
                        SizedBox(height: 16),
                        type,
                        SizedBox(height: 16),
                        sitesCount,
                        SizedBox(height: 16),
                        mPotential,
                        SizedBox(height: 16),
                        mLifting,
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => TextFormField(
                    decoration: FormFieldStyle.buildInputDecoration(
                      hintText: "${this._addEventController.visitDateTime}",
                      suffixIcon: Icon(
                        Icons.calendar_today_sharp,
                        color: Colors.orange,
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (this._addEventController.visitDateTime ==
                          "Visit Date") {
                        return "Visit Date can't be empty";
                      }
                      return null;
                    },
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    onChanged: (_) {
                      _addEventController.visitRemarks = _.toString();
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    decoration: _inputDecoration("Remarks", false)),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.buttonNormalColor,
                  ),
                  onPressed: isFormSubmitted
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            internetChecking().then((result) => {
                                  if (result == true)
                                    {
                                      setState(() => isFormSubmitted = true),
                                      _appController.getAccessKey(
                                          RequestIds.SAVE_VISIT, context),
                                      _addEventController.isLoading = true,
                                      _addEventController.isVisibleContact =
                                          false
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
                        },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      'ADD EVENT',
                      style: ButtonStyles.buttonStyleBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  apiCallForGetInf(String value) async {
    InfController _infController = Get.find();
    if (value.length < 10) {
      _nameController.text = "";
      _typeController.text = "";
      _categoryController.text = "";
      _ilpController.text = "";
      _siteCountController.text = "";
      _mPotentialController.text = "";
      _mLiftingController.text = "";
      _addEventController.isVisibleContact = false;
    } else if (value.length == 10) {
      _infController.getInfData(value).then((data) {
        setState(() {
          if (data != null) {
            if (data.respCode == "NUM404") {
              _addEventController.visitSiteId = "";
              _addEventController.contactController.text = "";
              Get.dialog(
                  CustomDialogs.showDialogInfNotPresent(
                      "register this influencer to proceed"),
                  barrierDismissible: false);
            } else if (data.respCode == "DM1002") {
              _addEventController.visitSiteId =
                  data.influencerModel!.inflContact;
              _nameController.text = data.influencerModel!.inflName!;
              _typeController.text = data.influencerModel!.influencerTypeText!;
              _categoryController.text =
                  data.influencerModel!.influencerCategoryText!;
              _ilpController.text = data.influencerModel!.ilpMember!;
              _siteCountController.text = '${data.influencerModel!.sitesCount}';
              _mPotentialController.text =
                  '${data.influencerModel!.monthlyPotential}';
              _mLiftingController.text =
                  '${data.influencerModel!.monthlyLifting}';
              _addEventController.isVisibleContact = true;
            }
          }
        });
        TsoLogger.printLog('RESPONSE, $data');
      });
    }
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateString = formattedDate;
        this._addEventController.visitDateTime = selectedDateString;
      });
    }
  }

  bool isValidPhoneNumber(String string) {
    if (string.isEmpty) {
      return false;
    }

    const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
