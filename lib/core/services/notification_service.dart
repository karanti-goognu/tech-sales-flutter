import 'dart:async';
import 'dart:isolate';
import 'package:flutter_tech_sales/routes/notification_routes.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/push_campaign.dart';
import 'package:moengage_inbox/moengage_inbox.dart';

class MoengageService {
  static MoEngageFlutter _moengagePlugin;
  static bool isPushClickCall=false;
  static MoEngageInbox moEngageInbox;


  MoengageService._() {

    _moengagePlugin = MoEngageFlutter();
    _moengagePlugin?.setUpPushCallbacks(_onPushClick);
    _moengagePlugin?.initialise();
    _moengagePlugin?.registerForPushNotification();
    moEngageInbox =new MoEngageInbox();
    print("moEngageInbox  ini ${moEngageInbox.getUnClickedCount()}");
  }

  static void getInstance() {
    MoengageService._();
  }

///Set user details on moengage dashboard
  static void setMoengageData(
      {String uniqueId = "", String userName = "", String mobileNumber = ""}) {
    _moengagePlugin?.setUniqueId(uniqueId);
    _moengagePlugin?.setUserName(userName);
    _moengagePlugin?.setPhoneNumber(mobileNumber);

  }


  void _onPushClick(PushCampaign pushCampaign) {
    isPushClickCall= true;
    Map<String, dynamic> payload = pushCampaign.payload;
    String gcmWebUrl = payload["gcm_webUrl"];
    String gcmActivityName = payload["gcm_activityName"];
    if (gcmWebUrl != null) {
      String screenName= gcmWebUrl.split('/').last;
      handleDynamicLink(navigationScreenName:screenName,payloadData: payload);
    }
  }



  handleDynamicLink({String navigationScreenName, Map<String, dynamic>  payloadData}) {
    NotificationRoutes.navigateAfterResponse(screenName: navigationScreenName, payloadData: payloadData);

  }

}
