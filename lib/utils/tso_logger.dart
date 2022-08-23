import 'dart:developer';

import 'package:flutter/cupertino.dart';

class TsoLogger {
  TsoLogger._();

  /// This method is used to print the message passed to it in the logcat.
  static void printLog(Object msg) {
    debugPrint(msg.toString());
  }

  /// This method is used to log the message passed to it in the logcat.
  static void logD(Object msg) {
    log(msg.toString());
  }
}
