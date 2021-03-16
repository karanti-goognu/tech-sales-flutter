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
  bool syncStatus;

  SitesEntity(
      {

        this.siteId,
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
    siteId = json['siteId'];
    leadId = json['leadId'];
    siteSegment = json['siteSegment'];
    assignedTo = json['assignedTo'];
    siteStatusId = json['siteStatusId'];
    siteStageId = json['siteStageId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    siteOppertunityId = json['siteOppertunityId'];
    siteProbabilityWinningId = json['siteProbabilityWinningId'];
    siteCreationDate = json['siteCreationDate'];
    siteGeotag = json['siteGeotag'];
    siteGeotagLat = json['siteGeotagLat'];
    siteGeotagLong = json['siteGeotagLong'];
    sitePincode = json['sitePincode'];
    siteState = json['siteState'];
    siteDistrict = json['siteDistrict'];
    siteTaluk = json['siteTaluk'];
    siteScore = json['siteScore'];
    sitePotentialMt = json['sitePotentialMt'];
    reraNumber = json['reraNumber'];
    dealerId = json['dealerId'];
    siteBuiltArea = json['siteBuiltArea'];
    noOfFloors = json['noOfFloors'];
    productDemo = json['productDemo'];
    productOralBriefing = json['productOralBriefing'];
    soCode = json['soCode'];
    plotNumber = json['plotNumber'];
    inactiveReasonText = json['inactiveReasonText'];
    nextVisitDate = json['nextVisitDate'];
    closureReasonText = json['closureReasonText'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
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
}
