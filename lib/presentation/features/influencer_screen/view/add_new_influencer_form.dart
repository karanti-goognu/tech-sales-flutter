import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/functions/validation.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormAddInfluencer extends StatefulWidget {
  @override
  _FormAddInfluencerState createState() => _FormAddInfluencerState();
}

class _FormAddInfluencerState extends State<FormAddInfluencer> {
  final _addInfluencerFormKey = GlobalKey<FormState>();
  final _addInfluencerFormKeyNext = GlobalKey<FormState>();

  InfController _infController = Get.find();
  InfluencerTypeModel _influencerTypeModel;
  StateDistrictListModel _stateDistrictListModel;

  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _giftAddressController = TextEditingController();
  TextEditingController _giftPincodeController = TextEditingController();
  TextEditingController _giftDistrictController = TextEditingController();
  TextEditingController _giftStateController = TextEditingController();
  TextEditingController _totalPotentialController = TextEditingController();
  TextEditingController _potentialSiteController = TextEditingController();
  TextEditingController _enrollmentDateController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _query = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _baseCityController = TextEditingController();
  TextEditingController _talukaController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  var _date = 'Date of Birth*';
  //var _enrollmentDate = 'Enrollment Date';
  bool _isVisible = true;
  bool _isSecondVisible = false;
  bool checkedValue = false;
  bool _qualificationVisible = false;

  String _selectedEnrollValue = "N";
  int _memberType;
  String _district;
  int _influencerCategory;
  int _source;

  @override
  void initState() {
    super.initState();
    getEmpId();
    _enrollmentDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    getDropdownData();
    getDistrictData();
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getDropdownData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _infController.getInfType().then((data) {
                setState(() {
                  if (data != null) {
                    _influencerTypeModel = data;
                  }
                });
                print('RESPONSE, ${data}');
              })
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

  getDistrictData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _infController.getDistList().then((data) {
                setState(() {
                  if (data != null) {
                    _stateDistrictListModel = data;
                  }
                });
                print('RESPONSE, ${data}');
              })
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    double _height = ScreenUtil().setSp(16);

    final mobileNumber = TextFormField(
      controller: _contactNumberController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter mobile number ';
        }else if (value.length!=10) {
          return 'Mobile number must be of 10 digit';
        }
        if (!Validations.isValidPhoneNumber(value)) {
          return 'Enter valid mobile number';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      //maxLengthEnforced: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Mobile number*",
      ),
      onChanged: (value) {
        if (value.length == 10) {
          _infController.getInfData(value).then((data) {
            setState(() {
              if (data != null) {
                if (data.respCode == "NUM404") {
                  _contactNumberController.text = value;
                } else if (data.respCode == "DM1002") {
                  Get.dialog(
                      CustomDialogs().showDialogInfPresent(data.respMsg), barrierDismissible: false);
                  _contactNumberController.text = "";
                }
              }
            });
            print('RESPONSE, ${data}');
          });
        }
      },
    );

    final email = TextFormField(
      controller: _emailController,
      validator: (value) {
        // if (value.isEmpty) {
        //   return 'Please enter email ';
        // }
        if (value.isNotEmpty && !Validations.isEmail(value)) {
          return 'Enter valid email ';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.emailAddress,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Email",
      ),
    );

    final name = TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value.isEmpty || value.length <=0 || value == null || value == " " || value.trim().isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9.a-zA-Z ]")), ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Name*",
      ),
    );

    final fatherName = TextFormField(
      controller: _fatherNameController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9.a-zA-Z ]")), ],
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Father Name",
      ),
    );

    final baseCity = TextFormField(
      controller: _baseCityController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Base City",
      ),
    );

    final taluka = TextFormField(
      controller: _talukaController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Taluka",
      ),
    );

    final pincode = TextFormField(
      controller: _pincodeController,
      validator: (value) {
        // if (value.isEmpty) {
        //   return 'Please enter name';
        // }
        if (!value.isEmpty && !Validations.isValidPincode(value)) {
          return "Enter valid pincode";
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    // final enrollDropDwn = DropdownButtonFormField(
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedEnrollValue = value;
    //     });
    //   },
    //   items: ['Yes', 'No']
    //       .map((e) => DropdownMenuItem(
    //             value: e,
    //             child: Text(e),
    //           ))
    //       .toList(),
    //   style: FormFieldStyle.formFieldTextStyle,
    //   decoration: FormFieldStyle.buildInputDecoration(
    //       labelText: "Enroll for Dalmia Masters *"),
    //   validator: (value) =>
    //       value == null ? 'Please select Dalmia Master' : null,
    // );

    final enrollmentCheckbox = Container(
        padding: const EdgeInsets.only(left: 3.0, right: 3, top: 5, bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
              ),
        ),
        child: CheckboxListTile(
          title: Text(
            "Enroll for Dalmia Masters *",
            style: TextStyles.formfieldLabelText,
          ),
          activeColor: Colors.black,
          dense: true,
          value: checkedValue,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue;
              if (checkedValue == true) {
                _selectedEnrollValue = "Y";
              } else {
                _selectedEnrollValue = "N";
              }
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ));

    final district = TextFormField(
      validator: (value) => value.isEmpty ? 'Please select District' : null,
      controller: _districtController,
      readOnly: true,
      onTap: () {
        setState(() {
          Get.bottomSheet(districtList());
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District Name*",
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Icon(
            Icons.my_location,
            size: 20,
            color: HexColor('#F9A61A'),
          ),
        ),
      ),
    );

    final memberDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _memberType = value;
          if (_memberType == 2 || _memberType == 3 || _memberType == 4
              //_memberType == 'Structural Consultant'
              ) {
            _qualificationVisible = true;
          } else {
            _qualificationVisible = false;
          }
        });
      },
      items: (_influencerTypeModel == null || _influencerTypeModel.response.influencerTypeList == null)
          ? []
          : _influencerTypeModel.response.influencerTypeList
              .map((e) => DropdownMenuItem(
                    value: e.inflTypeId,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.inflTypeDesc)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Member Type*"),
      validator: (value) => value == null ? 'Please select member type' : null,
    );

    final qualification = TextFormField(
      controller: _qualificationController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter qualification';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Qualification",
      ),
    );

    final birthDate = TextFormField(
      validator: (value) => value.isEmpty ? 'Please select Birth date' : null,
      controller: _dateController,
      readOnly: true,
      onTap: () {
        setState(() {
          _selectBirthDate();
        });
      },
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Birth Date*",
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Icon(
            Icons.calendar_today,
            size: 20,
            color: HexColor('#F9A61A'),
          ),
        ),
      ),
    );

    // final enrollmentDate = Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(width: 1, color: Colors.black26),
    //       borderRadius: BorderRadius.circular(3),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 5, bottom: 5),
    //       child: RaisedButton(
    //         color: Colors.white,
    //         elevation: 0,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Expanded(child: Text(_enrollmentDate)),
    //             Icon(
    //               Icons.calendar_today,
    //               color: ColorConstants.clearAllTextColor,
    //             ),
    //           ],
    //         ),
    //         onPressed: () {
    //           //_selectEnrollmentDate();
    //         },
    //       ),
    //     ));

    final enrollmentDate = TextFormField(
      controller: _enrollmentDateController,
      style: FormFieldStyle.formFieldTextStyle,
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Enrollment Date",
      ),
    );

    final btnNext = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "1/2",
          style: TextStyles.welcomeMsgTextStyle20,
        ),
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "NEXT",
            style:
                //TextStyles.btnWhite,
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2,
                    fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {
            setState(() {
              if (_addInfluencerFormKey.currentState.validate()) {
                _isVisible = false;
                _isSecondVisible = true;
              }
            });

            // btnPresssed();
          },
        ),
      ],
    );

    final giftAddress = TextFormField(
      controller: _giftAddressController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Address",
      ),
    );

    final giftPincode = TextFormField(
      controller: _giftPincodeController,
      validator: (value) {
        if (!value.isEmpty && !Validations.isValidPincode(value)) {
          return "Enter valid pincode";
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    final giftDistrict = TextFormField(
      controller: _giftDistrictController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District",
      ),
    );

    final giftState = TextFormField(
      controller: _giftStateController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "State",
      ),
    );

    final totalPotential = TextFormField(
      controller: _totalPotentialController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter Total Monthly Potential (MT)';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Total Monthly Potential (MT)",
      ),
    );

    final potentialSite = TextFormField(
      controller: _potentialSiteController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter Potential sites';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Potential sites",
      ),
    );

    final sourceDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _source = value;
        });
      },
      items: (_influencerTypeModel == null ||_influencerTypeModel.response.influencerSourceList == null )?[]: _influencerTypeModel.response.influencerSourceList
              .map((e) => DropdownMenuItem(
                    value: e.inflSourceId,
                    child: Text(e.inflSourceText),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Source"),
      //validator: (value) => value == null ? 'Please select Source' : null,
    );

    final influencerCategoryDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _influencerCategory = value;
        });
      },
      items: (_influencerTypeModel == null || _influencerTypeModel.response.influencerCategoryList == null)
          ? []
          : _influencerTypeModel.response.influencerCategoryList
              .map((e) => DropdownMenuItem(
                    value: e.inflCatId,
                    child: Text(e.inflCatDesc),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Influencer Category*"),
      validator: (value) =>
          value == null ? 'Please select Influencer Category' : null,
    );


    final btnSubmit = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "2/2",
          style: TextStyles.welcomeMsgTextStyle20,
        ),
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "SUBMIT",
            style:
                //TextStyles.btnWhite,
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2,
                    fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {
            setState(() {
              if (_addInfluencerFormKeyNext.currentState.validate()) {
                _addInfluencerFormKeyNext.currentState.save();
                _isVisible = false;
                _isSecondVisible = true;
                btnSubmitPresssed();
              }
            });
          },
        ),
      ],
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 200,
              right: 0,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/Container.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ))),
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(ScreenUtil().setSp(12)),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Influencer Details',
                      style: TextStyles.titleGreenStyle,
                    ),
                  ],
                ),
                // decoration: BoxDecoration(
                //     border: Border(bottom: BorderSide(width: 0.3))),
              ),
              SizedBox(height: ScreenUtil().setSp(8)),
              Divider(
                height: ScreenUtil().setSp(1),
                color: Colors.grey,
              ),
              SizedBox(height: _height),
              Visibility(
                visible: _isVisible,
                child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                    child: Form(
                      key: _addInfluencerFormKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mobileNumber,
                            SizedBox(height: _height),
                            name,
                            SizedBox(height: _height),
                            email,
                            SizedBox(height: _height),
                            enrollmentCheckbox,
                            SizedBox(height: _height),
                            // enrollDropDwn,
                            // SizedBox(height: _height),
                            district,
                            SizedBox(height: _height),
                            baseCity,
                            SizedBox(height: _height),
                            taluka,
                            SizedBox(height: _height),
                            pincode,
                            SizedBox(height: _height),
                            memberDropDwn,
                            SizedBox(height: _height),
                            birthDate,
                            SizedBox(height: _height),
                            fatherName,
                            SizedBox(height: _height),
                            Visibility(
                                visible: _qualificationVisible,
                                child: qualification),
                            SizedBox(height: _height),
                            enrollmentDate,
                            SizedBox(height: _height),
                            btnNext,
                            SizedBox(height: _height),
                          ]),
                    )),
              ),
              Visibility(
                visible: _isSecondVisible,
                child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                    child: Form(
                      key: _addInfluencerFormKeyNext,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address for gift disbursement",
                              style: TextStyles.welcomeMsgTextStyle20,
                            ),
                            SizedBox(height: _height),
                            giftAddress,
                            SizedBox(height: _height),
                            giftPincode,
                            SizedBox(height: _height),
                            giftDistrict,
                            SizedBox(height: _height),
                            giftState,
                            SizedBox(height: _height),
                            Divider(
                              height: ScreenUtil().setSp(1),
                              color: Colors.grey,
                            ),
                            SizedBox(height: _height),
                            totalPotential,
                            SizedBox(height: _height),
                            potentialSite,
                            SizedBox(height: _height),
                            influencerCategoryDropDwn,
                            SizedBox(height: _height),
                            sourceDropDwn,
                            SizedBox(height: _height),
                            btnSubmit,
                            SizedBox(height: _height),
                          ]),
                    )),
              )
            ],
          )
          //     : Center(
          //   child: CircularProgressIndicator(),
          // ),
          // ),
        ],
      ),
    );
  }

  Future _selectBirthDate() async {
    DateTime _picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());
    setState(() {
      _date = new DateFormat('yyyy-MM-dd').format(_picked);
      _dateController.text = _date;
      // var d = DateFormat('dd-MM-yyyy HH:mm:ss').format(_picked);
    });
  }

  // Future _selectEnrollmentDate() async {
  //   DateTime _picked = await showDatePicker(
  //       context: context,
  //       initialDate: new DateTime.now(),
  //       firstDate: new DateTime(1950),
  //       lastDate: new DateTime.now());
  //   setState(() {
  //     _date = new DateFormat('dd-MM-yyyy').format(_picked);
  //     // var d = DateFormat('dd-MM-yyyy HH:mm:ss').format(_picked);
  //   });
  // }

  String stateName;
  int stateId, districtId;

  districtList() {
    List<StateDistrictList> dist =
        _stateDistrictListModel.response.stateDistrictList;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
        color: Colors.white,
        height: 300,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Please select district from the below list',
              style: TextStyles.mulliBoldYellow18,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _query,
                onChanged: (value) {
                  setState(() {
                    dist = _stateDistrictListModel.response.stateDistrictList
                        .where((element) {
                      return element.districtName
                          .toString()
                          .toLowerCase()
                          .contains(value);
                    }).toList();
                  });
                },
                decoration: FormFieldStyle.buildInputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: 'Search'),
              ),
            ),
            Divider(),
            _stateDistrictListModel.response.stateDistrictList == null ||
                    _stateDistrictListModel.response.stateDistrictList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView(
                      children: dist
                          //_stateDistrictListModel.response.stateDistrictList
                          .map(
                            (e) => RadioListTile(
                                value: e,
                                title:
                                    Text('${e.districtName} (${e.stateName})'),
                                // groupValue: customer,
                                onChanged: (text) {
                                  setState(() {
                                    _districtController.text =
                                        text.districtName;
                                    stateName = text.stateName;
                                    stateId = text.stateId;
                                    districtId = text.districtId;
                                    // customer = text;
                                  });
                                  Get.back();
                                }),
                          )
                          .toList(),
                      shrinkWrap: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  btnSubmitPresssed() async {
    String empId = await getEmpId();
    InfluencerRequestModel _influencerRequestModel =
        InfluencerRequestModel.fromJson({
          "membershipId": null,
      "baseCity": _baseCityController.text,
      "createBy": empId,
      "dealership": "N",
      "districtId": districtId,
      "districtName": _districtController.text,
      "email": _emailController.text,
      "fatherName": _fatherNameController.text,
      "giftAddress": _giftAddressController.text,
      "giftAddressDistrict": _giftDistrictController.text,
      "giftAddressPincode": _giftPincodeController.text,
      "giftAddressState": _giftStateController.text,
      "ilpRegFlag": _selectedEnrollValue,
      "inflAddress": "",
      "inflCategoryId": _influencerCategory,
      "inflContactNumber": _contactNumberController.text,
      "inflDob": _dateController.text,
      "inflEnrollmentSourceId": _source,
      "inflJoiningDate": _enrollmentDateController.text,
      "inflName": _nameController.text,
      "inflQualification": _qualificationController.text,
      "inflTypeId": _memberType,
      "isActive": "Y",
      "loyaltyLinkage": "test",
      "monthlyPotentialVolumeMT": int.tryParse(_totalPotentialController.text),
      "pinCode": _pincodeController.text,
      "siteAssignedCount": int.tryParse(_potentialSiteController.text),
      "stateId": stateId,
      "stateName": stateName,
      "taluka": _talukaController.text
    });

    //  InfluencerRequestModel _request = InfluencerRequestModel(
    //    baseCity: _baseCityController.text,
    //    createBy: _nameController.text,
    //    dealership: "N",
    //   districtId: districtId,
    //   districtName: _districtController.text,
    //   email: _emailController.text,
    //   fatherName: _fatherNameController.text,
    //   giftAddress: _giftAddressController.text,
    //   giftAddressDistrict: _giftDistrictController.text,
    //   giftAddressPincode: _giftPincodeController.text,
    //   giftAddressState: _giftStateController.text,
    //   ilpRegFlag: "N",
    //   inflAddress: "",
    //   inflCategoryId: _influencerCategory,
    //   inflContactNumber: _contactNumberController.text,
    //   inflDob: _date,
    //   inflEnrollmentSourceId: _source,
    //   inflJoiningDate: _enrollmentDateController.text,
    //   inflName: _nameController.text,
    //   inflQualification: _qualificationController.text,
    //   inflTypeId: _memberType,
    //   isActive: "Y",
    //   loyaltyLinkage : "test",
    //   monthlyPotentialVolumeMT: int.tryParse(_potentialSiteController.text),
    //   pinCode: _pincodeController.text,
    //   siteAssignedCount: int.tryParse(_potentialSiteController.text),
    //   stateId: stateId,
    //   stateName: stateName,
    //   taluka: _talukaController.text
    // );

    print('PARAMS: ${json.encode(_influencerRequestModel)}');

    internetChecking().then((result) => {
          if (result == true)
            {
              _infController.getAccessKeyAndSaveInfluencer(
                  _influencerRequestModel, false)
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
}
