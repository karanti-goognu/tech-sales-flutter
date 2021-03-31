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




  String siteAddress;
  int siteCompetitionId;
  int siteConstructionId;
  String dealerConfirmedChangedBy;
  int dealerConfirmedChangedOn;
  String isDealerConfirmedChangedBySo;
  String subdealerId;



  SitesEntity(
      {this.assignedTo,
        this.closureReasonText,
        this.contactName,
        this.contactNumber,
        this.createdBy,
        this.createdOn,
        this.dealerConfirmedChangedBy,
        this.dealerConfirmedChangedOn,
        this.dealerId,
        this.inactiveReasonText,
        this.isDealerConfirmedChangedBySo,
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
        this.subdealerId,
        this.updatedBy,
        this.updatedOn});

  SitesEntity.fromJson(Map<String, dynamic> json) {
    assignedTo = json['assignedTo'];
    closureReasonText = json['closureReasonText'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dealerConfirmedChangedBy = json['dealerConfirmedChangedBy'];
    dealerConfirmedChangedOn = json['dealerConfirmedChangedOn'];
    dealerId = json['dealerId'];
    inactiveReasonText = json['inactiveReasonText'];
    isDealerConfirmedChangedBySo = json['isDealerConfirmedChangedBySo'];
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
    subdealerId = json['subdealerId'];
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
    data['dealerConfirmedChangedBy'] = this.dealerConfirmedChangedBy;
    data['dealerConfirmedChangedOn'] = this.dealerConfirmedChangedOn;
    data['dealerId'] = this.dealerId;
    data['inactiveReasonText'] = this.inactiveReasonText;
    data['isDealerConfirmedChangedBySo'] = this.isDealerConfirmedChangedBySo;
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
    data['subdealerId'] = this.subdealerId;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
