import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/constants.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moe_android_inbox.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moe_ios_inbox.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/inbox_message.dart';

class MoEngageInboxX {
  MethodChannel? _channel;
  late MoEAndroidInbox _androidInbox;
  late MoEiOSInbox _iOSInbox;

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
    print("fetchAllMessages called");
    if (Platform.isAndroid) {
      return _androidInbox.fetchAllMessages();
    }
    ///This condition has been commented to avoid null safety issue.
    // else if (Platform.isIOS) {
      return _iOSInbox.fetchAllMessages();
    // }

  }

  Future<List<InboxMessage>> fetchAllInboxMessages() async {
    print("moengage_inbox : fetchAllInboxMessages");
    List<InboxMessage> inboxList = new List.empty(growable: true);
    print("inboxList $inboxList");
    this.fetchAllMessages().then((value) => {
     print("Count:${value.messages.length}"),
      if(value.messages.length>0){
        inboxList.addAll(value.messages)
      }else{
        inboxList=[]
      }
    });

    return inboxList;
  }


  // Future<int> getUnClickedCount() async {
  //   int count = 0;
  //   if (Platform.isAndroid) {
  //     count = await _androidInbox.getUnClickedCount();
  //     print("count");
  //   } else if (Platform.isIOS) {
  //     count = await _iOSInbox.getUnClickedCount();
  //   }
  //   return count;
  // }
  //
  // int getUnClickedCo() {
  //   int count = 0;
  //   this.getUnClickedCount().then((value) => {
  //     count = value
  //   });
  //   return count;
  // }

}
