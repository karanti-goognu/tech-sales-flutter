import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/address_search.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/suggestion.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';



class CustomMap extends StatefulWidget {
  final List? latLong;
  CustomMap({this.latLong});
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late GoogleMapController controller;
  LatLng? _markerPosition;
  TextEditingController _locationController = TextEditingController();

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _markerPosition!.latitude, _markerPosition!.longitude);
      Placemark place = p[0];
      _locationController.text = place.name! + "${place.thoroughfare}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.locality}, ${place.postalCode}";
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }


  _getCurrentLocation() async {
    if (!await GetCurrentLocation.checkLocationPermission()) {
      Get.back();
      Get.dialog(CustomDialogs.showMessage(
          "Please enable your location service from device settings"));
    } else {
      Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _markerPosition = LatLng(position.latitude, position.longitude);
          _getAddressFromLatLng();
        });

      }
      ).catchError((e) {
        Get.back();
        Get.dialog(
            CustomDialogs.showMessage("Access to location data denied "));
        print(e);
       });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _markerPosition==null?
        Positioned.fill(
          child: Material(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),),
        )
            :
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _markerPosition!, zoom: 14),
          circles: {
            Circle(
                circleId: CircleId('1'),
                center: _markerPosition!,
                radius: 250,
                fillColor: Colors.blue.withOpacity(0.4),
                strokeColor: Colors.blueAccent,
                strokeWidth: 1)
          },
          markers: {
            Marker(
              draggable: true,
              markerId: MarkerId('1'),
              position: _markerPosition!,
              infoWindow: InfoWindow(
                title: _locationController.text,
              ),
            )
          },
          onMapCreated: (controller) {
            this.controller = controller;
          },
          onTap: (_) {
            setState(() {
              _markerPosition = _;
            });
            _getAddressFromLatLng();
          },
        ),
        Positioned(
            top: 20,
            left: 20,
            child: TextButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context,
                    [_markerPosition!.latitude, _markerPosition!.longitude]);
                },
            )),
        Positioned(
            left: 90,
            right: 90,
            bottom: 60,
            child: MaterialButton(
              onPressed: () => Get.bottomSheet(locationBottomSheet(context)),
              child: Text(
                "View Address".toUpperCase(),
                style: TextStyles.btnWhite,
              ),
              color: Colors.blue,
            ))
      ],
    );
  }

  Container locationBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      height: 300,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Location",
              style: TextStyles.welcomeMsgTextStyle20,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          TextFormField(
            controller: _locationController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Your Location".toUpperCase(),
              labelStyle: TextStyles.mulliBold14,
              prefixIcon: Icon(
                Icons.check_circle_outline,
                color: Colors.blue,
              ),
              suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: GestureDetector(
                  onTap: () async {
                    final sessionToken = Uuid().v4();
                    final Suggestion? result = await showSearch(
                      context: context,
                      delegate: AddressSearch(sessionToken),
                    );

                    if (result != null) {
                      final placeDetails = await PlaceApiProvider(sessionToken).getLatLong(result.placeId) ;
                      _locationController.text = result.description!;
                      double? lat = placeDetails?.lat;
                      double? long = placeDetails?.lng;
                      setState(() {
                        _markerPosition = LatLng(lat!, long!);
                      });
                      controller.animateCamera(
                          CameraUpdate.newLatLng(_markerPosition!));
                    }
                  },
                  child: Text('Change', style: TextStyles.mulliBoldYellow18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.maxFinite,
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Get.back();
                  Navigator.pop(context,
                      [_markerPosition!.latitude, _markerPosition!.longitude]);
                },
                child: Text(
                  "Confirm Location and Proceed".toUpperCase(),
                  style: TextStyles.btnWhite,
                ),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
