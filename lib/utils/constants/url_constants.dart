
import 'package:http/http.dart';

final client = Client();


abstract class UrlConstants {

  //PROD
  // static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech_sales_server';
  // static const String baseUrlforImages = 'https://mobileapps.dalmiabharat.com/tso/leads';
  // static const String baseUrlforImagesSites = 'https://mobileapps.dalmiabharat.com/tso/sites';
  //Base Url
  // static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech-sales-server';



  // // // QA
  // static const String baseUrl = 'https://mobileqacloud.dalmiabharat.com/tech_sales_server';
  // static const String baseUrlforImages = 'https://mobileqacloud.dalmiabharat.com/tso/leads';
  // static const String baseUrlforImagesSites = 'https://mobileqacloud.dalmiabharat.com/tso/site';

  // // // //Development
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
  static const String getSiteRefreshDetails = '$baseUrl/sites/siteRefresh?referenceID=';
  static const String getSiteUpdateRefreshDetails = '$baseUrl/sites/site-update-refresh?referenceID=';


  /*Update site data request key */
  static const String SITE_UPDATE_MODELS = 'siteUpdateModels';
  static const String ASSIGNED_TO = 'assignedTo';
  static const String CLOSURE_REASON_TEXT = 'closureReasonText';
  static const String CONTACT_NAME = 'contactName';
  static const String CONTACT_NUMBER = 'contactNumber';
  static const String CREATED_BY = 'createdBy';
  static const String CREATED_ON = 'createdOn';
  static const String DEALER_ID = 'dealerId';
  static const String INACTIVE_REASON_TEXT = 'inactiveReasonText';
  static const String NEXT_VISIT_DATE = 'nextVisitDate';
  static const String NO_OF_FLOORS = 'noOfFloors';
  static const String PLOT_NUMBER = 'plotNumber';
  static const String PRODUCT_DEMO = 'productDemo';
  static const String PRODUCT_ORAL_BRIEFING = 'productOralBriefing';
  static const String RERA_NUMBER = 'reraNumber';
  static const String SITE_ADDRESS = 'siteAddress';
  static const String SITE_BUILD_AREA = 'siteBuiltArea';
  static const String SO_CODE = 'soCode';
  static const String UPDATED_BY = 'updatedBy';
  static const String UPDATED_ON = 'updatedOn';
  static const String SITE_COMPETITION_ID = 'siteCompetitionId';
  static const String SITE_CONSTRUCTION_ID = 'siteConstructionId';
  static const String SITE_CREATION_DATE = 'siteCreationDate';
  static const String SITE_DISTRICT = 'siteDistrict';
  static const String SITE_GEO_TAG = 'siteGeotag';
  static const String SITE_GEO_TAG_LONG = 'siteGeotagLong';
  static const String SITE_GEO_TAG_LAT = 'siteGeotagLat';
  static const String SITE_ID = 'siteId';
  static const String SITE_PIN_CODE = 'sitePincode';
  static const String SITE_POTENTIAL_MT = 'sitePotentialMt';
  static const String SITE_PROBABILITY_WINNING_ID = 'siteProbabilityWinningId';
  static const String SITE_SCORE = 'siteScore';
  static const String SITE_SEGMENT = 'siteSegment';
  static const String SITE_STAGE_ID = 'siteStageId';
  static const String SITE_STATE = 'siteState';
  static const String SITE_STATUS_ID = 'siteStatusId';
  static const String SITE_TALUK = 'siteTaluk';
  static const String SITE_OPPERTUNITY_ID = 'siteOppertunityId';

  /*Site comment table key*/
  static const String SITE_COMMENTS_ENTITY = 'siteCommentsEntity';
  static const String CREATOR_NAME = 'creatorName';
  static const String ID = 'id';
  static const String SITE_COMMENT_TEXT = 'siteCommentText';

/*siteInfluencerEntity JSON KEY*/

  static const String SITE_INFLUENCER_ENTITY = 'siteInfluencerEntity';
  static const String IN_FL_ID = 'inflId';
  static const String IS_DELETE = 'isDelete';
  static const String IS_PRIMARY = 'isPrimary';

  /*siteNextStageEntity JSON KEYS*/
  static const String SITE_NEXT_STAGE_ENTITY = 'siteNextStageEntity';
  static const String BRAND_ID = 'brandId';
  static const String BRAND_PRICE = 'brandPrice';
  static const String CONSTRUCTION_STAGE_ID = 'constructionStageId';
  static const String CONSTRUCTION_START_DT = 'constructionStartDt';
  static const String FLOOR_ID = 'floorId';
  static const String NEXT_STAGE_SUPPLY_DATE = 'nextStageSupplyDate';
  static const String NEXT_STAGE_SUPPLY_QTY = 'nextStageSupplyQty';
  static const String STAGE_POTENTIAL = 'stagePotential';
  static const String STAGE_STATUS = 'stageStatus';

  /*sitePhotosEntity JSON KEY*/
  static const String SITE_PHOTO_ENTITY = 'sitePhotosEntity';
  static const String PHOTO_NAME = 'photoName';

  /*siteVisitHistoryEntity JSON KEY*/
  static const String SITE_VISIT_HISTORY_ENTITY = 'siteVisitHistoryEntity';
  static const String CONSTRUCTION_DATE = 'constructionDate';
  static const String IS_AUTHORISED = 'isAuthorised';
  static const String RECEIPT_NUMBER = 'receiptNumber';
  static const String SHIP_TO_PARTY = 'shipToParty';
  static const String SOLD_TO_PARTY = 'soldToParty';
  static const String SUPPLY_DATE = 'supplyDate';
  static const String SUPPLY_QTY = 'supplyQty';
  static const String TOTAL_BALANCE_POTENTIAL = 'totalBalancePotential';



}
