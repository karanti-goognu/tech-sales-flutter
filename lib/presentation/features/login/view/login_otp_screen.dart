import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/core/security/read_device_info.dart';
import 'package:flutter_tech_sales/core/services/connectivity_service.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/enums/connectivity_status.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginOtpScreen extends StatefulWidget {
  final String mobileNumber;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginOtpScreenPageState(this.mobileNumber);
  }

  // In the constructor, require a Todo.
  LoginOtpScreen({Key key, this.mobileNumber}) : super(key: key);
}

class LoginOtpScreenPageState extends State<LoginOtpScreen> {
  String mobileNumber;
  FocusNode _focusNode;
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Timer _timer;
  int _start = 180;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    startTimer();
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
    return Scaffold(
      resizeToAvoidBottomInset: false, //
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: _buildLoginInterface(context),
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  Widget _buildLoginInterface(BuildContext context) {
    LoginController _loginController = Get.find();
    SizeConfig().init(context);
    var secToMin = Duration(seconds: _start).inMinutes; // 2 mins
    var sec = _start % 60;
    var timeFormat = secToMin.toString() + ":" + sec.toString();

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
                  color: ColorConstants.darkTextColor,
                  fontFamily: "Muli-Bold.ttf",
                  fontSize: 20,
                  letterSpacing: .30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Enter the 6 - digit OTP sent to you at",
              style: TextStyle(
                  fontFamily: "Muli",
                  fontSize: 16,
                  letterSpacing: .5,
                  color: const Color(0xFF000000).withOpacity(0.6)),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Text(
              "+91 ${_loginController.phoneNumber}.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Muli",
                  fontSize: 16,
                  letterSpacing: .5,
                  color: const Color(0xFF000000).withOpacity(0.6)),
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
                  TextFormField(
                    onTap: _requestFocus,
                    focusNode: _focusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter the code';
                      }
                      if (value.length <= 6) {
                        return 'Otp code is incorrect';
                      }
                      return null;
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.phone,
                    maxLength: 6,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.focusedInputTextColor,
                            width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.4),
                            width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.4),
                            width: 1.0),
                      ),
                      labelText: "Enter the code",
                      filled: true,
                      focusColor: Colors.black,
                      labelStyle: TextStyle(
                          fontFamily: "Muli",
                          color: (_focusNode.hasFocus)
                              ? ColorConstants.focusedInputTextColor
                              : ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          fontSize: 16.0),
                      fillColor: ColorConstants.backgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            child: new Text(
                          "Resend OTP in $timeFormat",
                          style: TextStyle(
                              fontFamily: "Muli",
                              fontSize: 14,
                              letterSpacing: .25,
                              color: ColorConstants.darkTextColor),
                        )),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                            child: RaisedButton(
                              elevation: 4,
                              color: (connectionStatus ==
                                      ConnectivityStatus.Offline)
                                  ? ColorConstants.buttonDisableColor
                                  : ColorConstants.buttonNormalColor,
                              highlightColor: ColorConstants.buttonPressedColor,
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                (connectionStatus == ConnectivityStatus.Offline)
                                    ? CustomDialogs()
                                .errorDialog(StringConstants.noInternetConnectionError)
                                    : afterRequestLayout(mobileNumber);
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Text(
                                  'VERIFY',
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.white,
                                      letterSpacing: 1.25),
                                ),
                              ),
                            ),
                            alignment: Alignment.centerRight),
                        flex: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            child: new Text(
                          "Didn't received the sms?",
                          style: TextStyle(
                              fontFamily: "Muli",
                              fontSize: 14,
                              letterSpacing: .25,
                              color: ColorConstants.darkTextColor),
                        )),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: new Text(
                              "Request OTP via call",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Muli",
                                  fontSize: 14,
                                  letterSpacing: .25,
                                  color: ColorConstants.buttonNormalColor),
                            )),
                        flex: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void afterRequestLayout(String mobileNumber) {
    if (_formKey.currentState.validate()) {
    }
  }

  LoginOtpScreenPageState(this.mobileNumber);
}
