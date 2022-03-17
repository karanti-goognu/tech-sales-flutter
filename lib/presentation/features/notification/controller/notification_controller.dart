import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
import 'package:moengage_inbox/inbox_message.dart';

class NotificationController extends GetxController {
  MoEngageInbox _moEngageInbox = MoEngageInbox();
  final MyRepositoryApp repository;
  NotificationController({required this.repository})
      : assert(repository != null);
  final _counterNotification = 0.obs;
  get counterNotification => _counterNotification.value;
  set counterNotification(value) => _counterNotification.value = value;

  readMessageCount() async {
    int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
    this.counterNotification = unReadMessageCount;
    return unReadMessageCount;
  }

  deleteMessage(InboxMessage message) async {
    _moEngageInbox.deleteMessage(message);
    update();
  }

  readMessage(InboxMessage message) async {
    _moEngageInbox.trackMessageClicked(message);
    update();
  }
}
