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
 //
 static const String baseUrl = 'https://mobileqacloud.dalmiabharat.com/tech_sales_server';
 static const String baseUrlforImages = 'https://mobileqacloud.dalmiabharat.com/tso/leads';
 static const String baseUrlforImagesSites = 'https://mobileqacloud.dalmiabharat.com/tso/site';

 //Development
 // static const String baseUrl = 'https://mobiledevcloud.dalmiabharat.com/tech_sales_server';
 // static const String baseUrlforImages = 'https://mobiledevcloud.dalmiabharat.com/tso/leads';
 // static const String baseUrlforImagesSites = 'https://mobiledevcloud.dalmiabharat.com/tso/sites';


 //End points
 static const String loginCheck = '$baseUrl/login/login-otp';
 static const String getAccessKey = '$baseUrl/validation/generate-access-key';
 static const String getSecretKey = '$baseUrl/validation/generate-secret-key';
 static const String retryOtp = '$baseUrl/login/login-otp-retry';
 static const String validateOtp = '$baseUrl/login/login-otp-validate';
 static const String getFilterData = '$baseUrl/leads/lead-filter-data';
 static const String getLeadsData = '$baseUrl/leads/lead-list-view?referenceID=';
 //static const String addLeadsData = '$baseUrl/leads/lead-new';
 static const String addLeadsData = '$baseUrl/leads/v2/lead-new';
 static const String getInflData = '$baseUrl/influencer/getDetails';
 static const String saveLeadsData = '$baseUrl/leads/v2/lead-save';
 static const String refreshSplashData = '$baseUrl/refresh/refresh-data?referenceID=';
 static const String getLeadData = '$baseUrl/leads/view-lead?leadId=';
 static const String getSiteData = '$baseUrl/sites/view-site?siteId=';
 static const String updateLeadsData = '$baseUrl/leads/lead-update';
 static const String updateSiteData = '$baseUrl/sites/site-update';
 static const String updateVersion2SiteData = '$baseUrl/sites/v2/site-update';
 static const String getSearchData = '$baseUrl/leads/lead-search?';
 static const String getSiteSearchData = '$baseUrl/sites/site-search/?';
 static const String getCheckInDetails = '$baseUrl/journey/details';
 static const String getSitesList = '$baseUrl/sites/site-list-view?referenceID=';
 static const String saveMWPData = '$baseUrl/mwp/mwp-save';
 static const String getMWPData = '$baseUrl/mwp/view-mwp?';
 static const String getCalendarEventData = '$baseUrl/mwp/visit-view-list?';
 static const String getCalendarEventDataByDay = '$baseUrl/mwp/visit-view?';
 static const String getTargetVsActualData = '$baseUrl/mwp/targetVsActual?referenceID=';
 //static const String saveVisit = '$baseUrl/mwp/save-visit';

 static const String saveVisit = '$baseUrl/mwp/v2/save-visit';
 static const String updateVisit = '$baseUrl/mwp/v2/update-visit';
 static const String getDealersList = '$baseUrl/mwp/add-visit?referenceID=';
 static const String viewVisitData = '$baseUrl/mwp/view-mwp-visit-meet?referenceID=';
 static const String getServiceRequestFormData = '$baseUrl/srcomplaint/sr_complaint_add';
 static const String getServiceRequestFormDataNew = '$baseUrl/srcomplaint/v2/sr_complaint_add';
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
 static const String getSiteDataVersion2 = '$baseUrl/sites/v2/view-site?siteId=';
 static const String getSiteDataVersion3 = '$baseUrl/sites/v3/view-site?siteId=';
 static const String getSiteDataVersion4 = '$baseUrl/sites/v4/view-site?siteId=';
 static const String updateVersion3SiteData = '$baseUrl/sites/v3/site-update';
 static const String updateVersion4SiteData = '$baseUrl/sites/v4/site-update';
 static const String getLeadData2 = '$baseUrl/leads/v2/view-lead?leadId=';

 //static const String siteDistList = '$baseUrl/sites/district-list';
 static const String siteDistList = '$baseUrl/sites/district-list?referenceID=';


 static String siteKittyPoints = "${baseUrl.replaceAll('tech_sales_server', 'dalmiabharat-smartd')}/tsoappintegration/getKittyPointsByBrand?partyCode="
 // "https://mobiledevcloud.dalmiabharat.com:443/dalmiabharat-smartd/tsoappintegration/getKittyPointsByBrand?partyCode="
     // '$baseUrl/sites/getKittyPointsByBrand?partyCode='
 ;

 static const String leadDistList = '$baseUrl/leads/v2/district-list?referenceID=';


 static const String saveUpdateSiteVisit = '$baseUrl/mwp/Save-update-site_visit';

 ///Events and Gifts
 static const String getAddEvent = '$baseUrl/event/add-event?referenceID=';
 static const String getInfluencer = '$baseUrl/event/view-influencer?mobileNumber=';
 static const String getAllEvents = '$baseUrl/event/event-all-list?referenceID=';
 static const String getApproveEvents = '$baseUrl/event/event-approved-list?referenceID=';
 static const String getDetailEvent = '$baseUrl/event/getEventDetail?referenceID=';
 static const String saveEvent = '$baseUrl/event/saveEventForm';
 static const String getGiftStock = '$baseUrl/gift/view-gift-stock?referenceID=';
 static const String addGiftStock = '$baseUrl/gift/add-GiftStock';
 static const String getViewLogs = '$baseUrl/gift/gift-log?referenceID=';
 static const String eventSearch = '$baseUrl/event/event-search?referenceID=';
 static const String deleteEvent = '$baseUrl/event/event-delete?referenceID=';
 static const String getDealerInfList = '$baseUrl/event/get-event-dealers-influencers-list?referenceID=';
 static const String startEvent = '$baseUrl/event/start-event';
 static const String endEvent = '$baseUrl/event/get_end_event_detail?referenceID=';
 static const String saveEventDealersInfluencers = '$baseUrl/event/save-event-dealers-influencers';
 static const String getInfDetails = '$baseUrl/influencer/get-influencer-detail?inflContact=';
 static const String saveInfluencer = '$baseUrl/influencer/save-influencer';
 static const String submitEndEvent = '$baseUrl/event/end_event';



 // pending supply
 static const String getPendingSupplyList = '$baseUrl/sites/get-pending-supplies?referenceID=';
 static const String getPendingSupplyDetails = '$baseUrl/sites/get-pending-supplies-details?referenceID=';
 static const String updatePendingSupply = '$baseUrl/sites/update-pending-supply';

 ///Influencers
 static const String addIlpInfluencer = '$baseUrl/influencer/add-ilp-influencer?referenceID=';
 static const String stateDistrictList = "$baseUrl/dap/state-district-list?referenceID=";
 static const String getInfluencerDetail = "$baseUrl/influencer/v2/get-influencer-detail?inflContact=";
 static const String saveIlpInfluencer = "$baseUrl/influencer/save-ilp-influencer?isUpdate=";
 static const String getInfluencerList = "$baseUrl/influencer/get-influencer-list?referenceID=";
 static const String getInfluencerDetailsByMembership = "$baseUrl/influencer/get-influencer-details-by-membership?memberShipId=";
 static const String searchInfluencerList = "$baseUrl/influencer/searchInfluencerList?searchText=";


}



