import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_tech_sales/utils/constants/string_constants.dart';

class Geometry {
  Location? location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Suggestion {
  final String? placeId;
  final String? description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'YOUR_API_KEY_HERE';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = StringConstants.API_Key;

  Future<List<Suggestion>?> fetchSuggestions(String input, String lang) async {
    input = input.replaceAll(" ", "+");
    final request =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?" +
            "key=$apiKey&" +
            "input={$input}&components=country:IN&sessiontoken=$sessionToken&" +
            "language=$lang";

    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      if (result['status'] == 'OK') {

        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Location?> getLatLong(String? placeId) async {
    final latLongRequest =
        'https://maps.googleapis.com/maps/api/place/details/json?input=bar&placeid=$placeId&key=$apiKey';

    final response = await client.get(Uri.parse(latLongRequest));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final data = result['result'];

        Geometry resp = Geometry.fromJson(data['geometry']);
        return resp.location;
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

}
