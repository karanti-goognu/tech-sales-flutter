import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:moengage_inbox/constants.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/inbox_message.dart';
import 'package:moengage_inbox/moe_android_inbox.dart';
import 'package:moengage_inbox/moe_ios_inbox.dart';

class MoEngageInbox {
  MethodChannel _channel;
  MoEAndroidInbox _androidInbox;
  MoEiOSInbox _iOSInbox;

  MoEngageInbox() {
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

  Future<InboxData> fetchAllMessages() async {
    if (Platform.isAndroid) {
      return _androidInbox.fetchAllMessages();
    } else if (Platform.isIOS) {
      return _iOSInbox.fetchAllMessages();
    }
  }

  Future<List<InboxMessage>> fetchAllInboxMessages() async {
    List<InboxMessage> inboxList = new List();
    this.fetchAllMessages().then((value) => {
      if(value.messages.length>0){
        inboxList.addAll(value.messages)
      }else{
        inboxList=[]
      }
    });

    return inboxList;

  }


  Future<int> getUnClickedCount() async {
    int count = 0;
    if (Platform.isAndroid) {
      count = await _androidInbox.getUnClickedCount();
    } else if (Platform.isIOS) {
      count = await _iOSInbox.getUnClickedCount();
    }
    return count;
  }

  int getUnClickedCo() {
    int count = 0;
    this.getUnClickedCount().then((value) => {
      count = value
    });
    return count;
  }

}
