class DashboardMtdGeneratedVolumeSiteList {
  String respCode;
  String respMsg;
  List<SitesEntity> sitesEntity;
  String totalSiteCount;
  String totalSitePotential;

  DashboardMtdGeneratedVolumeSiteList(
      {this.respCode,
        this.respMsg,
        this.sitesEntity,
        this.totalSiteCount,
        this.totalSitePotential});

  DashboardMtdGeneratedVolumeSiteList.fromJson(Map<String, dynamic> json) {
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
    if (json['sitesEntity'] != null) {
      sitesEntity = new List<SitesEntity>();
      json['sitesEntity'].forEach((v) {
        sitesEntity.add(new SitesEntity.fromJson(v));
      });
    }
    totalSiteCount = json['total_Site_Count'];
    totalSitePotential = json['total_Site_Potential'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    if (this.sitesEntity != null) {
      data['sitesEntity'] = this.sitesEntity.map((v) => v.toJson()).toList();
    }
    data['total_Site_Count'] = this.totalSiteCount;
    data['total_Site_Potential'] = this.totalSitePotential;
    return data;
  }
}

class SitesEntity {
  String assignedTo;
  String closureReasonText;
  String contactName;
  String contactNumber;
  String createdBy;
  String createdOn;
  String dealerId;
  String inactiveReasonText;
  int leadId;
  String nextVisitDate;
  int noOfFloors;
  String plotNumber;
  String productDemo;
  String productOralBriefing;
  String reraNumber;
  String siteAddress;
  String siteBuiltArea;
  int siteCompetitionId;
  int siteConstructionId;
  String siteCreationDate;
  String siteDistrict;
  String siteGeotag;
  String siteGeotagLat;
  String siteGeotagLong;
  int siteId;
  int siteOppertunityId;
  String sitePincode;
  String sitePotentialMt;
  int siteProbabilityWinningId;
  int siteScore;
  String siteSegment;
  int siteStageId;
  String siteState;
  int siteStatusId;
  String siteTaluk;
  String soCode;
  String updatedBy;
  String updatedOn;

  SitesEntity(
      {this.assignedTo,
        this.closureReasonText,
        this.contactName,
        this.contactNumber,
        this.createdBy,
        this.createdOn,
        this.dealerId,
        this.inactiveReasonText,
        this.leadId,
        this.nextVisitDate,
        this.noOfFloors,
        this.plotNumber,
        this.productDemo,
        this.productOralBriefing,
        this.reraNumber,
        this.siteAddress,
        this.siteBuiltArea,
        this.siteCompetitionId,
        this.siteConstructionId,
        this.siteCreationDate,
        this.siteDistrict,
        this.siteGeotag,
        this.siteGeotagLat,
        this.siteGeotagLong,
        this.siteId,
        this.siteOppertunityId,
        this.sitePincode,
        this.sitePotentialMt,
        this.siteProbabilityWinningId,
        this.siteScore,
        this.siteSegment,
        this.siteStageId,
        this.siteState,
        this.siteStatusId,
        this.siteTaluk,
        this.soCode,
        this.updatedBy,
        this.updatedOn});

  SitesEntity.fromJson(Map<String, dynamic> json) {
    assignedTo = json['assignedTo'];
    closureReasonText = json['closureReasonText'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dealerId = json['dealerId'];
    inactiveReasonText = json['inactiveReasonText'];
    leadId = json['leadId'];
    nextVisitDate = json['nextVisitDate'];
    noOfFloors = json['noOfFloors'];
    plotNumber = json['plotNumber'];
    productDemo = json['productDemo'];
    productOralBriefing = json['productOralBriefing'];
    reraNumber = json['reraNumber'];
    siteAddress = json['siteAddress'];
    siteBuiltArea = json['siteBuiltArea'];
    siteCompetitionId = json['siteCompetitionId'];
    siteConstructionId = json['siteConstructionId'];
    siteCreationDate = json['siteCreationDate'];
    siteDistrict = json['siteDistrict'];
    siteGeotag = json['siteGeotag'];
    siteGeotagLat = json['siteGeotagLat'];
    siteGeotagLong = json['siteGeotagLong'];
    siteId = json['siteId'];
    siteOppertunityId = json['siteOppertunityId'];
    sitePincode = json['sitePincode'];
    sitePotentialMt = json['sitePotentialMt'];
    siteProbabilityWinningId = json['siteProbabilityWinningId'];
    siteScore = json['siteScore'];
    siteSegment = json['siteSegment'];
    siteStageId = json['siteStageId'];
    siteState = json['siteState'];
    siteStatusId = json['siteStatusId'];
    siteTaluk = json['siteTaluk'];
    soCode = json['soCode'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedTo'] = this.assignedTo;
    data['closureReasonText'] = this.closureReasonText;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['dealerId'] = this.dealerId;
    data['inactiveReasonText'] = this.inactiveReasonText;
    data['leadId'] = this.leadId;
    data['nextVisitDate'] = this.nextVisitDate;
    data['noOfFloors'] = this.noOfFloors;
    data['plotNumber'] = this.plotNumber;
    data['productDemo'] = this.productDemo;
    data['productOralBriefing'] = this.productOralBriefing;
    data['reraNumber'] = this.reraNumber;
    data['siteAddress'] = this.siteAddress;
    data['siteBuiltArea'] = this.siteBuiltArea;
    data['siteCompetitionId'] = this.siteCompetitionId;
    data['siteConstructionId'] = this.siteConstructionId;
    data['siteCreationDate'] = this.siteCreationDate;
    data['siteDistrict'] = this.siteDistrict;
    data['siteGeotag'] = this.siteGeotag;
    data['siteGeotagLat'] = this.siteGeotagLat;
    data['siteGeotagLong'] = this.siteGeotagLong;
    data['siteId'] = this.siteId;
    data['siteOppertunityId'] = this.siteOppertunityId;
    data['sitePincode'] = this.sitePincode;
    data['sitePotentialMt'] = this.sitePotentialMt;
    data['siteProbabilityWinningId'] = this.siteProbabilityWinningId;
    data['siteScore'] = this.siteScore;
    data['siteSegment'] = this.siteSegment;
    data['siteStageId'] = this.siteStageId;
    data['siteState'] = this.siteState;
    data['siteStatusId'] = this.siteStatusId;
    data['siteTaluk'] = this.siteTaluk;
    data['soCode'] = this.soCode;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}