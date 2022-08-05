import 'dart:io';
import 'package:flutter/services.dart';
import 'package:moengage_inbox/inbox_message.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/constants.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moe_android_inbox.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moe_ios_inbox.dart';

class MoEngageInboxX {
  MethodChannel? _channel;
  late MoEAndroidInbox _androidInbox;
  late MoEiOSInbox _iOSInbox;

  moEngageInbox() {
    _channel = MethodChannel(CHANNEL_NAME);
    _androidInbox = MoEAndroidInbox(_channel);
    _iOSInbox = MoEiOSInbox(_channel);
  }

  void trackMessageClicked(InboxMessage message) {
    if (Platform.isAndroid) {
      _androidInbox.trackMessageClicked(message);
    } else if (Platform.isIOS) {
      _iOSInbox.trackMessageClicked(message);
    }
  }

  void deleteMessage(InboxMessage message) {
    if (Platform.isAndroid) {
      _androidInbox.deleteMessage(message);
    } else if (Platform.isIOS) {
      _iOSInbox.deleteMessage(message);
    }
  }


}
