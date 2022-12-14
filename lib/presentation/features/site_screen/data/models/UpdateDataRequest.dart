import 'ViewSiteDataResponse.dart';

class UpdateDataRequest {
  int siteId;
  String siteSegment;
  String assignedTo;
  String siteStatusId;
  String siteStageId;
  String contactName;
  String contactNumber;
  String siteGeotag;
  double siteGeotagLat;
  double siteGeotagLong;
  String plotNumber;
  String siteAddress;
  String sitePincode;
  String siteState;
  String siteDistrict;
  String siteTaluk;
  String sitePotentialMt;
  String reraNumber;
  String siteCreationDate;
  String dealerId;
  String siteBuiltArea;
  String noOfFloors;
  String productDemo;
  String productOralBriefing;
  String soCode;
  String inactiveReasonText;
  String nextVisitDate;
  String closureReasonText;
  String createdBy;
  String totalBalancePotential;
  List<SiteCommentsEntity> siteCommentsEntity;
  List<SiteStageHistory> siteStageHistory;

  String siteProbabilityWinningId;
  String siteCompetitionId;
  String siteOppertunityId;
  int siteConstructionId;
 // List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
  List<SiteNextStageEntity> siteNextStageEntity;
  List<SitePhotosEntity> sitePhotosEntity;
  List<SiteInfluencerEntity> siteInfluencerEntity;

  String dealerConfirmedChangedBy;
  String dealerConfirmedChangedOn;
  String isDealerConfirmedChangedBySo;
  String subdealerId;
  int kitchenCount;
  int bathroomCount;


  UpdateDataRequest(
      {this.siteId,
      this.siteSegment,
      this.assignedTo,
      this.siteStatusId,
      this.siteStageId,
      this.contactName,
      this.contactNumber,
      this.siteGeotag,
      this.siteGeotagLat,
      this.siteGeotagLong,
      this.siteAddress,
      this.sitePincode,
      this.siteState,
      this.siteDistrict,
      this.siteTaluk,
      this.sitePotentialMt,
      this.reraNumber,
      this.siteCreationDate,
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
      this.totalBalancePotential,
      this.siteCommentsEntity,
      this.siteStageHistory,
      this.siteNextStageEntity,
      this.sitePhotosEntity,
      this.siteInfluencerEntity,
      this.siteConstructionId,
      this.siteCompetitionId,
      this.siteOppertunityId,
      this.siteProbabilityWinningId,
      this.dealerConfirmedChangedBy,
      this.dealerConfirmedChangedOn,
      this.isDealerConfirmedChangedBySo,
      this.subdealerId,
      this.kitchenCount,
      this.bathroomCount

      });

  UpdateDataRequest.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    siteSegment = json['siteSegment'];
    assignedTo = json['assignedTo'];
    siteStatusId = json['siteStatusId'];
    siteStageId = json['siteStageId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    siteGeotag = json['siteGeotag'];
    siteGeotagLat = json['siteGeotagLat'];
    siteGeotagLong = json['siteGeotagLong'];
    siteAddress = json['siteAddress'];
    sitePincode = json['sitePincode'];
    siteState = json['siteState'];
    siteDistrict = json['siteDistrict'];
    siteTaluk = json['siteTaluk'];
    sitePotentialMt = json['sitePotentialMt'];
    reraNumber = json['reraNumber'];
    siteCreationDate = json['siteCreationDate'];
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
    totalBalancePotential = json['totalBalancePotential'];
    siteConstructionId = json['siteConstructionId'];
    siteCompetitionId = json['siteCompetitionId'];
    siteOppertunityId = json['siteOppertunityId'];
    siteProbabilityWinningId = json['siteProbabilityWinningId'];
    // soldToParty = json['soldToParty'];
    // shipToParty = json['shipToParty'];

    if (json['siteCommentsEntity'] != null) {
      siteCommentsEntity = new List<SiteCommentsEntity>.empty(growable: true);
      json['siteCommentsEntity'].forEach((v) {
        siteCommentsEntity.add(new SiteCommentsEntity.fromJson(v));
      });
    }
    if (json['siteStageHistorys'] != null) {
      siteStageHistory = new List<SiteStageHistory>.empty(growable: true);
      json['siteStageHistorys'].forEach((v) {
        siteStageHistory.add(new SiteStageHistory.fromJson(v));
      });
    }

    if (json['siteNextStageEntity'] != null) {
      siteNextStageEntity = new List<SiteNextStageEntity>.empty(growable: true);
      json['siteNextStageEntity'].forEach((v) {
        siteNextStageEntity.add(new SiteNextStageEntity.fromJson(v));
      });
    }
    if (json['sitePhotosEntity'] != null) {
      sitePhotosEntity = new List<SitePhotosEntity>.empty(growable: true);
      json['sitePhotosEntity'].forEach((v) {
        sitePhotosEntity.add(new SitePhotosEntity.fromJson(v));
      });
    }
    if (json['siteInfluencerEntity'] != null) {
      siteInfluencerEntity = new List<SiteInfluencerEntity>.empty(growable: true);
      json['siteInfluencerEntity'].forEach((v) {
        siteInfluencerEntity.add(new SiteInfluencerEntity.fromJson(v));
      });
    }

    dealerConfirmedChangedBy = json['dealerConfirmedChangedBy'];
    dealerConfirmedChangedOn = json['dealerConfirmedChangedOn'];
    isDealerConfirmedChangedBySo = json['isDealerConfirmedChangedBySo'];
    subdealerId = json['subdealerId'];
    kitchenCount = json['kitchenCount'];
    bathroomCount = json['bathroomCount'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['siteSegment'] = this.siteSegment;
    data['assignedTo'] = this.assignedTo;
    data['siteStatusId'] = this.siteStatusId;
    data['siteStageId'] = this.siteStageId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['siteGeotag'] = this.siteGeotag;
    data['siteGeotagLat'] = this.siteGeotagLat;
    data['siteGeotagLong'] = this.siteGeotagLong;
    data['siteAddress'] = this.siteAddress;
    data['sitePincode'] = this.sitePincode;
    data['siteState'] = this.siteState;
    data['siteDistrict'] = this.siteDistrict;
    data['siteTaluk'] = this.siteTaluk;
    data['sitePotentialMt'] = this.sitePotentialMt;
    data['reraNumber'] = this.reraNumber;
    data['siteCreationDate'] = this.siteCreationDate;
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
    data['siteConstructionId'] = this.siteConstructionId;
    data['siteCompetitionId'] = this.siteCompetitionId;
    data['siteOppertunityId'] = this.siteOppertunityId;
    data['siteProbabilityWinningId'] = this.siteProbabilityWinningId;
    // data['soldToParty'] = this.soldToParty;
    // data['shipToParty'] = this.shipToParty;

    if (this.siteCommentsEntity != null) {
      data['siteCommentsEntity'] =
          this.siteCommentsEntity.map((v) => v.toJson()).toList();
    }

    if (this.siteStageHistory != null) {
      data['siteStageHistorys'] =
          this.siteStageHistory.map((v) => v.toJson()).toList();
    }

    if (this.siteNextStageEntity != null) {
      data['siteNextStageEntity'] =
          this.siteNextStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.sitePhotosEntity != null) {
      data['sitePhotosEntity'] =
          this.sitePhotosEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteInfluencerEntity != null) {
      data['siteInfluencerEntity'] =
          this.siteInfluencerEntity.map((v) => v.toJson()).toList();
    }

    data['dealerConfirmedChangedBy']= this.dealerConfirmedChangedBy;
    data['dealerConfirmedChangedOn']= this.dealerConfirmedChangedOn;
    data['isDealerConfirmedChangedBySo']= this.isDealerConfirmedChangedBySo;
    data['subdealerId']= this.subdealerId;
    data['kitchenCount']= this.kitchenCount;
    data['bathroomCount']= this.bathroomCount;

    return data;
  }
}

class SitePhotosEntity {
  int id;
  int siteId;
  String photoName;
  String createdBy;

  SitePhotosEntity({this.id, this.siteId, this.photoName, this.createdBy});

  SitePhotosEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    photoName = json['photoName'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['photoName'] = this.photoName;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class SiteInfluencerEntityNew {
  int id;
  int siteId;
  int inflId;
  String isDelete;
  String createdBy;
  String isPrimary;

  SiteInfluencerEntityNew({
    this.isPrimary,
    this.id,
    this.siteId,
    this.inflId,
    this.isDelete,
    this.createdBy,
  });

  SiteInfluencerEntityNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    inflId = json['inflId'];
    isDelete = json['isDelete'];
    createdBy = json['createdBy'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['inflId'] = this.inflId;
    data['isDelete'] = this.isDelete;
    data['createdBy'] = this.createdBy;
    data['isPrimary'] = this.isPrimary;

    return data;
  }
}
