class ViewSiteDataResponse {
  String respCode;
  String respMsg;
  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity;
  List<SitephotosEntity> sitephotosEntity;
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
  List<SiteStageEntity> siteStageEntity;
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
        this.siteInfluencerEntity});

  ViewSiteDataResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
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
        this.noOfFloors});

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
        this.createdBy});

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
    isExpanded = false;
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

  InfluencerEntity(
      {this.id,
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
        this.createdOn
      });

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

  SiteInfluencerEntity(
      {this.id,
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
    return data;
  }


}