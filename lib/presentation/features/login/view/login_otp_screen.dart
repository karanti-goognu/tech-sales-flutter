import 'dart:async';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';

class LoginOtpScreen extends StatefulWidget {
  final String mobileNumber;

  @override
  State<StatefulWidget> createState() {
    return LoginOtpScreenPageState(this.mobileNumber);
  }
  LoginOtpScreen({Key key, this.mobileNumber}) : super(key: key);
}

class LoginOtpScreenPageState extends State<LoginOtpScreen> {
  String mobileNumber;
  String otpCode = "";
  String isUserLoggedIn = "false";
  FocusNode _focusNode;
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  LoginController _loginController = Get.find();


  Timer _timer;
  int _start = 360;
  int _startInitial = 360;
  bool retryOtp = false;
  bool _isButtonDisabled;

  void startTimer() {
    if (_loginController != null) {
      LoginModel loginModel = _loginController.loginResponse;
      try {
        _startInitial = int.parse(loginModel.otpRetrySmsTime);
        _start = _startInitial ~/ 1000;
      } catch (_) {
        print('We wre in catch ${_.toString()}');
      }

      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(
              () {
            if (_start < 1) {
              timer.cancel();
              _loginController.retryOtpActive = true;
              _start = _startInitial;
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    } else {
      print('Controller is null');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    _focusNode = FocusNode();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: _buildLoginInterface(context),
          ),
        ));
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  Widget _buildLoginInterface(BuildContext context) {
    SizeConfig().init(context);
    var secToMin = Duration(seconds: _start).inMinutes;
    var sec = _start % 60;
    var timeFormat = secToMin.toString() + ":" + sec.toString();


    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              height: SizeConfig.safeBlockVertical * 40,
              width: SizeConfig.safeBlockVertical * 100,
              child: Center(
                child: Image.asset(
                  "assets/images/Logo(Whitebg).png",
                ),
              ),
            ),
            Text(
              "Welcome, please login ",
              style: TextStyles.welcomeMsgTextStyle20,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Enter the 6-digit OTP sent to you at",
              style: TextStyles.enterMsgTextStyle16,
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Text("+91 ${_loginController.phoneNumber}.",
                style: TextStyles.phoneNumberTextStyle16)),
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
                      if (value.length < 6) {
                        return 'Otp code is incorrect';
                      }
                      otpCode = value;
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
                            child: Obx(() => GestureDetector(
                              onTap: () {
                                (_loginController.retryOtpActive == false)
                                    ? print('On click')
                                    : retryOtpRequest();
                              },
                              child: new Text(
                                (_loginController.retryOtpActive == false)
                                    ? "Resend OTP in $timeFormat"
                                    : "Resend OTP",
                                style: (_loginController.retryOtpActive ==
                                    false)
                                    ? TextStyles.resendOtpTextStyleNormal
                                    : TextStyles.resendOtpTextStyleEnabled,
                              ),
                            ))),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                              elevation: 4,
                              primary: ColorConstants.buttonNormalColor,),
                              onPressed: () {
                                if(!_isButtonDisabled) {
                                  if (_formKey.currentState.validate()) {
                                    afterValidateRequest(otpCode);
                                    _loginController.attempts++;
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Text(
                                  _isButtonDisabled?'HOLD ON':
                                  'VERIFY',
                                  style: ButtonStyles.buttonStyleBlue,
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
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            child: new Text(
                          "Didn't received the sms?",
                          style: TextStyles.resendOtpTextStyleNormal,
                        )),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: new Text(
                              "Request OTP via call",
                              style: TextStyles.resendOtpTextStyleEnabled,
                            )),
                        flex: 2,
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text(
            'Your login progress will be Lost.Do you still want to continue ?'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: () => Get.toNamed(Routes.LOGIN),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  void retryOtpRequest() {
    internetChecking().then((result) => {
      if (result == true)
        {
          _isButtonDisabled = false,
          _loginController.getAccessKey(RequestIds.RETRY_OTP_REQUEST),
          startTimer()
        }
      else
        {
          Get.snackbar(
              "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM),
        }
    });
  }

  void afterValidateRequest(String otpCode) {
    _loginController.otpCode = otpCode;
    internetChecking().then((result) => {
      if (result == true)
        {
        _loginController.getAccessKey(RequestIds.VALIDATE_OTP_REQUEST),
          if(_loginController.validateOtpResponse.respCode == "DM1011")  {
            _isButtonDisabled = true
          }else{
            _isButtonDisabled = false
          }
        }
      else
        {
          Get.snackbar(
              "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM),
        }
    });

  }

  LoginOtpScreenPageState(this.mobileNumber);
}
