import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetCurrentLocation{
  GetCurrentLocation._();
  static Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  static Position _currentPosition = new Position();


  static Future<List> getCurrentLocation() async {
    //String loc;
    List<String> loc;
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      Position position= await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
     _currentPosition = position;
     loc= await getAddressFromLatLng();
     print("loc"+"$loc");
     Get.back();
    }
    return [loc,_currentPosition];

  }


  static getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      return ["${place.country}","${place.administrativeArea}","${place.subAdministrativeArea}", "${place.locality}", "${place.subLocality}", "${place.postalCode}", "${place.thoroughfare}", "${place.name}"];
    } catch (e) {
      print(e);
    }
  }
}

//"${place.subAdministrativeArea}", "${place.locality}", "${place.postalCode}"


