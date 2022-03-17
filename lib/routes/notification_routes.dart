import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/bindings/influencer_binding.dart';
import 'package:flutter_tech_sales/bindings/sr_binding.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/influencer_detail_view.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/ViewLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_updation.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/deep_link_constants.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:get/get.dart';

class NotificationRoutes {
  NotificationRoutes._();

  static navigateAfterResponse(
      {required String? screenName, Map<String, dynamic>? payloadData}) {
    TsoLogger.printLog("navigateAfterResponse   $screenName");
    TsoLogger.printLog("payloadData   $payloadData");
    switch (screenName) {
      case DeepLinkConstants.SITE_LIST:
        Get.toNamed(Routes.SITES_SCREEN);
        break;
      case DeepLinkConstants.LEAD_LIST:
        Get.toNamed(Routes.LEADS_SCREEN);
        break;
      case DeepLinkConstants.DASHBOARD:
        Get.toNamed(Routes.DASHBOARD);
        break;
      case DeepLinkConstants.ADD_MWP:
        Get.toNamed(Routes.ADD_MWP_SCREEN);
        break;
      case DeepLinkConstants.SERVICE_REQUESTS:
        Get.toNamed(Routes.SERVICE_REQUESTS);
        break;
      case DeepLinkConstants.INFLUENCER_LIST:
        Get.toNamed(Routes.INFLUENCER_LIST);
        break;
      case DeepLinkConstants.VIDEO_TUTORIAL:
        Get.toNamed(Routes.VIDEO_TUTORIAL);
        break;
      case DeepLinkConstants.EVENTS_GIFTS:
        Get.toNamed(Routes.EVENTS_GIFTS);
        break;
      case DeepLinkConstants.ADD_EVENTS:
        Get.toNamed(Routes.ADD_EVENTS);
        break;
      case DeepLinkConstants.SERVICE_REQUEST_CREATION:
        Get.toNamed(Routes.SERVICE_REQUEST_CREATION);
        break;
      case DeepLinkConstants.ADD_INFLUENCER:
        Get.toNamed(Routes.ADD_INFLUENCER);
        break;
      case DeepLinkConstants.ADD_LEADS_SCREEN:
        Get.toNamed(Routes.ADD_LEADS_SCREEN);
        break;
      case DeepLinkConstants.NOTIFICATION:
        Get.toNamed(Routes.NOTIFICATION);
        break;
      case DeepLinkConstants.GIFTS_VIEW:
        Get.toNamed(Routes.GIFTS_VIEW);
        break;
      case DeepLinkConstants.START_EVENT:
        Get.toNamed(Routes.START_EVENT);
        break;
      case DeepLinkConstants.DASHBOARD_VOLUME_CONVERTED:
        Get.toNamed(Routes.DASHBOARD_VOLUME_CONVERTED);
        break;
      case DeepLinkConstants.DASHBOARD_SITE_LIST:
        Get.toNamed(Routes.DASHBOARD_SITE_LIST);
        break;
      case DeepLinkConstants.DEALER_LIST_VIEW:
        Get.toNamed(Routes.DEALER_LIST_VIEW);
        break;
      case DeepLinkConstants.VIEW_MEET_SCREEN:
        Get.toNamed(Routes.VIEW_MEET_SCREEN);
        break;
      case DeepLinkConstants.SEARCH_SCREEN:
        Get.toNamed(Routes.SEARCH_SCREEN);
        break;
      case DeepLinkConstants.ADD_CALENDER_SCREEN:
        Get.toNamed(Routes.ADD_CALENDER_SCREEN);
        break;
      case DeepLinkConstants.HOME_SCREEN:
        Get.toNamed(Routes.HOME_SCREEN);
        break;
      case DeepLinkConstants.MEET_SCREEN:
        Get.toNamed(Routes.MEET_SCREEN);
        break;
      case DeepLinkConstants.LOGIN:
        Get.toNamed(Routes.LOGIN);
        break;
      case DeepLinkConstants.LEADS_SCREEN:
        Get.toNamed(Routes.LEADS_SCREEN);
        break;
      case DeepLinkConstants.SEARCH_SITES_SCREEN:
        Get.toNamed(Routes.SEARCH_SITES_SCREEN);
        break;
      case DeepLinkConstants.ADD_MWP_PLAN_SCREEN:
        Get.toNamed(Routes.ADD_MWP_SCREEN);
        break;
      case DeepLinkConstants.VISIT_SCREEN:
        Get.toNamed(Routes.VISIT_SCREEN);
        break;
      case DeepLinkConstants.ADD_EVENT_SCREEN:
        Get.toNamed(Routes.ADD_EVENT_SCREEN);
        break;
      case DeepLinkConstants.VERIFY_OTP:
        Get.toNamed(Routes.VERIFY_OTP);
        break;
      case DeepLinkConstants.VISIT_VIEW_SCREEN:
        Get.toNamed(Routes.VISIT_VIEW_SCREEN);
        break;
      case DeepLinkConstants.VIDEO_PLAYER:
        if (payloadData!['url'] != null && payloadData['des'] != null) {
          Get.toNamed(Routes.VIDEO_PLAYER,
              arguments: [payloadData['url'], payloadData['des']]);
        }
        break;
      case DeepLinkConstants.SITES_SCREEN:
        if (payloadData!['id'] != null) {
          Get.to(() => ViewSiteScreenNew(
                siteId: payloadData['id'],
                tabIndex: 0,
              ));
        }
        break;
      case DeepLinkConstants.SERVICE_REQUEST_UPDATESCREEN:
        if (payloadData!['id'] != null) {
          Get.to(
            () => RequestUpdation(id: payloadData["id"]),
            transition: Transition.rightToLeft,
            binding: SRBinding(),
          );
        }
        break;
      case DeepLinkConstants.VIEW_OLD_LEAD_SCREEN:
        if (payloadData!['id'] != null) {
          Get.to(() => ViewLeadScreen(int.parse(payloadData['id'])),
              binding: AddLeadsBinding());
        }
        break;
      case DeepLinkConstants.INFLUENCER_DETAILS:
        if (payloadData!['id'] != null) {
          Get.to(() => InfluencerDetailView(int.parse(payloadData['id'])),
              binding: InfBinding());
        }
        break;
      default:
        Get.toNamed(Routes.HOME_SCREEN);
        break;
    }
  }
}
