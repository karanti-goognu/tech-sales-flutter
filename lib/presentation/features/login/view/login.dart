import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/core/security/read_device_info.dart';
import 'package:flutter_tech_sales/core/services/connectivity_service.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login_otp_screen.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/enums/connectivity_status.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/outline_input_borders.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenPageState();
  }
}

class LoginScreenPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
        child: Scaffold(
          resizeToAvoidBottomInset: false, //
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: _buildLoginInterface(context),
          ),
        ));
  }

  Widget _buildLoginInterface(BuildContext context) {
    var mobileNumber = "8860080067";
    var empId = "EMP12345533";

    SizeConfig().init(context);

    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.safeBlockVertical * 40,
              width: SizeConfig.safeBlockVertical * 100,
              child: Center(
                  child: Text(
                "TSO",
                style: TextStyle(
                    fontSize: 47,
                    fontFamily: "Raleway",
                    letterSpacing: 0,
                    fontWeight: FontWeight.w800),
              )),
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/assets/alucard.jpg'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),*/
            ),
            Text(
              "Welcome, please login ",
              style: TextStyle(
                  color: const Color(0xFF000000).withOpacity(1),
                  fontFamily: "Muli-Bold.ttf",
                  fontSize: 24,
                  letterSpacing: .30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Continue to TSO App",
              style: TextStyle(
                  fontFamily: "Muli",
                  fontSize: 20,
                  letterSpacing: .5,
                  color: const Color(0xFF000000).withOpacity(0.6)),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Employee ID can't be empty";
                      }
                      empId = value;
                      return null;
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.inputBoxBorderSideColor,
                            width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.inputBoxBorderSideColor,
                            width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.inputBoxBorderSideColor,
                            width: 1.0),
                      ),
                      labelText: "Employee ID",
                      filled: true,
                      focusColor: Colors.black,
                      labelStyle: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0),
                      fillColor: ColorConstants.backgroundColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter mobile number ';
                      }
                      if (value.length <= 9) {
                        return 'Mobile number is incorrect';
                      }

                      mobileNumber = value;
                      return null;
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      focusedBorder:
                          InputBordersDecorations.outLineInputBorderFocused,
                      errorBorder:
                          InputBordersDecorations.outLineInputBorderError,
                      enabledBorder:
                          InputBordersDecorations.outLineInputBorderEnabled,
                      labelText: "Register Mobile Number",
                      filled: true,
                      focusColor: Colors.black,
                      labelStyle: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0),
                      fillColor: ColorConstants.backgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    color: (connectionStatus == ConnectivityStatus.Offline)
                        ? ColorConstants.buttonDisableColor
                        : ColorConstants.buttonNormalColor,
                    highlightColor: ColorConstants.buttonPressedColor,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        (connectionStatus == ConnectivityStatus.Offline)
                            ? CustomDialogs()
                                .showNoInternetConnectionDialog(context)
                            : afterRequestLayout(empId, mobileNumber);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Text(
                        'CONTINUE',
                        style: ButtonStyles.buttonStyleBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void afterRequestLayout(String empId, String mobileNumber) {
    print('Emp Id is :: $empId Mobile Number is :: $mobileNumber');
    GetX<LoginController>(
        init: Get.find<LoginController>().getAccessKey(empId, mobileNumber),
        builder: (_) {
          return LoginOtpScreen(
            mobileNumber: mobileNumber,
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
