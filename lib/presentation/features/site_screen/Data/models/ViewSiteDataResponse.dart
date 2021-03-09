import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';

class ViewSiteDataResponse {
 // List<SiteStageEntity> leadStatusEntity;
  List<SiteStageEntity> siteStageEntity;


  String respCode;
  String respMsg;
  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity;
  List<SitephotosEntity> sitephotosEntity;
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
  List<ConstructionStageEntity> constructionStageEntity;
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity;
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity;
  List<SiteBrandEntity> siteBrandEntity;
  List<InfluencerEntity> influencerEntity;
  List<SiteNextStageEntity> siteNextStageEntity;
  List<SiteCommentsEntity> siteCommentsEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;
  List<SiteInfluencerEntity> siteInfluencerEntity;
  List<CounterListModel> counterListModel;

  ViewSiteDataResponse(
      {this.respCode,
      this.respMsg,
      this.sitesModal,
      this.siteFloorsEntity,
      this.sitephotosEntity,
      this.siteVisitHistoryEntity,
      this.siteStageEntity,
      this.constructionStageEntity,
      this.siteProbabilityWinningEntity,
      this.siteCompetitionStatusEntity,
      this.siteBrandEntity,
      this.influencerEntity,
      this.siteNextStageEntity,
      this.siteCommentsEntity,
      this.influencerTypeEntity,
      this.influencerCategoryEntity,
      this.siteOpportunityStatusEntity,
      this.siteInfluencerEntity,
      this.counterListModel});

  //ViewSiteDataResponse.mapJson(Map<String, dynamic> json):


  ViewSiteDataResponse.fromJson(Map<String, dynamic> json) {
    // respCode = json['respCode'];
    // respMsg = json['respMsg'];
    sitesModal = json['sitesModal'] != null
        ? new SitesModal.fromJson(json['sitesModal'])
        : null;
    if (json['siteFloorsEntity'] != null) {
      siteFloorsEntity = new List<SiteFloorsEntity>();
      json['siteFloorsEntity'].forEach((v) {
        siteFloorsEntity.add(new SiteFloorsEntity.fromJson(v));
      });
    }
    if (json['sitephotosEntity'] != null) {
      sitephotosEntity = new List<SitephotosEntity>();
      json['sitephotosEntity'].forEach((v) {
        sitephotosEntity.add(new SitephotosEntity.fromJson(v));
      });
    }
    if (json['siteVisitHistoryEntity'] != null) {
      siteVisitHistoryEntity = new List<SiteVisitHistoryEntity>();
      json['siteVisitHistoryEntity'].forEach((v) {
        siteVisitHistoryEntity.add(new SiteVisitHistoryEntity.fromJson(v));
      });
    }
    if (json['siteStageEntity'] != null) {
      siteStageEntity = new List<SiteStageEntity>();
      json['siteStageEntity'].forEach((v) {
        siteStageEntity.add(new SiteStageEntity.fromJson(v));
      });
    }
    if (json['constructionStageEntity'] != null) {
      constructionStageEntity = new List<ConstructionStageEntity>();
      json['constructionStageEntity'].forEach((v) {
        constructionStageEntity.add(new ConstructionStageEntity.fromJson(v));
      });
    }
    if (json['siteProbabilityWinningEntity'] != null) {
      siteProbabilityWinningEntity = new List<SiteProbabilityWinningEntity>();
      json['siteProbabilityWinningEntity'].forEach((v) {
        siteProbabilityWinningEntity
            .add(new SiteProbabilityWinningEntity.fromJson(v));
      });
    }
    if (json['siteCompetitionStatusEntity'] != null) {
      siteCompetitionStatusEntity = new List<SiteCompetitionStatusEntity>();
      json['siteCompetitionStatusEntity'].forEach((v) {
        siteCompetitionStatusEntity
            .add(new SiteCompetitionStatusEntity.fromJson(v));
      });
    }
    if (json['siteBrandEntity'] != null) {
      siteBrandEntity = new List<SiteBrandEntity>();
      json['siteBrandEntity'].forEach((v) {
        siteBrandEntity.add(new SiteBrandEntity.fromJson(v));
      });
    }
    if (json['influencerEntity'] != null) {
      influencerEntity = new List<InfluencerEntity>();
      json['influencerEntity'].forEach((v) {
        influencerEntity.add(new InfluencerEntity.fromJson(v));
      });
    }
    if (json['siteNextStageEntity'] != null) {
      siteNextStageEntity = new List<SiteNextStageEntity>();
      json['siteNextStageEntity'].forEach((v) {
        siteNextStageEntity.add(new SiteNextStageEntity.fromJson(v));
      });
    }
    if (json['siteCommentsEntity'] != null) {
      siteCommentsEntity = new List<SiteCommentsEntity>();
      json['siteCommentsEntity'].forEach((v) {
        siteCommentsEntity.add(new SiteCommentsEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>();
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['siteOpportunityStatusEntity'] != null) {
      siteOpportunityStatusEntity = new List<SiteOpportunityStatusEntity>();
      json['siteOpportunityStatusEntity'].forEach((v) {
        siteOpportunityStatusEntity
            .add(new SiteOpportunityStatusEntity.fromJson(v));
      });
    }
    if (json['siteInfluencerEntity'] != null) {
      siteInfluencerEntity = new List<SiteInfluencerEntity>();
      json['siteInfluencerEntity'].forEach((v) {
        siteInfluencerEntity.add(new SiteInfluencerEntity.fromJson(v));
      });
    }

    if (json['counterListModel'] != null) {
      counterListModel = new List<CounterListModel>();
      json['counterListModel'].forEach((v) {
        counterListModel.add(new CounterListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.sitesModal != null) {
      data['sitesModal'] = this.sitesModal.toJson();
    }
    if (this.siteFloorsEntity != null) {
      data['siteFloorsEntity'] =
          this.siteFloorsEntity.map((v) => v.toJson()).toList();
    }
    if (this.sitephotosEntity != null) {
      data['sitephotosEntity'] =
          this.sitephotosEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteVisitHistoryEntity != null) {
      data['siteVisitHistoryEntity'] =
          this.siteVisitHistoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteStageEntity != null) {
      data['siteStageEntity'] =
          this.siteStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.constructionStageEntity != null) {
      data['constructionStageEntity'] =
          this.constructionStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteProbabilityWinningEntity != null) {
      data['siteProbabilityWinningEntity'] =
          this.siteProbabilityWinningEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteCompetitionStatusEntity != null) {
      data['siteCompetitionStatusEntity'] =
          this.siteCompetitionStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteBrandEntity != null) {
      data['siteBrandEntity'] =
          this.siteBrandEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerEntity != null) {
      data['influencerEntity'] =
          this.influencerEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteNextStageEntity != null) {
      data['siteNextStageEntity'] =
          this.siteNextStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteCommentsEntity != null) {
      data['siteCommentsEntity'] =
          this.siteCommentsEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerTypeEntity != null) {
      data['influencerTypeEntity'] =
          this.influencerTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteOpportunityStatusEntity != null) {
      data['siteOpportunityStatusEntity'] =
          this.siteOpportunityStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteInfluencerEntity != null) {
      data['siteInfluencerEntity'] =
          this.siteInfluencerEntity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SitesModal {
  String siteBuiltArea;
  String siteProductDemo;
  String siteProductOralBriefing;
  String sitePlotNumber;
  String siteTotalSitePotential;
  String siteOwnerName;
  String siteOwnerContactNumber;
  String siteAddress;
  String siteState;
  String siteDistrict;
  String siteTaluk;
  String sitePincode;
  String siteGeotagLatitude;
  String siteGeotagLongitude;
  String siteGeotagType;
  String siteReraNumber;
  String siteDealerId;
  String siteDealerName;
  String siteSoId;
  String siteSoname;
  int siteStageId;
  String inactiveReasonText;
  String siteNextVisitDate;
  String siteClosureReasonText;
  int siteProbabilityWinningId;
  int siteCompetitionId;
  int siteOppertunityId;
  String assignedTo;
  int siteStatusId;
  String siteCreationDate;
  int siteConstructionId;
  int noOfFloors;
  double siteScore;

  SitesModal(
      {this.siteBuiltArea,
      this.siteProductDemo,
      this.siteProductOralBriefing,
      this.sitePlotNumber,
      this.siteTotalSitePotential,
      this.siteOwnerName,
      this.siteOwnerContactNumber,
      this.siteAddress,
      this.siteState,
      this.siteDistrict,
      this.siteTaluk,
      this.sitePincode,
      this.siteGeotagLatitude,
      this.siteGeotagLongitude,
      this.siteGeotagType,
      this.siteReraNumber,
      this.siteDealerId,
      this.siteDealerName,
      this.siteSoId,
      this.siteSoname,
      this.siteStageId,
      this.inactiveReasonText,
      this.siteNextVisitDate,
      this.siteClosureReasonText,
      this.siteProbabilityWinningId,
      this.siteCompetitionId,
      this.siteOppertunityId,
      this.assignedTo,
      this.siteStatusId,
      this.siteCreationDate,
      this.siteConstructionId,
      this.noOfFloors,
      this.siteScore});

  SitesModal.fromJson(Map<String, dynamic> json) {
    siteBuiltArea = json['siteBuiltArea'];
    siteProductDemo = json['siteProductDemo'];
    siteProductOralBriefing = json['siteProductOralBriefing'];
    sitePlotNumber = json['sitePlotNumber'];
    siteTotalSitePotential = json['siteTotalSitePotential'];
    siteOwnerName = json['siteOwnerName'];
    siteOwnerContactNumber = json['siteOwnerContactNumber'];
    siteAddress = json['siteAddress'];
    siteState = json['siteState'];
    siteDistrict = json['siteDistrict'];
    siteTaluk = json['siteTaluk'];
    sitePincode = json['sitePincode'];
    siteGeotagLatitude = json['siteGeotag_latitude'];
    siteGeotagLongitude = json['siteGeotag_longitude'];
    siteGeotagType = json['siteGeotag_type'];
    siteReraNumber = json['siteRera_number'];
    siteDealerId = json['siteDealerId'];
    siteDealerName = json['siteDealerName'];
    siteSoId = json['siteSoId'];
    siteSoname = json['siteSoname'];
    siteStageId = json['siteStageId'];
    inactiveReasonText = json['inactiveReasonText'];
    siteNextVisitDate = json['siteNextVisitDate'];
    siteClosureReasonText = json['siteClosureReasonText'];
    siteProbabilityWinningId = json['siteProbabilityWinningId'];
    siteCompetitionId = json['siteCompetitionId'];
    siteOppertunityId = json['siteOppertunityId'];
    assignedTo = json['assignedTo'];
    siteStatusId = json['siteStatusId'];
    siteCreationDate = json['siteCreationDate'];
    siteConstructionId = json['siteConstructionId'];
    noOfFloors = json['noOfFloors'];
    siteScore = json['siteScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteBuiltArea'] = this.siteBuiltArea;
    data['siteProductDemo'] = this.siteProductDemo;
    data['siteProductOralBriefing'] = this.siteProductOralBriefing;
    data['sitePlotNumber'] = this.sitePlotNumber;
    data['siteTotalSitePotential'] = this.siteTotalSitePotential;
    data['siteOwnerName'] = this.siteOwnerName;
    data['siteOwnerContactNumber'] = this.siteOwnerContactNumber;
    data['siteAddress'] = this.siteAddress;
    data['siteState'] = this.siteState;
    data['siteDistrict'] = this.siteDistrict;
    data['siteTaluk'] = this.siteTaluk;
    data['sitePincode'] = this.sitePincode;
    data['siteGeotag_latitude'] = this.siteGeotagLatitude;
    data['siteGeotag_longitude'] = this.siteGeotagLongitude;
    data['siteGeotag_type'] = this.siteGeotagType;
    data['siteRera_number'] = this.siteReraNumber;
    data['siteDealerId'] = this.siteDealerId;
    data['siteDealerName'] = this.siteDealerName;
    data['siteSoId'] = this.siteSoId;
    data['siteSoname'] = this.siteSoname;
    data['siteStageId'] = this.siteStageId;
    data['inactiveReasonText'] = this.inactiveReasonText;
    data['siteNextVisitDate'] = this.siteNextVisitDate;
    data['siteClosureReasonText'] = this.siteClosureReasonText;
    data['siteProbabilityWinningId'] = this.siteProbabilityWinningId;
    data['siteCompetitionId'] = this.siteCompetitionId;
    data['siteOppertunityId'] = this.siteOppertunityId;
    data['assignedTo'] = this.assignedTo;
    data['siteStatusId'] = this.siteStatusId;
    data['siteCreationDate'] = this.siteCreationDate;
    data['siteConstructionId'] = this.siteConstructionId;
    data['noOfFloors'] = this.noOfFloors;
    data['siteScore'] = this.siteScore;

    return data;
  }
}

class SiteFloorsEntity {
  int id;
  String siteFloorTxt;

  SiteFloorsEntity({this.id, this.siteFloorTxt});

  SiteFloorsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteFloorTxt = json['siteFloorTxt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteFloorTxt'] = this.siteFloorTxt;
    return data;
  }
}

class SitephotosEntity {
  int id;
  int siteId;
  String photoName;
  String createdBy;
  int createdOn;

  SitephotosEntity(
      {this.id, this.siteId, this.photoName, this.createdBy, this.createdOn});

  SitephotosEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    photoName = json['photoName'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['photoName'] = this.photoName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

// class SiteVisitHistoryEntity {
//   int id;
//   String totalBalancePotential;
//   // String constructionStageId;
//   String floorId;
//   String stagePotential;
//   // String brandId;
//   String brandPrice;
//   String constructionDate;
//   String siteId;
//   String supplyDate;
//   String supplyQty;
//   String stageStatus;
//   String createdBy;
//   String soldToParty;
//   String shipToParty;
//
//   //Check about the presence of below two variables
//   int constructionStageId;
//   int brandId;
//   int createdOn;
//   bool isExpanded;
//
//
//
//   SiteVisitHistoryEntity(
//       {this.id,
//       this.totalBalancePotential,
//       this.constructionStageId,
//       this.floorId,
//       this.stagePotential,
//       this.brandId,
//       this.brandPrice,
//       this.constructionDate,
//       this.siteId,
//       this.supplyDate,
//       this.supplyQty,
//       this.stageStatus,
//       this.createdOn,
//       this.createdBy,
//       this.soldToParty,
//       this.shipToParty});
//
//   SiteVisitHistoryEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     totalBalancePotential = json['totalBalancePotential'];
//     constructionStageId = json['constructionStageId'];
//     floorId = json['floorId'];
//     stagePotential = json['stagePotential'];
//     brandId = json['brandId'];
//     brandPrice = json['brandPrice'];
//     constructionDate = json['constructionDate'];
//     siteId = json['siteId'];
//     supplyDate = json['supplyDate'];
//     supplyQty = json['supplyQty'];
//     stageStatus = json['stageStatus'];
//     createdOn = json['createdOn'];
//     createdBy = json['createdBy'];
//     isExpanded = false;
//
//     soldToParty = json['soldToParty'];
//     shipToParty = json['shipToParty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['totalBalancePotential'] = this.totalBalancePotential;
//     data['constructionStageId'] = this.constructionStageId;
//     data['floorId'] = this.floorId;
//     data['stagePotential'] = this.stagePotential;
//     data['brandId'] = this.brandId;
//     data['brandPrice'] = this.brandPrice;
//     data['constructionDate'] = this.constructionDate;
//     data['siteId'] = this.siteId;
//     data['supplyDate'] = this.supplyDate;
//     data['supplyQty'] = this.supplyQty;
//     data['stageStatus'] = this.stageStatus;
//     data['createdOn'] = this.createdOn;
//     data['createdBy'] = this.createdBy;
//
//     data['soldToParty'] = this.soldToParty;
//     data['shipToParty'] = this.shipToParty;
//     return data;
//   }
// }

class SiteVisitHistoryEntity {
  int id;
  String totalBalancePotential;
  int constructionStageId;
  int floorId;
  String stagePotential;
  int brandId;
  String brandPrice;
  String constructionDate;
  int siteId;
  String supplyDate;
  String supplyQty;
  String stageStatus;
  int createdOn;
  String createdBy;
  String soldToParty;
  String shipToParty;
  String soCode;
  String isAuthorised;
  String receiptNumber;
  bool isExpanded;

  SiteVisitHistoryEntity(
      {this.id,
        this.totalBalancePotential,
        this.constructionStageId,
        this.floorId,
        this.stagePotential,
        this.brandId,
        this.brandPrice,
        this.constructionDate,
        this.siteId,
        this.supplyDate,
        this.supplyQty,
        this.stageStatus,
        this.createdOn,
        this.createdBy,
        this.soldToParty,
        this.shipToParty,
        this.soCode,
        this.isAuthorised,
        this.receiptNumber});

  SiteVisitHistoryEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalBalancePotential = json['totalBalancePotential'];
    constructionStageId = json['constructionStageId'];
    floorId = json['floorId'];
    stagePotential = json['stagePotential'];
    brandId = json['brandId'];
    brandPrice = json['brandPrice'];
    constructionDate = json['constructionDate'];
    siteId = json['siteId'];
    supplyDate = json['supplyDate'];
    supplyQty = json['supplyQty'];
    stageStatus = json['stageStatus'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    soldToParty = json['soldToParty'];
    shipToParty = json['shipToParty'];
    soCode = json['soCode'];
    isAuthorised = json['isAuthorised'];
    isExpanded = false;
    receiptNumber = json['receiptNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalBalancePotential'] = this.totalBalancePotential;
    data['constructionStageId'] = this.constructionStageId;
    data['floorId'] = this.floorId;
    data['stagePotential'] = this.stagePotential;
    data['brandId'] = this.brandId;
    data['brandPrice'] = this.brandPrice;
    data['constructionDate'] = this.constructionDate;
    data['siteId'] = this.siteId;
    data['supplyDate'] = this.supplyDate;
    data['supplyQty'] = this.supplyQty;
    data['stageStatus'] = this.stageStatus;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['soldToParty'] = this.soldToParty;
    data['shipToParty'] = this.shipToParty;
    data['soCode'] = this.soCode;
    data['isAuthorised'] = this.isAuthorised;
    data['receiptNumber'] = this.receiptNumber;
    return data;
  }
}

class SiteStageEntity {
  int id;
  String siteStageDesc;

  SiteStageEntity({this.id, this.siteStageDesc});

  SiteStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteStageDesc = json['siteStageDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteStageDesc'] = this.siteStageDesc;
    return data;
  }
}

class ConstructionStageEntity {
  int id;
  String constructionStageText;

  ConstructionStageEntity({this.id, this.constructionStageText});

  ConstructionStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    constructionStageText = json['constructionStageText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['constructionStageText'] = this.constructionStageText;
    return data;
  }
}

class SiteProbabilityWinningEntity {
  int id;
  String siteProbabilityStatus;

  SiteProbabilityWinningEntity({this.id, this.siteProbabilityStatus});

  SiteProbabilityWinningEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteProbabilityStatus = json['siteProbabilityStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteProbabilityStatus'] = this.siteProbabilityStatus;
    return data;
  }
}

class SiteCompetitionStatusEntity {
  int id;
  String competitionStatus;

  SiteCompetitionStatusEntity({this.id, this.competitionStatus});

  SiteCompetitionStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    competitionStatus = json['competitionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['competitionStatus'] = this.competitionStatus;
    return data;
  }
}

class SiteBrandEntity {
  int id;
  String brandName;
  String productName;

  SiteBrandEntity({this.id, this.brandName, this.productName});

  SiteBrandEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    data['productName'] = this.productName;
    return data;
  }
}

class InfluencerEntity {
  int id;
  String inflName;
  String inflContact;
  int inflTypeId;
  int inflCatId;
  String ilpIntrested;
  int createdOn;
  String isPrimary;
  bool isPrimarybool;
  int originalId;

  InfluencerEntity(
      {this.isPrimarybool,
      this.isPrimary,
      this.originalId,
      this.id,
      this.inflName,
      this.inflContact,
      this.inflTypeId,
      this.inflCatId,
      this.ilpIntrested,
      this.createdOn});

  InfluencerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inflName = json['inflName'];
    inflContact = json['inflContact'];
    inflTypeId = json['inflTypeId'];
    inflCatId = json['inflCatId'];
    ilpIntrested = json['ilpIntrested'];
    createdOn = json['createdOn'];
    isPrimarybool = json['isPrimarybool'];
    isPrimary = json['isPrimary'];
    originalId = json['originalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inflName'] = this.inflName;
    data['inflContact'] = this.inflContact;
    data['inflTypeId'] = this.inflTypeId;
    data['inflCatId'] = this.inflCatId;
    data['ilpIntrested'] = this.ilpIntrested;
    data['createdOn'] = this.createdOn;
    data['isPrimarybool'] = this.isPrimarybool;
    data['isPrimary'] = this.isPrimary;
    data['originalId'] = this.originalId;
    return data;
  }
}

class SiteNextStageEntity {
  int id;
  int siteId;
  int constructionStageId;
  String stagePotential;
  int brandId;
  String brandPrice;
  String stageStatus;
  String constructionStartDt;
  String nextStageSupplyDate;
  String nextStageSupplyQty;
  String createdBy;
  int createdOn;

  SiteNextStageEntity(
      {this.id,
      this.siteId,
      this.constructionStageId,
      this.stagePotential,
      this.brandId,
      this.brandPrice,
      this.stageStatus,
      this.constructionStartDt,
      this.nextStageSupplyDate,
      this.nextStageSupplyQty,
      this.createdBy,
      this.createdOn});

  SiteNextStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    constructionStageId = json['constructionStageId'];
    stagePotential = json['stagePotential'];
    brandId = json['brandId'];
    brandPrice = json['brandPrice'];
    stageStatus = json['stageStatus'];
    constructionStartDt = json['constructionStartDt'];
    nextStageSupplyDate = json['nextStageSupplyDate'];
    nextStageSupplyQty = json['nextStageSupplyQty'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['constructionStageId'] = this.constructionStageId;
    data['stagePotential'] = this.stagePotential;
    data['brandId'] = this.brandId;
    data['brandPrice'] = this.brandPrice;
    data['stageStatus'] = this.stageStatus;
    data['constructionStartDt'] = this.constructionStartDt;
    data['nextStageSupplyDate'] = this.nextStageSupplyDate;
    data['nextStageSupplyQty'] = this.nextStageSupplyQty;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

class SiteCommentsEntity {
  int id;
  int siteId;
  String siteCommentText;
  String creatorName;
  String createdBy;
  int createdOn;

  SiteCommentsEntity(
      {this.id,
      this.siteId,
      this.siteCommentText,
      this.creatorName,
      this.createdBy,
      this.createdOn});

  SiteCommentsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    siteCommentText = json['siteCommentText'];
    creatorName = json['creatorName'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['siteCommentText'] = this.siteCommentText;
    data['creatorName'] = this.creatorName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

class InfluencerTypeEntity {
  int inflTypeId;
  String inflTypeDesc;

  InfluencerTypeEntity({this.inflTypeId, this.inflTypeDesc});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntity {
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryEntity({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
    inflCatId = json['inflCatId'];
    inflCatDesc = json['inflCatDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflCatId'] = this.inflCatId;
    data['inflCatDesc'] = this.inflCatDesc;
    return data;
  }
}

class SiteOpportunityStatusEntity {
  int id;
  String opportunityStatus;

  SiteOpportunityStatusEntity({this.id, this.opportunityStatus});

  SiteOpportunityStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opportunityStatus = json['opportunityStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['opportunityStatus'] = this.opportunityStatus;
    return data;
  }
}

class SiteInfluencerEntity {
  int id;
  int siteId;
  int inflId;
  String isDelete;
  String createdBy;
  int createdOn;
  Null updatedBy;
  Null updatedOn;
  String isPrimary;

  SiteInfluencerEntity(
      {this.isPrimary,
      this.id,
      this.siteId,
      this.inflId,
      this.isDelete,
      this.createdBy,
      this.createdOn,
      this.updatedBy,
      this.updatedOn});

  SiteInfluencerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    inflId = json['inflId'];
    isDelete = json['isDelete'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteId'] = this.siteId;
    data['inflId'] = this.inflId;
    data['isDelete'] = this.isDelete;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    data['isPrimary'] = this.isPrimary;

    return data;
  }

}

class CounterListModel {
  String soldToParty;
  String soldToPartyName;
  String shipToParty;
  String shipToPartyName;

  CounterListModel(
      {this.soldToParty,
        this.soldToPartyName,
        this.shipToParty,
        this.shipToPartyName});

  CounterListModel.fromJson(Map<String, dynamic> json) {
    soldToParty = json['soldToParty'];
    soldToPartyName = json['soldToPartyName'];
    shipToParty = json['shipToParty'];
    shipToPartyName = json['shipToPartyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soldToParty'] = this.soldToParty;
    data['soldToPartyName'] = this.soldToPartyName;
    data['shipToParty'] = this.shipToParty;
    data['shipToPartyName'] = this.shipToPartyName;
    return data;
  }
}






/*Create new response model for fetch master table data from site refresh api*/
class ViewSiteRefreshDataResponse{
  String respCode;
  String respMsg;
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadStageEntity> leadStageEntity;
  List<SiteStatusEntity> siteStatusEntity;
  List<SiteStageEntity> siteStageEntity;
  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<SrComplainResolutionEntity> srComplainResolutionEntity;
  List<SrComplaintTypeEntity> srComplaintTypeEntity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity;
  List<SrctRequestEntity> srctRequestEntity;
  List<EmployeeDetails> employeeDetails;

  ViewSiteRefreshDataResponse({this.respCode, this.respMsg, this.leadStageEntity, this.leadStatusEntity, this.siteStageEntity, this.siteStatusEntity,
  this.siteSubTypeEntity, this.influencerCategoryEntity, this. srComplainResolutionEntity, this.srComplaintTypeEntity, this.siteOpportunityStatusEntity, this.siteProbabilityWinningEntity,
    this.srctRequestEntity, this.employeeDetails
  });


  ViewSiteRefreshDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>();
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity.add(new LeadStatusEntity.fromJson(v));
      });
    }

    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>();
      json['leadStageEntity'].forEach((v) {
        leadStageEntity.add(new LeadStageEntity.fromJson(v));
      });
    }

    if (json['siteStatusEntity'] != null) {
      siteStatusEntity = new List<SiteStatusEntity>();
      json['siteStatusEntity'].forEach((v) {
        siteStatusEntity.add(new SiteStatusEntity.fromJson(v));
      });
    }
 if (json['siteStageEntity'] != null) {
   siteStageEntity = new List<SiteStageEntity>();
      json['siteStageEntity'].forEach((v) {
        siteStageEntity.add(new SiteStageEntity.fromJson(v));
      });
    }

    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>();
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }


    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }


    if (json['srComplainResolutionEntity'] != null) {
      srComplainResolutionEntity = new List<SrComplainResolutionEntity>();
      json['srComplainResolutionEntity'].forEach((v) {
        srComplainResolutionEntity.add(new SrComplainResolutionEntity.fromJson(v));
      });
    }


    if (json['srComplaintTypeEntity'] != null) {
      srComplaintTypeEntity = new List<SrComplaintTypeEntity>();
      json['srComplaintTypeEntity'].forEach((v) {
        srComplaintTypeEntity.add(new SrComplaintTypeEntity.fromJson(v));
      });
    }


    if (json['siteOpportunityStatusEntity'] != null) {
      siteOpportunityStatusEntity = new List<SiteOpportunityStatusEntity>();
      json['siteOpportunityStatusEntity'].forEach((v) {
        siteOpportunityStatusEntity.add(new SiteOpportunityStatusEntity.fromJson(v));
      });
    }


    if (json['siteProbabilityWinningEntity'] != null) {
      siteProbabilityWinningEntity = new List<SiteProbabilityWinningEntity>();
      json['siteProbabilityWinningEntity'].forEach((v) {
        siteProbabilityWinningEntity.add(new SiteProbabilityWinningEntity.fromJson(v));
      });
    }

    if (json['srctRequestEntity'] != null) {
      srctRequestEntity = new List<SrctRequestEntity>();
      json['srctRequestEntity'].forEach((v) {
        srctRequestEntity.add(new SrctRequestEntity.fromJson(v));
      });
    }

    if (json['employeeDetails'] != null) {
      employeeDetails = new List<EmployeeDetails>();
      json['employeeDetails'].forEach((v) {
        employeeDetails.add(new EmployeeDetails.fromJson(v));
      });
    }



  }


}

class LeadStatusEntity{
  int id;
  String leadStatusDesc;
  LeadStatusEntity({this.id, this.leadStatusDesc});
  LeadStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStatusDesc = json["leadStatusDesc"];
  }

}

class LeadStageEntity{
  int id;
  String leadStageDesc;

  LeadStageEntity({this.id, this.leadStageDesc});

  LeadStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStageDesc = json["leadStageDesc"];
  }

}


class SiteStatusEntity{
  int id;
  String siteStatusDesc;

  SiteStatusEntity({this.id, this.siteStatusDesc});

  SiteStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteStatusDesc = json["siteStatusDesc"];
  }

}

class SiteSubTypeEntity{
  int siteSubId;
  String siteSubTypeDesc;

  SiteSubTypeEntity({this.siteSubId, this.siteSubTypeDesc});

  SiteSubTypeEntity.fromJson(Map<String, dynamic> json) {
    siteSubId = json['siteSubId'];
    siteSubTypeDesc = json["siteSubTypeDesc"];
  }

}

class SrComplainResolutionEntity{
  int id;
  String resolutionText;

  SrComplainResolutionEntity({this.id, this.resolutionText});

  SrComplainResolutionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resolutionText = json["resolutionText"];
  }


}

class SrComplaintTypeEntity{
  int id;
  String requestId;
  String serviceRequestTypeText;
  String complaintSeverity;

  SrComplaintTypeEntity({this.id, this.requestId, this.serviceRequestTypeText, this.complaintSeverity});

  SrComplaintTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json["requestId"];
    serviceRequestTypeText = json["serviceRequestTypeText"];
    complaintSeverity = json["complaintSeverity"];
  }


}


class SrctRequestEntity{
  int id;
  String requestText;


  SrctRequestEntity({this.id, this.requestText});

  SrctRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestText = json["requestText"];

  }


}

class Severity{
  int id;
  String severity;


  Severity({this.id, this.severity});

  Severity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json["severity"];

  }


}

class EmployeeDetails{
  String referenceId;
  String mobileNumber;
  String employeeFirstName;
  String employeeName;


  EmployeeDetails({this.referenceId, this.mobileNumber, this.employeeFirstName, this.employeeName});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference-id'];
    mobileNumber = json["mobile-number"];
    employeeFirstName = json["employee-first-name"];
    employeeName = json["employee-name"];

  }


}


class UserMenu{
  String menuId;
  String menuText;

  UserMenu({this.menuId, this.menuText});
  UserMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['menu-id'];
    menuText = json["menu-text"];
  }

}

class JourneyDetails{
  String journeyDate;
  String journeyStartTime;
  String journeyStartLat;
  String journeyStartLong;
  String journeyEndTime;
  String journeyEndLat;
  String journeyEndLong;
  String employeeId;

  JourneyDetails({this.journeyDate, this.journeyStartTime, this.journeyStartLat,
    this.journeyStartLong, this.journeyEndTime, this.journeyEndLat, this.journeyEndLong, this.employeeId});
  JourneyDetails.fromJson(Map<String, dynamic> json) {
    journeyDate = json['journey-date'];
    journeyStartTime = json['journey-start-time'];
    journeyStartLat = json["journey-start-lat"];
    journeyStartLong = json["journey-start-long"];
    journeyEndTime = json["journey-end-time"];
    journeyEndLat = json["journey-end-lat"];
    journeyEndLong = json["journey-end-long"];
    employeeId = json["employee-id"];
  }

}
//user-security-key



