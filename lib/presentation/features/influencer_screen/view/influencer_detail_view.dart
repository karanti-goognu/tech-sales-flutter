import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
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

  List<InfluencerCategoryEntitiesList> influencerCategoryEntitiesList =
      new List.empty(growable: true);
  InfluencerCategoryEntitiesList _influencerCategoryEntitiesList;

  List<InfluencerSourceList> influencerSourceList = new List.empty(growable: true);
  InfluencerSourceList _influencerSourceList;

  List<SiteBrandList> siteBrandList = new List.empty(growable: true);
  SiteBrandList _siteBrandList;



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
  TextEditingController _primaryCounterController = TextEditingController();
  FocusNode myFocusNode;

  // If Engineer Type
  TextEditingController _designationController = TextEditingController();
  TextEditingController _departmentNameController = TextEditingController();
  int _preferredBrandId;
  TextEditingController _dateMarriageAnnController = TextEditingController();
  TextEditingController _firmNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    memberShipId = widget.membershipId;
    myFocusNode = FocusNode();
    getEmpId();
    getData();

  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _infController
                  .getInfDetailData('${widget.membershipId}')
                  .then((data) {
                setState(() {
                  if (data != null) {
                    _influencerDetailDataModel = data;
                    setData();
                  }
                });
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
  setData() {
    if (_influencerDetailDataModel != null ||
        _influencerDetailDataModel.response != null ||
        _influencerDetailDataModel.response.influencerDetails != null) {
      InfluencerDetails _data =
          _influencerDetailDataModel.response.influencerDetails;
      // memberShipId = _data.id;
      _contactNumberController.text = _data.inflContactNumber;
      _nameController.text = _data.inflName;
      _fatherNameController.text = _data.fatherName;
      _districtController.text = _data.districtName;
      _giftAddressController.text = _data.giftAddress;
      _giftPincodeController.text = _data.giftAddressPincode;
      _giftDistrictController.text = _data.giftAddressDistrict;
      _giftStateController.text = _data.giftAddressState;
      _totalPotentialController.text =
          '${_data.monthlyPotentialVolumeMT}' == "null"
              ? ""
              : '${_data.monthlyPotentialVolumeMT}';
      _potentialSiteController.text = '${_data.siteAssignedCount}' == "null"
          ? ""
          : '${_data.siteAssignedCount}';
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
      _primaryCounterController.text = _data.primaryCounterName;



      _dateController.text =
          '${_data.inflDob}' == "null" ? "Birth Date" : '${_data.inflDob}';

      if (_data.ilpregFlag == "Y") {
        checkedValue = true;
        _selectedEnrollValue = "Y";
      } else {
        checkedValue = false;
        _selectedEnrollValue = "N";
      }

      influencerTypeEntitiesList =
          _influencerDetailDataModel.response.influencerTypeEntitiesList;
      if (_influencerDetailDataModel.response.influencerDetails.inflTypeId !=
          null) {
        for (int i = 0; i < influencerTypeEntitiesList.length; i++) {
          if (_influencerDetailDataModel.response.influencerDetails.inflTypeId
                  .toString() ==
              influencerTypeEntitiesList[i].inflTypeId.toString()) {
            _influencerTypeEntitiesList = influencerTypeEntitiesList[i];
          }
        }
      }
      else {}

      influencerSourceList =
          _influencerDetailDataModel.response.influencerSourceList;
      if (_influencerDetailDataModel
              .response.influencerDetails.inflEnrollmentSourceId !=
          null) {
        for (int i = 0; i < influencerSourceList.length; i++) {
          if (_influencerDetailDataModel
                  .response.influencerDetails.inflEnrollmentSourceId
                  .toString() ==
              influencerSourceList[i].inflSourceId.toString()) {
            _influencerSourceList = influencerSourceList[i];
          }
        }
      } else {}

      influencerCategoryEntitiesList =
          _influencerDetailDataModel.response.influencerCategoryEntitiesList;
      if (_influencerDetailDataModel
              .response.influencerDetails.inflCategoryId !=
          null) {
        for (int i = 0; i < influencerCategoryEntitiesList.length; i++) {
          if (_influencerDetailDataModel
                  .response.influencerDetails.inflCategoryId
                  .toString() ==
              influencerCategoryEntitiesList[i].inflCatId.toString()) {
            _influencerCategoryEntitiesList = influencerCategoryEntitiesList[i];
          }
        }
      } else {}

      siteBrandList = _influencerDetailDataModel.response.siteBrandList;
      if (_influencerDetailDataModel.response.influencerDetails.preferredBrandId !=
          null) {
        for (int i = 0; i < siteBrandList.length; i++) {
          if (_influencerDetailDataModel.response.influencerDetails.preferredBrandId
              .toString() ==
              siteBrandList[i].id.toString()) {
            _siteBrandList = siteBrandList[i];
          }
        }
      } else {}

      _designationController.text = _data.designation;
      _departmentNameController.text = _data.departmentName;
      _preferredBrandId=_influencerDetailDataModel.response.influencerDetails.preferredBrandId;
      _dateMarriageAnnController.text = _data.dateOfMarriageAnniversary;
      _firmNameController.text = _data.firmName;
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
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    double _height = 16.sp;

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
      readOnly: true,
      // validator: (value) {
      //   // if (value.isEmpty) {
      //   //   return 'Please enter email ';
      //   // }
      //   if (value.isNotEmpty && !Validations.isEmail(value)) {
      //     return 'Enter valid email ';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.emailAddress,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Email",
      ),
    );

    final name = TextFormField(
      controller: _nameController,
      readOnly: true,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Name*",
      ),
    );

    final fatherName = TextFormField(
      controller: _fatherNameController,
      readOnly: true,
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
      readOnly: true,
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
      readOnly: true,
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
      readOnly: true,
      // validator: (value) {
      //   // if (value.isEmpty) {
      //   //   return 'Please enter name';
      //   // }
      //   if (!value.isEmpty && !Validations.isValidPincode(value)) {
      //     return "Enter valid pincode";
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      //maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

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
            "Enroll for Dalmia Masters",
            style: TextStyles.formfieldLabelText,
          ),
          activeColor: Colors.black,
          dense: true,
          value: checkedValue,
          // onChanged: (newValue) {
          //   setState(() {
          //     checkedValue = newValue;
          //     if (checkedValue == true) {
          //       _selectedEnrollValue = "Y";
          //     } else {
          //       _selectedEnrollValue = "N";
          //     }
          //   });
         // },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ));

    final primaryCounter = TextFormField(
      controller: _primaryCounterController,
      style: FormFieldStyle.formFieldTextStyle,
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Primary Counter Name*",
      ),
    );

    final district = TextFormField(
      validator: (value) => value.isEmpty ? 'Please select District' : null,
      controller: _districtController,
      readOnly: true,
      // onTap: () {
      //   Get.bottomSheet(districtList());
      // },
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
      items: (_influencerDetailDataModel == null ||
              _influencerTypeEntitiesList == null)
          ? []
          : influencerTypeEntitiesList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(e.inflTypeDesc, style: TextStyle(color: Colors.black),)),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Member Type*"),
     // validator: (value) => value == null ? 'Please select member type' : null,
    );

    final qualification = TextFormField(
      controller: _qualificationController,
      readOnly: true,
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
      // onTap: () {
      //   setState(() {
      //     _selectBirthDate();
      //   });
      // },
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
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Address",
      ),
    );

    final giftPincode = TextFormField(
      controller: _giftPincodeController,
      readOnly: true,
      // validator: (value) {
      //   if (!value.isEmpty && !Validations.isValidPincode(value)) {
      //     return "Enter valid pincode";
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      //maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    final giftDistrict = TextFormField(
      controller: _giftDistrictController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District",
      ),
    );

    final giftState = TextFormField(
      controller: _giftStateController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "State",
      ),
    );

    final totalPotential = TextFormField(
      controller: _totalPotentialController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Total Monthly Potential (MT)",
      ),
    );

    final potentialSite = TextFormField(
      controller: _potentialSiteController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Potential sites",
      ),
    );

    final sourceDropDwn = DropdownButtonFormField<InfluencerSourceList>(
      value: _influencerSourceList,
      items:
          (_influencerDetailDataModel == null || influencerSourceList == null)
              ? []
              : influencerSourceList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.inflSourceText, style: TextStyle(color: Colors.black),),
                      ))
                  .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Source"),
    );

    final influencerCategoryDropDwn =
        DropdownButtonFormField<InfluencerCategoryEntitiesList>(
      value: _influencerCategoryEntitiesList,
      items: (_influencerDetailDataModel == null ||
              influencerCategoryEntitiesList == null)
          ? []
          : influencerCategoryEntitiesList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.inflCatDesc, style: TextStyle(color: Colors.black),),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Influencer Category"),
    );

    Widget engineersFields() {
      return _memberType == 7
          ? Column(
              children: [
                TextFormField(
                  controller: _designationController,
                  style: FormFieldStyle.formFieldTextStyle,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Designation",
                  ),
                ),
                SizedBox(height: _height),
                TextFormField(
                  controller: _departmentNameController,
                  style: FormFieldStyle.formFieldTextStyle,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Department Name",
                  ),
                ),
                SizedBox(height: _height),
                DropdownButtonFormField<SiteBrandList>(
                  value: _siteBrandList,
                  onChanged: (value) {
                    setState(() {
                      _siteBrandList = value;
                      _preferredBrandId = _siteBrandList.id;
                    });
                  },
                  items: siteBrandList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(e.brandName+" - "+e.productName)),
                              ))
                          .toList(),
                  style: FormFieldStyle.formFieldTextStyle,
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Preferred Brand"),
                ),
                SizedBox(height: _height),
                TextFormField(
                  controller: _dateMarriageAnnController,
                  readOnly: true,
                  onTap: () {
                    setState(() {
                      _selectMarriageAnniversaryDate();
                    });
                  },
                  style: FormFieldStyle.formFieldTextStyle,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Marriage Anniversary Date",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      child: Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: HexColor('#F9A61A'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: _height),
              ],
            )
          : Container();
    }


    final firmName = TextFormField(
      controller: _firmNameController,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Firm Name",
      ),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BackgroundContainerImage(),
          (_influencerDetailDataModel != null &&
                  _influencerDetailDataModel.response.influencerDetails != null)
              ? ListView(children: [
                  Container(
                    padding: EdgeInsets.all(12.sp),
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
                  ),

                  SizedBox(height: 8.sp),
                  Divider(
                    height: 1.sp,
                    color: Colors.grey,
                  ),
                  Padding(
                      padding: EdgeInsets.all(16.sp),
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
                                    "$memberShipId",
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
                              memberDropDwn,
                              SizedBox(height: _height),
                              //enrollDropDwn,
                              enrollmentCheckbox,
                              SizedBox(height: _height),
                              primaryCounter,
                              SizedBox(height: _height),
                              district,
                              SizedBox(height: _height),
                              baseCity,
                              SizedBox(height: _height),
                              taluka,
                              SizedBox(height: _height),
                              pincode,
                              SizedBox(height: _height),
                              engineersFields(),
                              SizedBox(height: _height),
                              birthDate,
                              SizedBox(height: _height),
                              firmName,
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
                                height: 1.sp,
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
                            ]),
                      )),
                ])
              : Center(
                  child: Text(""),
                ),
        ],
      ),
    );
  }

  Future _selectMarriageAnniversaryDate() async {
    DateTime _picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());
    setState(() {
      var _date;
      _date = new DateFormat('yyyy-MM-dd').format(_picked);
      _dateMarriageAnnController.text = _date;
    });
  }

}
