import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
import 'package:moengage_inbox/inbox_message.dart';

class NotificationController extends GetxController {
  MoEngageInbox _moEngageInbox = MoEngageInbox();


  @override
void onInit() {
  super.onInit();
}

final MyRepositoryApp repository;

NotificationController({@required this.repository}) : assert(repository != null);

final _counterNotification = 0.obs;

get counterNotification => _counterNotification.value;

set counterNotification(value) => _counterNotification.value = value;

readMessageCount() async {
  int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
  this.counterNotification = unReadMessageCount;
  print("Count-->"+unReadMessageCount.toString());
  return unReadMessageCount;

}

deleteMessage(InboxMessage message) async{
  _moEngageInbox.deleteMessage(message);
  update();
}

readMessage(InboxMessage message) async{
  _moEngageInbox.trackMessageClicked(message);
  update();
}
}

// class NotificationController extends GetxController{
//   MoEngageInbox _moEngageInbox = MoEngageInbox();
//
//
//   final _counterNotification = 0.obs;
//   final  _isMessageReceived = false.obs;
//
//   bool get isMessageReceived => _isMessageReceived.value;
//
//   set isMessageReceived(value) {
//     _isMessageReceived.value = value;
//   }
//
//   get counterNotification => _counterNotification.value;
//
//   set counterNotification(value) => _counterNotification.value = value;
//
//   readMessageCount() async {
//     int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
//     this.isMessageReceived=unReadMessageCount>0?true:false;
//     this.counterNotification = unReadMessageCount;
//   }
//
//   deleteMessage(InboxMessage message) async{
//     _moEngageInbox.deleteMessage(message);
//     update();
//   }
//
//   readMessage(InboxMessage message) async{
//     _moEngageInbox.trackMessageClicked(message);
//     update();
//   }
//
//
//
// }
