import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentLocation{
  GetCurrentLocation._();

  static Position? _currentPosition;
  static LatLng? latLng;
  static GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  static Future<bool> checkLocationPermission() async{
    bool _ = await _geolocatorPlatform.isLocationServiceEnabled();
    return _;
  }

  static Future<LocationDetails> getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;
      List<String> loc;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print(".");
        Get.rawSnackbar(message:'Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      print("..");
      if (permission == LocationPermission.denied) {
        print("...");
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("....");
          Get.rawSnackbar(message:'Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        print(".....");
        Future.error("location denied forever");
        Get.rawSnackbar(message:'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentPosition = position;
      loc = await getAddressFromLatLng();
      latLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
     return LocationDetails(loc,_currentPosition, latLng);
  }


  static getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = p[0];
      return ["${place.country}","${place.administrativeArea}","${place.subAdministrativeArea}", "${place.locality}", "${place.subLocality}", "${place.postalCode}", "${place.thoroughfare}", "${place.name}"];
    } catch (e) {
      print(e);
    }
  }
}

class LocationDetails{
  List<String> loc;
  Position? position;
  LatLng? latLng;

  LocationDetails(this.loc,this.position,this.latLng);
}