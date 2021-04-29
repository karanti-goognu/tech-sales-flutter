
import 'package:http/http.dart';

final client = Client();


abstract class UrlConstants {

  //PROD
  // static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech_sales_server';
  // static const String baseUrlforImages = 'https://mobileapps.dalmiabharat.com/tso/leads';
  // static const String baseUrlforImagesSites = 'https://mobileapps.dalmiabharat.com/tso/sites';
  //Base Url
  // static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech-sales-server';


  // QA

//   static const String baseUrl = 'https://mobileqacloud.dalmiabharat.com/tech_sales_server';
//   static const String baseUrlforImages = 'https://mobileqacloud.dalmiabharat.com/tso/leads';
//   static const String baseUrlforImagesSites = 'https://mobileqacloud.dalmiabharat.com/tso/site';

  //Development
 static const String baseUrl = 'https://mobiledevcloud.dalmiabharat.com/tech_sales_server';
 static const String baseUrlforImages = 'https://mobiledevcloud.dalmiabharat.com/tso/leads';
 static const String baseUrlforImagesSites = 'https://mobiledevcloud.dalmiabharat.com/tso/sites';




  //End points
  static const String loginCheck = '$baseUrl/login/login-otp';
  static const String getAccessKey = '$baseUrl/validation/generate-access-key';
  static const String getSecretKey = '$baseUrl/validation/generate-secret-key';
  static const String retryOtp = '$baseUrl/login/login-otp-retry';
  static const String validateOtp = '$baseUrl/login/login-otp-validate';
  static const String getFilterData = '$baseUrl/leads/lead-filter-data';
  static const String getLeadsData = '$baseUrl/leads/lead-list-view?referenceID=';
  static const String addLeadsData = '$baseUrl/leads/lead-new';
  static const String getInflData = '$baseUrl/influencer/getDetails';
  static const String saveLeadsData = '$baseUrl/leads/lead-save';
  static const String refreshSplashData = '$baseUrl/refresh/refresh-data?referenceID=';
  static const String getLeadData = '$baseUrl/leads/view-lead?leadId=';
  static const String getSiteData = '$baseUrl/sites/view-site?siteId=';
  static const String updateLeadsData = '$baseUrl/leads/lead-update';
  static const String updateSiteData = '$baseUrl/sites/site-update';
  static const String getSearchData = '$baseUrl/leads/lead-search?';
  static const String getSiteSearchData = '$baseUrl/sites/site-search/?';
  static const String getCheckInDetails = '$baseUrl/journey/details';
  static const String getSitesList = '$baseUrl/sites/site-list-view?referenceID=';
  static const String saveMWPData = '$baseUrl/mwp/mwp-save';
  static const String getMWPData = '$baseUrl/mwp/view-mwp?';
  static const String getCalendarEventData = '$baseUrl/mwp/visit-view-list?';
  static const String getCalendarEventDataByDay = '$baseUrl/mwp/visit-view?';
  static const String getTargetVsActualData = '$baseUrl/mwp/targetVsActual?referenceID=';
  static const String saveVisit = '$baseUrl/mwp/save-visit';
  static const String updateVisit = '$baseUrl/mwp/update-visit';
  static const String getDealersList = '$baseUrl/mwp/add-visit?referenceID=';
  static const String viewVisitData = '$baseUrl/mwp/view-mwp-visit-meet?referenceID=';
  static const String getServiceRequestFormData = '$baseUrl/srcomplaint/sr_complaint_add';
  static const String getRequestorDetails = '$baseUrl/srcomplaint/sr_requester_search?referenceId=';
  static const String getComplaintListData = '$baseUrl/srcomplaint/sr_list_view?referenceId=';
  static const String addServiceRequest = '$baseUrl/srcomplaint/sr_complaint_save';
  static const String srComplaintView = '$baseUrl/srcomplaint/sr_complaint_view?referenceId=';
  static const String updateServiceRequest = '$baseUrl/srcomplaint/sr_complaint_update';
  static const String AppTutorialList = '$baseUrl/tsoAppTuorial/view';
  static const String getSiteAreaDetails = '$baseUrl/sites/site-areaDetails?referenceID=';
  static const String homepageDashboardData = '$baseUrl/dashboard/view?referenceID=';
  static const String shareReport = '$baseUrl/dashboard/reportSharing?reference-Id=';
  static const String dashboadrMonthlyView = '$baseUrl/dashboard/dashboadrMonthlyView?referenceID=';
  static const String dashboardMtdConvertedVolumeList = '$baseUrl/dashboard/dashboardMtdConvertedVolumeList?referenceID=';
  static const String dashboardMtdGeneratedVolumeSiteList = '$baseUrl/dashboard/dashboardMtdGeneratedVolumeSiteList?referenceID=';
  static const String dashboardYearlyView = '$baseUrl/dashboard/dashboardYearlyView?referenceID=';



  ///Events and Gifts
  static const String getAddEvent = '$baseUrl/event/add-event?referenceID=';
  static const String getInfluencer = '$baseUrl/event/view-influencer?mobileNumber=';
  static const String getAllEvents = '$baseUrl/event/event-all-list?referenceID=';
  static const String getApproveEvents = '$baseUrl/event/event-approved-list?referenceID=';
  static const String getDetailEvent = '$baseUrl/event/getEventDetail?referenceID=';
  static const String saveEvent = '$baseUrl/event/saveEeventForm';
 static const String getGiftStock = '$baseUrl/gift/view-gift-stock?referenceID=';
 static const String addGiftStock = '$baseUrl/gift/add-GiftStock?referenceID=';

}
