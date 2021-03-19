class DbConstants{
  /*db name*/
  static const String DATA_BASE = "dalmiatso.db";

  /*Tables Name*/
  static const String TABLE_DRAFT_LEAD = "draftLead";
  static const String TABLE_BRAND_NAME = "brandName";
  static const String TABLE_COUNTER_LIST_DEALERS = "counterListDealers";
  static const String TABLE_SITE_LIST = "sites";
  static const String TABLE_SITE_PHOTOS_ENTITY= "sitePhotosEntity";
  static const String TABLE_SITE_COMMENT_ENTITY= "siteCommentsEntity";
  static const String TABLE_SITE_FLOOR_ENTITY= "siteFloorsEntity";
  static const String TABLE_SITE_VISIT_HISTORY_ENTITY= "siteVisitHistoryEntity";
  static const String TABLE_SITE_CONSTRUCTION_STAGE_ENTITY= "constructionStageEntity";
  static const String TABLE_SITE_PROBABILITY_WINNING_ENTITY= "siteProbabilityWinningEntity";
  static const String TABLE_SITE_COMPETITION_STATUS_ENTITY= "siteCompetitionStatusEntity";

  static const String TABLE_SITE_STAGE_ENTITY= "siteStageEntity";
  static const String TABLE_SITE_INFLUENCER_ENTITY= "siteInfluencerEntity";
  static const String TABLE_SITE_NEXT_STAGE_ENTITY= "siteNextStageEntity";
  static const String TABLE_Site_OPPORTUNITY_STATUS_ENTITY= "siteOpportunityStatusEntity";
  static const String TABLE_SITE_ENTITY= "sitesModal";
  static const String TABLE_SITE_INFLUENCER= "siteInfluencerEntity";
  static const String TABLE_SITE_INFLUENCER_TYPE= "influencerTypeEntity";
  static const String TABLE_SITE_INFLUENCER_CATEGORY= "influencerCategoryEntity";


  static const String TABLE_LEAD_STATUS_ENTITY= "leadStatusEntity";
  static const String TABLE_LEAD_STAGE_ENTITY= "leadStageEntity";
  static const String TABLE_SITE_STATUS_ENTITY= "siteStatusEntity";
  static const String TABLE_SITE_SUB_TYPE_ENTITY= "siteSubTypeEntity";
  static const String TABLE_SR_COMPLAIN_RESOLUTION_ENTITY = "srComplainResolutionEntity";
  static const String TABLE_SR_COMPLAINT_TYPE_ENTITY= "srComplaintTypeEntity";
  static const String TABLE_SRCT_REQUEST_ENTITY= "srctRequestEntity";

  // static const String TABLE_SEVERITY= "severity";
  static const String TABLE_EMPLOYEE_DETAILS= "employee-details";



  /*Tables column name*/
  static const String COL_ID = "id";
  static const String COL_ROW_ID = "id_row";
  static const String COL_VISIT_HISTORY_ID = "visit_history_id";
  static const String COL_LEAD_MODEL = "leadModel";
  static const String COL_DEALER_NAME = "dealerName";
  static const String COL_CONSTRUCT_STAGE_ENTITY = "constructStageEntity";


  /* Tables SiteListTable column name*/
  static const String COL_SITE_BUILT_AREA="siteBuiltArea";
  static const String COL_PRODUCT_DEMO="siteProductDemo";
  static const String COL_PRODUCT_ORAL_BRIEFING="siteProductOralBriefing";
  static const String COL_PLOT_NUMBER="sitePlotNumber";
  static const String COL_SITE_POTENTIAL_MT="siteTotalSitePotential";
  static const String COL_OWNER_CONTACT_NAME="siteOwnerName";
  static const String COL_OWNER_CONTACT_NUMBER="siteOwnerContactNumber";
  static const String COL_SITE_ADDRESS="siteAddress";
  static const String COL_SITE_STATE="siteState";
  static const String COL_SITE_DISTRICT="siteDistrict";
  static const String COL_SITE_TALUK="siteTaluk";
  static const String COL_SITE_PIN_CODE="sitePincode";
  static const String COL_SITE_GEO_TAG_LAT="siteGeotag_latitude";
  static const String COL_SITE_GEO_TAG_LONG="siteGeotag_longitude";
  static const String COL_SITE_GEO_TAG_TYPE="siteGeotag_type";
  static const String COL_RERA_NUMBER="siteRera_number";
  static const String COL_DEALER_ID="siteDealerId";
  static const String COL_SITE_DEALER_NAME="siteDealerName";
  static const String COL_SO_ID="siteSoId";
  static const String COL_SITE_SO_NAME="siteSoname";
  static const String COL_SITE_STAGE_ID="siteStageId";
  static const String COL_INACTIVE_REASON_TEXT="inactiveReasonText";
  static const String COL_NEXT_VISIT_DATE="siteNextVisitDate";
  static const String COL_CLOSURE_REASON_TEXT="siteClosureReasonText";
  static const String COL_SITE_PROBABILITY_WINNING_ID="siteProbabilityWinningId";
  static const String COL_SITE_COMPETITION_ID="siteCompetitionId";
  static const String COL_SITE_OPPERTUNITY_ID = "siteOppertunityId";
  static const String COL_ASSIGNED_TO = "assignedTo";
  static const String COL_SITE_STATUS_ID = "siteStatusId";
  static const String COL_SITE_CREATION_DATE="siteCreationDate";
  static const String COL_SITE_CONSTRUCTION_ID="siteConstructionId";
  static const String COL_NO_OF_FLOORS="noOfFloors";
  static const String COL_SITE_SCORE="siteScore";
  static const String COL_SYNC_STATUS="syncStatus";

/* extra key other than SiteModel*/
  static const String COL_SITE_ID = "siteId";
  static const String COL_LEAD_ID = "leadId";
  static const String COL_SITE_SEGMENT = "siteSegment";
  static const String COL_CREATED_BY="createdBy";
  static const String COL_CREATED_ON="createdOn";
  static const String COL_UPDATED_BY="updatedBy";
  static const String COL_UPDATED_ON="updatedOn";


/* Tables SiteCommentsEntity column name*/
  static const String COL_SITE_COMMENT_TEXT = "siteCommentText";
  static const String COL_SITE_COMMENT_CREATOR_NAME = "creatorName";
  static const String COL_SITE_COMMENT_CREATED_BY = "createdBy";
  static const String COL_SITE_COMMENT_CREATED_ON = "createdOn";

/* Tables SitePhotosEntity column name*/
  static const String COL_SITE_PHOTO_NAME = "photoName";
  static const String COL_SITE_CREATED_BY = "createdBy";


/* Tables SiteFloorsEntity column name*/
  static const String COL_SITE_FLOOR_ID = "id";
  static const String COL_SITE_FLOOR_TXT = "siteFloorTxt";

  /* Tables SiteStageEntity column name*/
  static const String COL_SITESTAGE_ID = "id";
  static const String COL_SITE_STAGE_DESC = "siteStageDesc";

  /* Tables constructionStageText column name*/
  static const String COL_SITE_CONSTRUCTION_STAGE_ID = "id";
  static const String COL_SITE_CONSTRUCTION_STAGE_TEXT = "constructionStageText";

  /* Tables siteProbabilityStatus column name*/
  static const String COL_SITE_PROBABILITY_ID = "id";
  static const String COL_SITE_PROBABILITY_STATUS = "siteProbabilityStatus";

  /* Tables SiteCompetitionStatusEntity column name*/
  static const String COL_SITE_COMPETITION_STATUS = "competitionStatus";

  /* Tables SiteOpportunityStatusEntity column name*/
  static const String COL_SITE_OPPORTUNITY_ID = "id";
  static const String COL_SITE_OPPORTUNITY_STATUS = "opportunityStatus";

  /* Tables SiteBrandEntity column name*/
  static const String COL_BRAND_ID = "id";
  static const String COL_BRAND_NAME = "brandName";
  static const String COL_PRODUCT_NAME = "productName";



/* Tables SiteVisitHistoryEntity column name*/
  static const String COL_SITE_VISIT_HISTORY_ID = "id";
  static const String COL_SITE_VISIT_HISTORY_totalBalancePotential="totalBalancePotential";
  static const String COL_SITE_VISIT_HISTORY_constructionStageId="constructionStageId";
  static const String COL_SITE_VISIT_HISTORY_floorId="floorId";
  static const String COL_SITE_VISIT_HISTORY_stagePotential="stagePotential";
  static const String COL_SITE_VISIT_HISTORY_brandId="brandId";
  static const String COL_SITE_VISIT_HISTORY_brandPrice="brandPrice";
  static const String COL_SITE_VISIT_HISTORY_constructionDate="constructionDate";
  static const String COL_SITE_VISIT_HISTORY_siteId="siteId";
  static const String COL_SITE_VISIT_HISTORY_supplyDate="supplyDate";
  static const String COL_SITE_VISIT_HISTORY_supplyQty="supplyQty";
  static const String COL_SITE_VISIT_HISTORY_stageStatus="stageStatus";
  static const String COL_SITE_VISIT_HISTORY_CREATED_ON="createdOn";
  static const String COL_SITE_VISIT_HISTORY_CREATED_BY="createdBy";
  static const String COL_SITE_VISIT_HISTORY_soldToParty="soldToParty";
  static const String COL_SITE_VISIT_HISTORY_shipToParty="shipToParty";
  static const String COL_SITE_VISIT_HISTORY_soCode="soCode";
  static const String COL_SITE_VISIT_HISTORY_isAuthorised="isAuthorised";
  static const String COL_SITE_VISIT_HISTORY_receiptNumber="receiptNumber";
  static const String COL_SITE_VISIT_HISTORY_isExpanded="isExpanded";

  /* Tables SiteNextStageEntity column name*/
  static const String COL_SITE_NEXT_STAGE_ID = "id";
  static const String COL_SITE_NEXT_STAGE_SITE_ID = "siteId";
  static const String COL_SITE_NEXT_STAGE_construction_Id = "constructionStageId";
  static const String COL_SITE_NEXT_STAGE_Potential = "stagePotential";
  static const String COL_SITE_NEXT_STAGE_brandId = "brandId";
  static const String COL_SITE_NEXT_STAGE_brandPrice = "brandPrice";
  static const String COL_SITE_NEXT_STAGE_stageStatus = "stageStatus";
  static const String COL_SITE_NEXT_STAGE_constructionStartDt = "constructionStartDt";
  static const String COL_SITE_NEXT_STAGE_SupplyDate = "nextStageSupplyDate";
  static const String COL_SITE_NEXT_STAGE_SupplyQty = "nextStageSupplyQty";
  static const String COL_SITE_NEXT_STAGE_createdBy = "createdBy";
  static const String COL_SITE_NEXT_STAGE_createdOn = "createdOn";


  /* Tables CounterListModel column name*/
  static const String COL_COUNTER_LIST_soldToParty= "soldToParty";
  static const String COL_COUNTER_LIST_soldToPartyName = "soldToPartyName";
  static const String COL_COUNTER_LIST_shipToParty = "shipToParty";
  static const String COL_COUNTER_LIST_shipToPartyName = "shipToPartyName";


  /*leadStatusTable TABLE COL*/
  static const String COL_LEAD_STATUS_DESC = "leadStatusDesc";


  /*leadStageEntity TABLE COL*/

  static const String COL_LEAD_STAGE_DESC = "leadStageDesc";

  /*siteStatusEntity TABLE COL*/

  static const String COL_SITE_STATUS_DESC = "siteStatusDesc";

  /*siteSubTypeEntity TABLE COL*/
  static const String COL_SITE_SUB_ID = "siteSubId";
  static const String COL_SITE_SUB_TYPE_DESC = "siteSubTypeDesc";

  /*srComplainResolutionEntity TABLE COL*/
  static const String COL_RESOLUTION_TEXT = "resolutionText";

  /*srComplaintTypeEntity TABLE COL*/
  static const String COL_REQUEST_ID = "requestId";
  static const String COL_SERVICE_REQUEST_TYPE_TEXT = "serviceRequestTypeText";
  static const String COL_COMPLAINT_SEVERITY = "complaintSeverity";

  /*srctRequestEntity TABLE COL*/
  static const String COL_REQUEST_TEXT = "requestText";



  /*employee-details TABLE COL*/
  static const String COL_REFERENCE_ID = "reference-id";
  static const String COL_MOBILE_NUMBER = "mobile-number";
  static const String COL_EMPLOYEE_FIRST_NAME = "employee-first-name";
  static const String COL_EMPLOYEE_NAME = "employee-name";

  /* SiteInfluencerEntity TABLE COL*/
   static const String COL_SITE_INFLUENCER_ID = "inflId";
   static const String COL_SITE_INFLUENCER_IS_DELETE = "isDelete";
   static const String COL_SITE_INFLUENCER_CREATED_BY = "createdBy";
   static const String COL_SITE_INFLUENCER_CREATED_ON = "createdOn";
   static const String COL_SITE_INFLUENCER_UPDATED_BY = "updatedBy";
   static const String COL_SITE_INFLUENCER_UPDATED_ON = "updatedOn";
   static const String COL_SITE_INFLUENCER_UPDATED_IS_PRIMARY = "isPrimary";

  /* InfluencerTypeEntity TABLE COL*/
  static const String COL_SITE_INFLUENCER_TYPE_ID = "inflTypeId";
  static const String COL_SITE_INFLUENCER_TYPE_DESC = "inflTypeDesc";


  /* InfluencerCategoryEntity TABLE COL*/
  static const String COL_SITE_INFLUENCER_CATE_ID = "inflCatId";
  static const String COL_SITE_INFLUENCER_CATE_DESC = "inflCatDesc";




}