import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetCurrentLocation{
  GetCurrentLocation._();
  static Position _currentPosition = new Position();
  static GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  static Future<bool> checkLocationPermission() async{
    bool _ = await _geolocatorPlatform.isLocationServiceEnabled();
    return _;
  }

  static Future<List> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    List<String> loc;
      if (!await checkLocationPermission()) {
        Get.dialog(CustomDialogs().errorDialog(
            "Please enable your location service from device settings"));
      } else {
       // try {
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          _currentPosition = position;
          loc = await getAddressFromLatLng();
          Get.back();
          }else{
            Get.rawSnackbar(title: "Message", message:" e.toString()");
          }
        // } catch (e) {
        //   Get.back();
        //   Get.rawSnackbar(title: "Message", message: e.toString());
        // }

    }
    return [loc,_currentPosition];

  }


  static getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      return ["${place.country}","${place.administrativeArea}","${place.subAdministrativeArea}", "${place.locality}", "${place.subLocality}", "${place.postalCode}", "${place.thoroughfare}", "${place.name}"];
    } catch (e) {
      print(e);
    }
  }
}



