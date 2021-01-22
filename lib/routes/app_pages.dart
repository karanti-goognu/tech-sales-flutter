import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/bindings/app_binding.dart';
import 'package:flutter_tech_sales/bindings/home_binding.dart';
import 'package:flutter_tech_sales/bindings/leads__filter_binding.dart';
import 'package:flutter_tech_sales/bindings/login_binding.dart';
import 'package:flutter_tech_sales/bindings/search_binding.dart';
import 'package:flutter_tech_sales/bindings/site_binding.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/bindings/sr_binding.dart';
import 'package:flutter_tech_sales/bindings/tutorial_binding.dart';
import 'package:flutter_tech_sales/bindings/view_old_lead_binding.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
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
        binding: HomeScreenBinding()),
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
        binding: AppBinding()),
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
    // GetPage(
    //   name: Routes.SERVICE_REQUEST_UPDATESCREEN,
    //   page: () => RequestUpdation(),
    //   binding: SRBinding(),
    // ),
  ];
}
