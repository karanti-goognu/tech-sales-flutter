import 'package:flutter/cupertino.dart';

class TsoLogger {
  TsoLogger._();

  /// This method is used to print the message passed to it in the logcat.
  static void printLog(String msg) {
    debugPrint(msg);
  }

}
