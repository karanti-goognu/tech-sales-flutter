import 'package:flutter_tech_sales/utils/constants/db_constants.dart';

class SitesListModel {
  List<SitesEntity> sitesEntity;
  String respCode;
  String respMsg;
  String totalSitePotential;
  String totalSiteCount;

  SitesListModel(
      {this.sitesEntity,
      this.respCode,
      this.respMsg,
      this.totalSitePotential,
      this.totalSiteCount});

  SitesListModel.fromJson(Map<String, dynamic> json) {
    if (json['sitesEntity'] != null) {
      sitesEntity = new List<SitesEntity>();
      json['sitesEntity'].forEach((v) {
        sitesEntity.add(new SitesEntity.fromJson(v));
      });
    }
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
    totalSitePotential = json['total_Site_Potential'];
    totalSiteCount = json['total_Site_Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sitesEntity != null) {
      data['sitesEntity'] = this.sitesEntity.map((v) => v.toJson()).toList();
    }
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    data['total_Site_Potential'] = this.totalSitePotential;
    data['total_Site_Count'] = this.totalSiteCount;
    return data;
  }
}

class SitesEntity {
  int siteId;
  int leadId;
  String siteSegment;
  String assignedTo;
  int siteStatusId;
  int siteOppertunityId;
  int siteProbabilityWinningId;
  int siteStageId;
  String contactName;
  String contactNumber;
  String siteCreationDate;
  String siteGeotag;
  String siteGeotagLat;
  String siteGeotagLong;
  String sitePincode;
  String siteState;
  String siteDistrict;
  String siteTaluk;
  double siteScore;
  String sitePotentialMt;
  String reraNumber;
  String dealerId;
  String siteBuiltArea;
  int noOfFloors;
  String productDemo;
  String productOralBriefing;
  String soCode;
  String plotNumber;
  String inactiveReasonText;
  String nextVisitDate;
  String closureReasonText;
  String createdBy;
  int createdOn;
  String updatedBy;
  int updatedOn;
  int syncStatus;




  SitesEntity(
      {this.siteId,
      this.leadId,
      this.siteSegment,
      this.assignedTo,
      this.siteStatusId,
      this.siteStageId,
      this.contactName,
      this.contactNumber,
      this.siteOppertunityId,
      this.siteCreationDate,
      this.siteGeotag,
      this.siteGeotagLat,
      this.siteGeotagLong,
      this.sitePincode,
      this.siteState,
      this.siteDistrict,
      this.siteTaluk,
      this.siteScore,
      this.siteProbabilityWinningId,
      this.sitePotentialMt,
      this.reraNumber,
      this.dealerId,
      this.siteBuiltArea,
      this.noOfFloors,
      this.productDemo,
      this.productOralBriefing,
      this.soCode,
      this.plotNumber,
      this.inactiveReasonText,
      this.nextVisitDate,
      this.closureReasonText,
      this.createdBy,
      this.createdOn,
      this.updatedBy,
      this.updatedOn,
      this.syncStatus});

  SitesEntity.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'] ?? 0;
    leadId = json['leadId'] ?? 0;
    siteSegment = json['siteSegment'] ?? "";
    assignedTo = json['assignedTo'] ?? "";
    siteStatusId = json['siteStatusId'] ?? 0;
    siteStageId = json['siteStageId'] ?? 0;
    contactName = json['contactName'] ?? "";
    contactNumber = json['contactNumber'] ?? "";
    siteOppertunityId = json['siteOppertunityId'] ?? 0;
    siteProbabilityWinningId = json['siteProbabilityWinningId'] ?? 0;
    siteCreationDate = json['siteCreationDate'] ?? "";
    siteGeotag = json['siteGeotag'] ?? "";
    siteGeotagLat = json['siteGeotagLat'] ?? "";
    siteGeotagLong = json['siteGeotagLong'] ?? "";
    sitePincode = json['sitePincode'] ?? "";
    siteState = json['siteState'] ?? "";
    siteDistrict = json['siteDistrict'] ?? "";
    siteTaluk = json['siteTaluk'] ?? "";
    siteScore = json['siteScore'] ?? "";
    sitePotentialMt = json['sitePotentialMt'] ?? "";
    reraNumber = json['reraNumber'] ?? "";
    dealerId = json['dealerId'] ?? "";
    siteBuiltArea = json['siteBuiltArea'] ?? "";
    noOfFloors = json['noOfFloors'] ?? 0;
    productDemo = json['productDemo'] ?? "";
    productOralBriefing = json['productOralBriefing'] ?? "";
    soCode = json['soCode'] ?? "";
    plotNumber = json['plotNumber'] ?? "";
    inactiveReasonText = json['inactiveReasonText'] ?? "";
    nextVisitDate = json['nextVisitDate'] ?? "";
    closureReasonText = json['closureReasonText'] ?? "";
    createdBy = json['createdBy'] ?? "";
    createdOn = json['createdOn'] ?? 0;
    updatedBy = json['updatedBy'] ?? "";
    updatedOn = json['updatedOn'] ?? 0;
  }

  Map<String, dynamic> toJson() {final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['leadId'] = this.leadId;
    data['siteSegment'] = this.siteSegment;
    data['assignedTo'] = this.assignedTo;
    data['siteStatusId'] = this.siteStatusId;
    data['siteStageId'] = this.siteStageId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['siteOppertunityId'] = this.siteOppertunityId;
    data['siteProbabilityWinningId'] = this.siteProbabilityWinningId;
    data['siteCreationDate'] = this.siteCreationDate;
    data['siteGeotag'] = this.siteGeotag;
    data['siteGeotagLat'] = this.siteGeotagLat;
    data['siteGeotagLong'] = this.siteGeotagLong;
    data['sitePincode'] = this.sitePincode;
    data['siteState'] = this.siteState;
    data['siteDistrict'] = this.siteDistrict;
    data['siteTaluk'] = this.siteTaluk;
    data['siteScore'] = this.siteScore;
    data['sitePotentialMt'] = this.sitePotentialMt;
    data['reraNumber'] = this.reraNumber;
    data['dealerId'] = this.dealerId;
    data['siteBuiltArea'] = this.siteBuiltArea;
    data['noOfFloors'] = this.noOfFloors;
    data['productDemo'] = this.productDemo;
    data['productOralBriefing'] = this.productOralBriefing;
    data['soCode'] = this.soCode;
    data['plotNumber'] = this.plotNumber;
    data['inactiveReasonText'] = this.inactiveReasonText;
    data['nextVisitDate'] = this.nextVisitDate;
    data['closureReasonText'] = this.closureReasonText;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    return data;
  }


  /*Extract details from Map object*/
  SitesEntity.fromMapObject(Map<String, dynamic> map) {
    this.siteId = map[DbConstants.COL_SITE_ID];
    this.leadId = map[DbConstants.COL_LEAD_ID];
    this.siteSegment = map[DbConstants.COL_SITE_SEGMENT];
    this.assignedTo = map[DbConstants.COL_ASSIGNED_TO];
    this.siteStatusId = map[DbConstants.COL_SITE_STAGE_ID];
    this.siteStageId = map[DbConstants.COL_SITE_STATUS_ID];
    this.contactName = map[DbConstants.COL_CONTACT_NAME];
    this.contactNumber = map[DbConstants.COL_CONTACT_NUMBER];
    this.siteOppertunityId = map[DbConstants.COL_SITE_OPPERTUNITY_ID];
    this.siteCreationDate = map[DbConstants.COL_SITE_CREATION_DATE];
    this.siteGeotag = map[DbConstants.COL_SITE_GEO_TAG];
    this.siteGeotagLat = map[DbConstants.COL_SITE_GEO_TAG_LAT];
    this.siteGeotagLong = map[DbConstants.COL_SITE_GEO_TAG_LONG];
    this.sitePincode = map[DbConstants.COL_SITE_PIN_CODE];
    this.siteState = map[DbConstants.COL_SITE_STATE];
    this.siteDistrict = map[DbConstants.COL_SITE_DISTRICT];
    this.siteTaluk = map[DbConstants.COL_SITE_TALUK];
    this.siteScore = map[DbConstants.COL_SITE_SCORE];
    this.siteProbabilityWinningId = map[DbConstants.COL_SITE_PROBABILITY_WINNING_ID];
    this.sitePotentialMt = map[DbConstants.COL_SITE_POTENTIAL_MT];
    this.reraNumber = map[DbConstants.COL_RERA_NUMBER];
    this.dealerId = map[DbConstants.COL_DEALER_ID];
    this.siteBuiltArea = map[DbConstants.COL_SITE_BUILT_AREA];
    this.noOfFloors = map[DbConstants.COL_NO_OF_FLOORS];
    this.productDemo = map[DbConstants.COL_PRODUCT_DEMO];
    this.productOralBriefing = map[DbConstants.COL_PRODUCT_ORAL_BRIEFING];
    this.soCode = map[DbConstants.COL_SO_CODE];
    this.plotNumber = map[DbConstants.COL_PLOT_NUMBER];
    this.inactiveReasonText = map[DbConstants.COL_INACTIVE_REASON_TEXT];
    this.nextVisitDate = map[DbConstants.COL_NEXT_VISIT_DATE];
    this.closureReasonText = map[DbConstants.COL_CLOSURE_REASON_TEXT];
    this.createdBy = map[DbConstants.COL_CREATED_BY];
    this.createdOn = map[DbConstants.COL_CREATED_ON];
    this.updatedBy = map[DbConstants.COL_UPDATED_BY];
    this.updatedOn = map[DbConstants.COL_UPDATED_ON];
    this.syncStatus = map[DbConstants.COL_SYNC_STATUS];
  }
}
