import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/bindings/app_binding.dart';
import 'package:flutter_tech_sales/bindings/dashboard_binding.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/bindings/gifts_binding.dart';
import 'package:flutter_tech_sales/bindings/home_binding.dart';
import 'package:flutter_tech_sales/bindings/influencer_binding.dart';
import 'package:flutter_tech_sales/bindings/leads__filter_binding.dart';
import 'package:flutter_tech_sales/bindings/login_binding.dart';
import 'package:flutter_tech_sales/bindings/search_binding.dart';
import 'package:flutter_tech_sales/bindings/site_binding.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/bindings/sr_binding.dart';
import 'package:flutter_tech_sales/bindings/tutorial_binding.dart';
import 'package:flutter_tech_sales/bindings/view_old_lead_binding.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/dashboard.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_converted_table_screen.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_generated_site_view.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/events.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/form_add_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/gifts/gifts.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/start_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/update_event.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/add_new_influencer_form.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/influencer_view.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/ViewOldLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login_otp_screen.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_calender_event.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_event.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_mwp.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_mwp_plan_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/edit_influencer_meet_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/edit_visit_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/influencer_meet_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/visit_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/widgets/dealers_list_view.dart';
import 'package:flutter_tech_sales/presentation/features/notification/view/NotificationScreen.dart';
import 'package:flutter_tech_sales/presentation/features/search/view/search_screen.dart';
import 'package:flutter_tech_sales/presentation/features/search/view/site_search_screen.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_creation.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/servicerequests.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/site_screen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/view/VideoRequests.dart';
import 'package:get/get.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.SEARCH_SCREEN,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.SEARCH_SITES_SCREEN,
        page: () => SiteSearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: Routes.HOME_SCREEN,
        page: () => HomeScreen(),
        bindings: [AppBinding(), HomeScreenBinding(), SRBinding()]),
    GetPage(
        name: Routes.VERIFY_OTP,
        page: () => LoginOtpScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.LEADS_SCREEN,
        page: () => LeadScreen(),
        binding: LeadsFilterBinding()),
    GetPage(
        name: Routes.ADD_LEADS_SCREEN,
        page: () => AddNewLeadForm(),
        binding: AddLeadsBinding()),
    GetPage(
        name: Routes.VIEW_OLD_LEAD_SCREEN,
        page: () => ViewOldLeadScree(),
        binding: ViewOldLeadsBinding()),
    GetPage(
        name: Routes.SITES_SCREEN,
        page: () => SiteScreen(),
        binding: SiteBinding()),
    GetPage(
        name: Routes.ADD_MWP_SCREEN,
        page: () => AddMWP(),
        binding: AppBinding()),
    GetPage(
        name: Routes.ADD_MWP_PLAN_SCREEN,
        page: () => AddMWPPlan(),
        binding: AppBinding()),
    GetPage(
        name: Routes.ADD_EVENT_SCREEN,
        page: () => AddEvent(),
        bindings: [AppBinding(), InfBinding()]),
    GetPage(
        name: Routes.ADD_CALENDER_SCREEN,
        page: () => AddCalenderEventPage(),
        binding: AppBinding()),
    GetPage(
        name: Routes.VISIT_SCREEN,
        page: () => AddEventVisit(),
        binding: AppBinding()),
    GetPage(
        name: Routes.VISIT_VIEW_SCREEN,
        page: () => EditEventVisit(),
        binding: AppBinding()),
    GetPage(
        name: Routes.MEET_SCREEN,
        page: () => AddEventInfluencerMeet(),
        binding: AppBinding()),
    GetPage(
        name: Routes.VIEW_MEET_SCREEN,
        page: () => ViewEventVisit(),
        binding: AppBinding()),
    GetPage(
        name: Routes.DEALER_LIST_VIEW,
        page: () => DealersListViewWidget(),
        binding: AppBinding()),
    GetPage(
      name: Routes.SERVICE_REQUESTS,
      page: () => ServiceRequests(),
      binding: SRBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_REQUEST_CREATION,
      page: () => RequestCreation(),
      binding: SRBinding(),
    ),
    GetPage(
      name: Routes.VIDEO_TUTORIAL,
      page: () => VideoRequests(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: Routes.INFLUENCER_LIST,
      page: () => InfluencerView(),
      binding: InfBinding(),
    ),
    GetPage(
      name: Routes.ADD_INFLUENCER,
      page: () => FormAddInfluencer(),
      binding: InfBinding(),
    ),
     GetPage(
      name: Routes.DASHBOARD,
      page: () => Dashboard(),
      binding: DashboardBinding(),
    ),
     GetPage(
       name: Routes.DASHBOARD_SITE_LIST,
       page: () => VolumeGeneratedSiteList(),
       binding: SRBinding(),
     ),
    GetPage(
      name: Routes.DASHBOARD_VOLUME_CONVERTED,
      page: () => VolumeConvertedTable(),
      binding: SRBinding(),
    ),

    GetPage(
      name: Routes.EVENTS_GIFTS,
      page: () => Events(),
      binding: EGBinding(),
    ),
    GetPage(
      name: Routes.ADD_EVENTS,
      page: () => FormAddEvent(),
      binding: EGBinding(),
    ),
    // GetPage(
    //   name: Routes.DETAIL_EVENT,
    //   page: () => DetailViewEvent(),
    //   binding: EGBinding(),
    // ),
    // GetPage(
    //   name: Routes.CANCEL_EVENT,
    //   page: () => CancelEvent(),
    //   //binding: DashboardBinding(),
    // ),
    GetPage(
      name: Routes.START_EVENT,
      page: () => StartEvent(),
      //binding: DashboardBinding(),
    ),
    // GetPage(
    //   name: Routes.END_EVENT,
    //   page: () => EndEvent(),
    //   //binding: DashboardBinding(),
    // ),
    GetPage(
      name: Routes.UPDATE_EVENT,
      page: () => UpdateEvent(),
      //binding: DashboardBinding(),
    ),
    // GetPage(
    //   name: Routes.UPDATE_DLR_INF,
    //   page: () => UpdateDlrInf(),
    //   binding: EGBinding(),
    // ),
    GetPage(
      name: Routes.GIFTS_VIEW,
      page: () => GiftsView(),
      binding: GiftsBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationScreen(),
    ),
  ];
}
