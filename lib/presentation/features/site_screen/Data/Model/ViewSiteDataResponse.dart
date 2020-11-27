class ViewSiteDataResponse {
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
  List<SiteInfluencerEntity> siteInfluencerEntity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;

  ViewSiteDataResponse(
      {this.respCode,
        this.respMsg,
        this.sitesModal,
        this.siteFloorsEntity,
        this.sitephotosEntity,
        this.siteVisitHistoryEntity,
        this.constructionStageEntity,
        this.siteProbabilityWinningEntity,
        this.siteCompetitionStatusEntity,
        this.siteBrandEntity,
        this.siteInfluencerEntity,
        this.siteOpportunityStatusEntity});

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
    if (json['siteInfluencerEntity'] != null) {
      siteInfluencerEntity = new List<SiteInfluencerEntity>();
      json['siteInfluencerEntity'].forEach((v) {
        siteInfluencerEntity.add(new SiteInfluencerEntity.fromJson(v));
      });
    }
    if (json['siteOpportunityStatusEntity'] != null) {
      siteOpportunityStatusEntity = new List<SiteOpportunityStatusEntity>();
      json['siteOpportunityStatusEntity'].forEach((v) {
        siteOpportunityStatusEntity
            .add(new SiteOpportunityStatusEntity.fromJson(v));
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
    if (this.siteInfluencerEntity != null) {
      data['siteInfluencerEntity'] =
          this.siteInfluencerEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteOpportunityStatusEntity != null) {
      data['siteOpportunityStatusEntity'] =
          this.siteOpportunityStatusEntity.map((v) => v.toJson()).toList();
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
  String siteGeotagLatitude;
  String siteGeotagLongitude;
  String siteGeotagType;
  String siteReraNumber;
  String siteDealerId;
  String siteDealerName;
  String siteSoId;
  String siteSoname;
  int siteStageId;
  Null inactiveReasonText;
  Null siteNextVisitDate;
  Null siteClosureReasonText;

  SitesModal(
      {this.siteBuiltArea,
        this.siteProductDemo,
        this.siteProductOralBriefing,
        this.sitePlotNumber,
        this.siteTotalSitePotential,
        this.siteOwnerName,
        this.siteOwnerContactNumber,
        this.siteAddress,
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
        this.siteClosureReasonText});

  SitesModal.fromJson(Map<String, dynamic> json) {
    siteBuiltArea = json['siteBuiltArea'];
    siteProductDemo = json['siteProductDemo'];
    siteProductOralBriefing = json['siteProductOralBriefing'];
    sitePlotNumber = json['sitePlotNumber'];
    siteTotalSitePotential = json['siteTotalSitePotential'];
    siteOwnerName = json['siteOwnerName'];
    siteOwnerContactNumber = json['siteOwnerContactNumber'];
    siteAddress = json['siteAddress'];
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
  int constructionDate;
  int siteId;
  int supplyDate;
  String supplyQty;
  String stageStatus;
  int createdOn;
  String createdBy;

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