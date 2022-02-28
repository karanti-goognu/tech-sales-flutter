import 'dart:io';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:http/http.dart';

class NetworkCalls {
  Future<String> get(String url) async {
    var response = await client.get(Uri.parse(url));
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}
