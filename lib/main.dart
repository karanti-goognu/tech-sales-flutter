import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/enums/connectivity_status.dart';
import 'core/services/connectivity_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TSO App',
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.white70,

            // Define the default font family.
            fontFamily: 'muli',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Raleway'),
              bodyText1: TextStyle(fontSize: 21, fontFamily: 'Raleway'),
              subtitle1: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal),
            ),
          ),
          home: new HomeScreen(),
        ));
  }
}
