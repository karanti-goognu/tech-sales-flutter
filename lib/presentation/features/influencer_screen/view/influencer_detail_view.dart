import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
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

class InfluencerDetailView extends StatefulWidget {
  int membershipId;
  InfluencerDetailView(this.membershipId);
  @override
  _InfluencerDetailViewState createState() => _InfluencerDetailViewState();
}

class _InfluencerDetailViewState extends State<InfluencerDetailView> {
  InfController _infController = Get.find();
  InfluencerDetailDataModel _influencerDetailDataModel;
  final _addInfluencerFormKey = GlobalKey<FormState>();
  StateDistrictListModel _stateDistrictListModel;

  List<InfluencerTypeEntitiesList> influencerTypeEntitiesList = new List();
  InfluencerTypeEntitiesList _influencerTypeEntitiesList;

  List<InfluencerCategoryEntitiesList> influencerCategoryEntitiesList = new List();
  InfluencerCategoryEntitiesList _influencerCategoryEntitiesList;

  List<InfluencerSourceList> influencerSourceList = new List();
  InfluencerSourceList _influencerSourceList;
  //var _date = 'Date of Birth*';
  bool _qualificationVisible = false;
  int _influencerCategory;
  int _source;
  int _memberType, memberShipId;
  String _selecedSource;
  String _selectedEnrollValue;
  bool checkedValue = false;

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
  FocusNode myFocusNode;

  //final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    memberShipId = widget.membershipId;
    myFocusNode = FocusNode();
    getEmpId();
    getData();
    getDistrictData();
    // Future.delayed(const Duration(milliseconds: 300));
    // SchedulerBinding.instance?.addPostFrameCallback((_) {
    //   _scrollController.animateTo(
    //       _scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 400),
    //       curve: Curves.fastOutSlowIn);
    // });
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    print("*****${empID}");
    return empID;
  }

  getData() {
    internetChecking().then((result) =>
    {
      if (result == true)
        {
          _infController.getInfDetailData('${widget.membershipId}').then((data) {
            setState(() {
              if (data != null) {
                 _influencerDetailDataModel = data;
                 setData();
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
    internetChecking().then((result) =>
    {
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

  setData(){
    if(_influencerDetailDataModel != null || _influencerDetailDataModel.response != null || _influencerDetailDataModel.response.influencerDetails != null) {
      InfluencerDetails _data = _influencerDetailDataModel.response.influencerDetails;
      // memberShipId = _data.id;
      _contactNumberController.text = _data.inflContactNumber;
      _nameController.text = _data.inflName;
      _fatherNameController.text = _data.fatherName;
      _districtController.text = _data.districtName;
      _giftAddressController.text = _data.giftAddress;
      _giftPincodeController.text = _data.giftAddressPincode;
      _giftDistrictController.text = _data.giftAddressDistrict;
      _giftStateController.text = _data.giftAddressState;
      _totalPotentialController.text = '${_data.monthlyPotentialVolumeMT}' == "null" ? "" : '${_data.monthlyPotentialVolumeMT}';
      _potentialSiteController.text = '${_data.siteAssignedCount}'== "null" ? "" :'${_data.siteAssignedCount}';
      _enrollmentDateController.text = '${_data.inflJoiningDate}';
      _qualificationController.text = _data.inflQualification;
      _emailController.text = _data.email;
      _baseCityController.text = _data.baseCity;
      _talukaController.text = _data.taluka;
      _pincodeController.text = _data.pinCode;
      _source = _data.inflEnrollmentSourceId;
      _memberType = _data.inflTypeId;
      _influencerCategory = _data.inflCategoryId;
      //_date = '${_data.inflDob}';

      _dateController.text = '${_data.inflDob}' == "null" ? "Birth Date" : '${_data.inflDob}';

      if(_data.ilpregFlag == "Y"){
        checkedValue = true;
        _selectedEnrollValue = "Y";
      }else{
        checkedValue = false;
        _selectedEnrollValue = "N";
      }


      influencerTypeEntitiesList = _influencerDetailDataModel.response.influencerTypeEntitiesList;
      if (_influencerDetailDataModel.response.influencerDetails.inflTypeId != null) {
        for (int i = 0; i < influencerTypeEntitiesList.length; i++) {
          if (_influencerDetailDataModel.response.influencerDetails.inflTypeId
              .toString() ==
              influencerTypeEntitiesList[i].inflTypeId.toString()) {
            _influencerTypeEntitiesList = influencerTypeEntitiesList[i];
          }
        }
      }else{

      }

      influencerSourceList = _influencerDetailDataModel.response.influencerSourceList;
      if (_influencerDetailDataModel.response.influencerDetails.inflEnrollmentSourceId != null) {
        for (int i = 0; i < influencerSourceList.length; i++) {
          if (_influencerDetailDataModel.response.influencerDetails.inflEnrollmentSourceId
              .toString() ==
              influencerSourceList[i].inflSourceId.toString()) {
            _influencerSourceList = influencerSourceList[i];
          }
        }
      }else{

      }

      influencerCategoryEntitiesList = _influencerDetailDataModel.response.influencerCategoryEntitiesList;
      if (_influencerDetailDataModel.response.influencerDetails.inflCategoryId != null) {
        for (int i = 0; i < influencerCategoryEntitiesList.length; i++) {
          if (_influencerDetailDataModel.response.influencerDetails.inflCategoryId
              .toString() ==
              influencerCategoryEntitiesList[i].inflCatId.toString()) {
            _influencerCategoryEntitiesList = influencerCategoryEntitiesList[i];
          }
        }
      }else{

      }
      districtId = _data.districtId;
      stateName = _data.stateName;
      stateId = _data.stateId;
      myFocusNode = FocusNode();
      myFocusNode.requestFocus();
    }


  }

  @override
  void dispose() {
    myFocusNode?.dispose();
    myFocusNode = null;
    super.dispose();
  }


  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)
      ..init(context);
    double _height = ScreenUtil().setSp(16);

    final mobileNumber = TextFormField(
      controller: _contactNumberController,
      focusNode: myFocusNode,
      style: FormFieldStyle.formFieldTextStyle,
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Mobile number*",
      ),
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
        if (value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
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
    //       //_selectedEnrollValue = value;
    //     });
    //   },
    //   items: ['Yes', 'No']
    //       .map((e) => DropdownMenuItem(
    //     value: e,
    //     child: Text(e),
    //   ))
    //       .toList(),
    //   style: FormFieldStyle.formFieldTextStyle,
    //   decoration: FormFieldStyle.buildInputDecoration(
    //       labelText: "Enroll for Dalmia Masters *"),
    //   validator: (value) =>
    //   value == null ? 'Please select Dalmia Master' : null,
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
        Get.bottomSheet(districtList());
      },
      style: FormFieldStyle.formFieldTextStyle,
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

    final memberDropDwn = DropdownButtonFormField<InfluencerTypeEntitiesList>(
      value: _influencerTypeEntitiesList,
      onChanged: (value) {
        setState(() {
          _influencerTypeEntitiesList = value;
          _memberType = _influencerTypeEntitiesList.inflTypeId;
          if (_memberType == 2 || _memberType == 3 || _memberType == 4
          //_memberType == 'Structural Consultant'
          ) {
            _qualificationVisible = true;
          } else {
            _qualificationVisible = false;
          }
        });
      },
      items:(_influencerDetailDataModel == null || _influencerTypeEntitiesList == null) ? []:
          influencerTypeEntitiesList.map((e) => DropdownMenuItem(
        value: e,
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

    final enrollmentDate = TextFormField(
      controller: _enrollmentDateController,
      style: FormFieldStyle.formFieldTextStyle,
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Enrollment Date",
      ),
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
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District",
      ),
    );

    final giftState = TextFormField(
      controller: _giftStateController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
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
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Potential sites",
      ),
    );

    final sourceDropDwn = DropdownButtonFormField<InfluencerSourceList>(
      value: _influencerSourceList,
      onChanged: (value) {
        setState(() {
          _influencerSourceList = value;
          _source = _influencerSourceList.inflSourceId;
        });
      },
      items: (_influencerDetailDataModel == null || influencerSourceList == null)
          ? []
          : influencerSourceList.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e.inflSourceText),
      ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Source"),
     // validator: (value) => value == null ? 'Please select Source' : null,
    );

    final influencerCategoryDropDwn = DropdownButtonFormField<InfluencerCategoryEntitiesList>(
      value: _influencerCategoryEntitiesList,
      onChanged: (value) {
        setState(() {
          _influencerCategoryEntitiesList = value;
          _influencerCategory = _influencerCategoryEntitiesList.inflCatId;
        });
      },
      items: (_influencerDetailDataModel == null || influencerCategoryEntitiesList == null)
          ? []
          : influencerCategoryEntitiesList
          .map((e) => DropdownMenuItem(
        value: e,
        child: Text(e.inflCatDesc),
      ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
      FormFieldStyle.buildInputDecoration(labelText: "Influencer Category"),
      validator: (value) =>
      value == null ? 'Please select Influencer Category' : null,
    );

    final btnSubmit = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "UPDATE",
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
                _addInfluencerFormKey.currentState.save();
                  btnUpdatePresssed();
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
          SingleChildScrollView(
           // controller: _scrollController,
           // shrinkWrap: true,
            child: Column(


            children: [
              Container(
                padding: EdgeInsets.all(ScreenUtil().setSp(12)),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Influencer Details',
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

              //SizedBox(height: _height),
              Padding(
                  padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                  child: Form(
                    key: _addInfluencerFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Membership ID : ",
                                style: TextStyles.welcomeMsgTextStyle20,
                              ),
                              Text(
                                "${memberShipId}",
                                style: TextStyles.welcomeMsgTextStyle20,
                              ),
                            ],
                          ),
                          SizedBox(height: _height),
                          mobileNumber,
                          SizedBox(height: _height),
                          name,
                          SizedBox(height: _height),
                          email,
                          SizedBox(height: _height),
                          //enrollDropDwn,
                          enrollmentCheckbox,
                          SizedBox(height: _height),
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
            ],
          )
          //     : Center(
          //   child: CircularProgressIndicator(),
          // ),
          ),
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
      var _date;
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
      builder: (BuildContext context, StateSetter setState) =>
          Container(
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
                        dist =
                            _stateDistrictListModel.response.stateDistrictList
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
                          (e) =>
                          RadioListTile(
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


  btnUpdatePresssed() async{
    String empId = await getEmpId();
    InfluencerRequestModel _influencerRequestModel =
    InfluencerRequestModel.fromJson({
      "membershipId": memberShipId,
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
      "inflDob": _dateController.text == "Birth Date" ? "":_dateController.text,
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

    print('PARAMS: ${json.encode(_influencerRequestModel)}');

    internetChecking().then((result) => {
      if (result == true)
        {
          _infController
              .getAccessKeyAndSaveInfluencer(_influencerRequestModel, true)
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