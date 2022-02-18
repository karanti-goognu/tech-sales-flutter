import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/bindings/site_binding.dart';
import 'package:flutter_tech_sales/bindings/sr_binding.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_updation.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';

class NotificationRoutes {
  NotificationRoutes._();

  static navigateAfterResponse(
      {@required String screenName, Map<String, dynamic> payloadData}) {
    /*need to add firebase */
    print("navigateAfterResponse   $screenName");
    print("payloadData   $payloadData");
    switch (screenName) {
      case StringConstants.SITE_LIST:
        Get.toNamed(Routes.SITES_SCREEN);
        break;
      case StringConstants.LEAD_LIST:
        Get.toNamed(Routes.LEADS_SCREEN);
        break;
      case StringConstants.DASHBOARD:
        Get.toNamed(Routes.DASHBOARD);
        break;
      case StringConstants.ADD_MWP:
        Get.toNamed(Routes.ADD_MWP_SCREEN);
        break;
      case StringConstants.SERVICE_REQUESTS:
        Get.toNamed(Routes.SERVICE_REQUESTS);
        break;
      case StringConstants.INFLUENCER_LIST:
        Get.toNamed(Routes.INFLUENCER_LIST);
        break;
      case StringConstants.VIDEO_TUTORIAL:
        Get.toNamed(Routes.VIDEO_TUTORIAL);
        break;
      case StringConstants.VIDEO_PLAYER:
        if (payloadData['url'] != null && payloadData['des'] != null)
          Get.toNamed(Routes.VIDEO_PLAYER,
              arguments: [payloadData['url'], payloadData['des']]);
        break;
      case StringConstants.EVENTS_GIFTS:
        Get.toNamed(Routes.EVENTS_GIFTS);
        break;
      case StringConstants.ADD_EVENTS:
        Get.toNamed(Routes.ADD_EVENTS);
        break;
      case StringConstants.SERVICE_REQUEST_CREATION:
        Get.toNamed(Routes.SERVICE_REQUEST_CREATION);
        break;
      case StringConstants.ADD_INFLUENCER:
        Get.toNamed(Routes.ADD_INFLUENCER);
        break;
      case StringConstants.ADD_LEADS_SCREEN:
        Get.toNamed(Routes.ADD_LEADS_SCREEN);
        break;
      case StringConstants.NOTIFICATION:
        Get.toNamed(Routes.NOTIFICATION);
        break;
      case StringConstants.GIFTS_VIEW:
        Get.toNamed(Routes.GIFTS_VIEW);
        break;
      case StringConstants.START_EVENT:
        Get.toNamed(Routes.START_EVENT);
        break;
      case StringConstants.DASHBOARD_VOLUME_CONVERTED:
        Get.toNamed(Routes.DASHBOARD_VOLUME_CONVERTED);
        break;
      case StringConstants.DASHBOARD_SITE_LIST:
        Get.toNamed(Routes.DASHBOARD_SITE_LIST);
        break;
      case StringConstants.DEALER_LIST_VIEW:
        Get.toNamed(Routes.DEALER_LIST_VIEW);
        break;
      case StringConstants.VIEW_MEET_SCREEN:
        Get.toNamed(Routes.VIEW_MEET_SCREEN);
        break;
      case StringConstants.SEARCH_SCREEN:
        Get.toNamed(Routes.SEARCH_SCREEN);
        break;
      case StringConstants.ADD_CALENDER_SCREEN:
        Get.toNamed(Routes.ADD_CALENDER_SCREEN);
        break;
      case StringConstants.HOME_SCREEN:
        Get.toNamed(Routes.HOME_SCREEN);
        break;
      case StringConstants.MEET_SCREEN:
        Get.toNamed(Routes.MEET_SCREEN);
        break;
      case StringConstants.LOGIN:
        Get.toNamed(Routes.LOGIN);
        break;
      case StringConstants.LEADS_SCREEN:
        Get.toNamed(Routes.LEADS_SCREEN);
        break;
      case StringConstants.SEARCH_SITES_SCREEN:
        Get.toNamed(Routes.SEARCH_SITES_SCREEN);
        break;
      case StringConstants.ADD_MWP_PLAN_SCREEN:
        Get.toNamed(Routes.ADD_MWP_SCREEN);
        break;
      case StringConstants.VISIT_SCREEN:
        Get.toNamed(Routes.VISIT_SCREEN);
        break;
      case StringConstants.ADD_EVENT_SCREEN:
        Get.toNamed(Routes.ADD_EVENT_SCREEN);
        break;
      case StringConstants.VERIFY_OTP:
        Get.toNamed(Routes.VERIFY_OTP);
        break;
      case StringConstants.VISIT_VIEW_SCREEN:
        Get.toNamed(Routes.VISIT_VIEW_SCREEN);
        break;
      case StringConstants.SITES_SCREEN:
        // Get.toNamed(Routes.SITES_SCREEN);
        Get.to(()=>ViewSiteScreenNew(siteId: payloadData['id'],tabIndex: 0,));
        break;

      case StringConstants.SERVICE_REQUEST_UPDATESCREEN:
        if (payloadData['id'] != null)
          Get.to(()=>
            RequestUpdation(
                id: payloadData["id"] ),
            transition: Transition.rightToLeft,
            binding: SRBinding(),
          );
        break;
    // case StringConstants.ALL_EVENTS:
    //   Get.toNamed(Routes.ALL_EVENTS);
    //   break;
    // case StringConstants.CANCEL_EVENT:
    //   Get.toNamed(Routes.CANCEL_EVENT);
    //   break;
    // case StringConstants.UPDATE_EVENT:
    //   Get.toNamed(Routes.UPDATE_EVENT);
    //   break;
    // case StringConstants.END_EVENT:
    //   Get.toNamed(Routes.END_EVENT);
    //   break;

      default:
        Get.toNamed(Routes.HOME_SCREEN);
        break;
    }
  }

// static landingPushNavigation({LandingController landingController, String screenName}) {
//   landingController.viewContentWidget(screenName);
// }

}

