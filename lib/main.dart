import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:google_map_location_picker/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';
//import 'package:google_map_location_picker_example/keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'generated/i18n.dart';
import 'core/enums/connectivity_status.dart';
import 'core/services/connectivity_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: const [
        location_picker.S.delegate,
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
        Locale('pt', ''),
        Locale('tr', ''),
        Locale('es', ''),
        Locale('it', ''),
        Locale('ru', ''),
      ],
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
    );
  }
}
