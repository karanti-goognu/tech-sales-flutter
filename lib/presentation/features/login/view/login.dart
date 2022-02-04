import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/firebase_events.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/outline_input_borders.dart';
import 'package:get/get.dart';

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
  LoginController _loginController = Get.find();
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, //
      backgroundColor: ColorConstants.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: _buildLoginInterface(context),
          ),
          Positioned(
            right: 15,
            top: 30,
            child: 
            UrlConstants.baseUrl.contains('mobileqacloud')?
            Chip(
              backgroundColor: ColorConstants.appBarColor,
              label: Text('QA', style: TextStyle(color: Colors.white),),
            ):
            UrlConstants.baseUrl.contains('mobiledevcloud')?
            Chip(
              backgroundColor: ColorConstants.appBarColor,
              label: Text('Dev', style: TextStyle(color: Colors.white),),
            ):Container(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildLoginInterface(BuildContext context) {
    var mobileNumber = "8860080067";
    var empId = "EMP12345533";

    SizeConfig().init(context);

    //var connectionStatus = Provider.of<ConnectivityStatus>(context);

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
              "Employee ID is 10 digit long and starts with EMP",
              style: TextStyle(
                  fontFamily: "Muli",
                  fontSize: 14,
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
                      labelText: "Registered Mobile Number",
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
                    color: ColorConstants.buttonNormalColor,
                    highlightColor: ColorConstants.buttonPressedColor,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        //_sendAnalyticsEvent();
                        // FirebaseAnalytics().logEvent(
                        //     name: FirebaseEventsConstants.loginButtonClick,
                        //     parameters: null);
                        afterRequestLayout(empId, mobileNumber);
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

  // Future<void> _sendAnalyticsEvent() async {
  //   await analytics.logEvent(
  //       name: FirebaseEventsConstants.loginButtonClick,
  //       parameters : null
  //   );
  // }


  void afterRequestLayout(String empId, String mobileNumber) {
    print('Emp Id is :: $empId Mobile Number is :: $mobileNumber');

    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.none:
    //     connectivityString = "Offline";
    //     break;
    //   case ConnectivityResult.mobile:
    //     connectivityString = "Mobile: Online";
    //     break;
    //   case ConnectivityResult.wifi:
    //     connectivityString = "WiFi: Online";
    // }

    internetChecking().then((result) => {
      if (result == true)
        {
          _loginController.empId = empId,
          _loginController.phoneNumber = mobileNumber,
          _loginController.getAccessKey(RequestIds.LOGIN_REQUEST),
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
}
