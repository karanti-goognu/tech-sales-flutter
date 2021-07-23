import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:intl/intl.dart';

class FormAddInfluencer extends StatefulWidget {
  @override
  _FormAddInfluencerState createState() => _FormAddInfluencerState();
}

class _FormAddInfluencerState extends State<FormAddInfluencer> {
  final _addInfluencerFormKey = GlobalKey<FormState>();
  final _addInfluencerFormKeyNext = GlobalKey<FormState>();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _giftAddressController = TextEditingController();
  TextEditingController _giftPincodeController = TextEditingController();
  TextEditingController _giftDistrictController = TextEditingController();
  TextEditingController _giftStateController = TextEditingController();
  TextEditingController _totalPotentialController = TextEditingController();
  TextEditingController _potentialSiteController = TextEditingController();
  TextEditingController _enrollmentDateController = TextEditingController();

  var _date = 'Date of Birth';
  //var _enrollmentDate = 'Enrollment Date';
  bool _isVisible = true;
  bool _isSecondVisible = false;
  bool checkedValue = false;
  bool _qualificationVisible = false;

  String _selectedEnrollValue;
  String _memberType;
  String _qualification;
  String _influencerCategory;
  String _source;

  @override
  void initState() {
    super.initState();
    _enrollmentDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
        }
        if (value.length <= 9) {
          return 'Mobile number is incorrect';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 10,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Mobile number*",
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Father Name*",
      ),
    );

    final enrollDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _selectedEnrollValue = value;
        });
      },
      items: ['Yes', 'No']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Enroll for Dalmia Masters *"),
      validator: (value) =>
          value == null ? 'Please select Dalmia Master' : null,
    );

    final memberDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _memberType = value;
          if(_memberType == 'Contractor' || _memberType == 'Engineer'|| _memberType == 'Architect'|| _memberType == 'Structural Consultant'){
            _qualificationVisible = true;
          }else{
            _qualificationVisible = false;
          }
        });
      },
      items: ['Mason', 'Head Mason', 'Contractor', 'Engineer', 'Architect', 'Structural Consultant']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Member Type*"),
      validator: (value) => value == null ? 'Please select member type' : null,
    );

    final qualificationDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _qualification = value;
        });
      },
      items: ['Qualification 1', 'Qualification 2']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Qualification"),
      // validator: (value) =>
      //     value == null ? 'Please select qualification' : null,
    );

    final birthDate = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: RaisedButton(
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(_date)),
                Icon(
                  Icons.calendar_today,
                  color: ColorConstants.clearAllTextColor,
                ),
              ],
            ),
            onPressed: () {
              _selectBirthDate();
            },
          ),
        ));

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
              if(_addInfluencerFormKey.currentState.validate()) {
                _isVisible = false;
                _isSecondVisible = true;
              }
            });

            // btnPresssed();
          },
        ),
      ],
    );

    final address = TextFormField(
      controller: _addressController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Address",
      ),
    );

    final pincode = TextFormField(
      controller: _pincodeController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    final district = TextFormField(
      controller: _districtController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter name';
      //   }
      //   return null;
      // },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District",
      ),
    );

    final state = TextFormField(
      controller: _stateController,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "State",
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
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.number,
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

    final addressCheckbox = CheckboxListTile(
      title: Text("Same as permanent"),
      activeColor: Colors.black,
      dense: true,
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          if (newValue) {
            _giftAddressController.text = _addressController.text;
            _giftPincodeController.text = _pincodeController.text;
            _giftDistrictController.text = _districtController.text;
            _giftStateController.text = _stateController.text;
          } else {
            _giftAddressController.text = "";
            _giftPincodeController.text = "";
            _giftDistrictController.text = "";
            _giftStateController.text = "";
          }
        });
        checkedValue = newValue;
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
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
      keyboardType: TextInputType.text,
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

    final sourceDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _source = value;
        });
      },
      items: ['Dealer', 'ILP', 'TSO', 'CC']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Source"),
      validator: (value) => value == null ? 'Please select Source' : null,
    );

    final influencerCategoryDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _influencerCategory = value;
        });
      },
      items: ['Dalmia', 'Non-Dalmia']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Influencer Category"),
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
              _isVisible = false;
              _isSecondVisible = true;
            });

            // btnPresssed();
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
                            enrollDropDwn,
                            SizedBox(height: _height),
                            memberDropDwn,
                            SizedBox(height: _height),
                            birthDate,
                            SizedBox(height: _height),
                            fatherName,
                            SizedBox(height: _height),
                            Visibility(
                              visible: _qualificationVisible,
                                child: qualificationDropDwn),
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
                              "Permanent Address",
                              style: TextStyles.welcomeMsgTextStyle20,
                            ),
                            SizedBox(height: _height),
                            address,
                            SizedBox(height: _height),
                            pincode,
                            SizedBox(height: _height),
                            district,
                            SizedBox(height: _height),
                            state,
                            SizedBox(height: _height),
                            Text(
                              "Address for gift disbursement",
                              style: TextStyles.welcomeMsgTextStyle20,
                            ),
                            addressCheckbox,
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
      _date = new DateFormat('dd-MM-yyyy').format(_picked);
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
}
