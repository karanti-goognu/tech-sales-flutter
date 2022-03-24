import 'package:flutter_tech_sales/routes/notification_routes.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/push_campaign.dart';
import 'package:moengage_inbox/moengage_inbox.dart';

class MoengageService {
  static MoEngageFlutter? _moengagePlugin;
  static bool isPushClickCall=false;
  static late MoEngageInbox moEngageInbox;


  MoengageService._() {

    _moengagePlugin = MoEngageFlutter();
    _moengagePlugin?.setUpPushCallbacks(_onPushClick);
    _moengagePlugin?.initialise();
    _moengagePlugin?.registerForPushNotification();
    moEngageInbox =new MoEngageInbox();
    print("moEngageInbox  ini ${moEngageInbox.getUnClickedCount()}");
  }

  static void getInstance() {
    print("MoEngage Get instance");
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
    print("On Push Click");
    isPushClickCall= true;
    Map<String, dynamic> payload = pushCampaign.payload;
    String? gcmWebUrl = payload["gcm_webUrl"];
    if (gcmWebUrl != null) {
      print("GCM not null");
      String screenName= gcmWebUrl.split('/').last;
      handleDynamicLink(navigationScreenName:screenName,payloadData: payload);
    }
  }



  handleDynamicLink({String? navigationScreenName, Map<String, dynamic>?  payloadData}) {
    print("Handle Dynamic Link");
    NotificationRoutes.navigateAfterResponse(screenName: navigationScreenName, payloadData: payloadData);

  }

}
