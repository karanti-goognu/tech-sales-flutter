import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:http/http.dart';

class LoginApi {
  /* Future<Either<Exception, String>> checkEmpIDAndContact() async {
    try {
      final queryParameters = {
        "reference-id":"IqEAFdXco54HTrBkH+sWOw==",
        "app-name":"TECH-SALES",
        "app-version":"1.0",
        "device-id":" 18e86276-d1e2-4e36-bcc2-26036be5065e",
        "mobile-number":" IqEAFcofgrRT5TrBkH+sSDw==",
        "device-type":"SAMSUNG"
      };
      final uri =
          Uri.https(UrlConstants.baseUrl, UrlConstants.loginCheck, queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }*/

  Future<Either<Exception, String>> checkEmpIDAndContact() async {
    try {
      var body = {
        //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
        "reference-id": encryptAESCryptoJS("IqEAFdXco54HTrBkH+sWOw==", StringConstants.encryptionKey).toString(),
        "mobile-number": encryptAESCryptoJS("8860080067", StringConstants.encryptionKey).toString(),
        "app-name": "TECH-SALES",
        "app-version": "1.0",
        "device-id": " 18e86276-d1e2-4e36-bcc2-26036be5065e",
        "device-type": "SAMSUNG"
      };

      //debugPrint('in get posts: $body');
      debugPrint('in get posts: ${json.encode(body)}');
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final responseBody = await post(Uri.parse(UrlConstants.loginCheck),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));

      // final jsonResponse = json.decode(responseBody.body);
      //final response = await http.get(uri);
      return Right(responseBody.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
