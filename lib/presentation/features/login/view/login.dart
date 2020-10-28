import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/size/size_config.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenPageState();
  }
}

class LoginScreenPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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

  Widget _buildLoginInterface(BuildContext context) {
    SizeConfig().init(context);

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
              "Welcome, please login",
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
                      //leagueSize = int.parse(value);
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
                      return null;
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.4),
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
                    color: ColorConstants.buttonNormalColor,
                    highlightColor: ColorConstants.buttonPressedColor,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        CustomDialogs().showEmpIdAndNoNotMatchDialog(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Text(
                        'CONTINUE',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1.25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
