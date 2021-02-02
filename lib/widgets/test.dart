// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:google_map_location_picker/generated/l10n.dart'
// as location_picker;
// import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
//
//
// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   LocationResult _pickedLocation;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
// //      theme: ThemeData.dark(),
//       title: 'location picker',
//       localizationsDelegates: const [
//         location_picker.S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const <Locale>[
//         Locale('en', ''),
//         Locale('ar', ''),
//         Locale('pt', ''),
//         Locale('tr', ''),
//         Locale('es', ''),
//         Locale('it', ''),
//         Locale('ru', ''),
//       ],
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('location picker'),
//         ),
//         body: Builder(builder: (context) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 RaisedButton(
//                   onPressed: () async {
//                     LocationResult result = await showLocationPicker(
//                       context, StringConstants.API_Key,
//                       initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                       myLocationButtonEnabled: true,
//                       // requiredGPS: true,
//                       layersButtonEnabled: true,
//                       // countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
// //                       desiredAccuracy: LocationAccuracy.best,
//                     );
//                     print("result = $result");
//                     setState(() => _pickedLocation = result);
//                   },
//                   child: Text('Pick location'),
//                 ),
//                 Text(_pickedLocation.toString()),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message({this.msg, this.direction, this.dateTime});

  final String msg;
  final String direction;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: direction == 'left'
          ? new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      //for left corner

                      new Image.asset(
                        'assets/images/img1.png',
                        fit: BoxFit.scaleDown,
                        width: 30.0,
                        height: 30.0,
                      ),

                      new Container(
                        margin: EdgeInsets.only(left: 6.0),
                        decoration: new BoxDecoration(
                          color: Color(0xffd6d6d6),
                          border: new Border.all(
                              color: Color(0xffd6d6d6),
                              width: .25,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          msg,
                          style: new TextStyle(
                            fontFamily: 'Gamja Flower',
                            fontSize: 20.0,
                            color: Color(0xff000000),
                          ),
                        ),
                        width: 180.0,
                      ),
                    ],
                  ),

                  //date time
                  new Container(
                    margin: EdgeInsets.only(left: 6.0),
                    decoration: new BoxDecoration(
                      color: Color(0xffd6d6d6),
                      border: new Border.all(
                          color: Color(0xffd6d6d6),
                          width: .25,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        topLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: new Text(
                      dateTime,
                      style: new TextStyle(
                        fontSize: 8.0,
                        color: Color(0xff000000),
                      ),
                    ),
                    width: 180.0,
                  ),
                ],
              ),
            ],
          ))
          : new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  //for right corner
                  new Image.asset(
                    'assets/images/img1.png',
                    fit: BoxFit.scaleDown,
                    width: 30.0,
                    height: 30.0,
                  ),

                  new Container(
                    margin: EdgeInsets.only(right: 6.0),
                    decoration: new BoxDecoration(
                      color: Color(0xffef5350),
                      border: new Border.all(
                          color: Color(0xffef5350),
                          width: .25,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      msg,
                      style: new TextStyle(
                        fontFamily: 'Gamja Flower',
                        fontSize: 20.0,
                        color: Color(0xffffffff),
                      ),
                    ),
                    width: 180.0,
                  ),
                ],
              ),

              //date time
              new Container(
                margin: EdgeInsets.only(right: 6.0),
                decoration: new BoxDecoration(
                  color: Color(0xffef5350),
                  border: new Border.all(
                      color: Color(0xffef5350),
                      width: .25,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: new Text(
                  dateTime,
                  style: new TextStyle(
                    fontSize: 8.0,
                    color: Color(0xffffffff),
                  ),
                ),
                width: 180.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}