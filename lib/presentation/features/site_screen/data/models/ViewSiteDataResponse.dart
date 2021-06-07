import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';

class ViewSiteDataResponse {
  String respCode;
  String respMsg;
  SitesModal sitesModal;
  MwpVisitModel mwpVisitModel;
  List<SiteFloorsEntity> siteFloorsEntity;
  List<SitephotosEntity> sitephotosEntity;
 // List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
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
  List<CounterListModel> counterListModel;






  ViewSiteDataResponse(
      {this.respCode,
      this.respMsg,
      this.sitesModal,
        this.mwpVisitModel,
      this.siteFloorsEntity,
      this.sitephotosEntity,
     // this.siteVisitHistoryEntity,
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

  ViewSiteDataResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    sitesModal = json['sitesModal'] != null
        ? new SitesModal.fromJson(json['sitesModal'])
        : null;
    mwpVisitModel = json['mwpVisitModel'] != null
        ? new MwpVisitModel.fromJson(json['mwpVisitModel'])
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
    // if (json['siteVisitHistoryEntity'] != null) {
    //   siteVisitHistoryEntity = new List<SiteVisitHistoryEntity>();
    //   json['siteVisitHistoryEntity'].forEach((v) {
    //     siteVisitHistoryEntity.add(new SiteVisitHistoryEntity.fromJson(v));
    //   });
    // }
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
        siteProbabilityWinningEntity.add(new SiteProbabilityWinningEntity.fromJson(v));
      });
    }
    if (json['siteCompetitionStatusEntity'] != null) {
      siteCompetitionStatusEntity = new List<SiteCompetitionStatusEntity>();
      json['siteCompetitionStatusEntity'].forEach((v) {
        siteCompetitionStatusEntity.add(new SiteCompetitionStatusEntity.fromJson(v));
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
        siteOpportunityStatusEntity.add(new SiteOpportunityStatusEntity.fromJson(v));
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
    if (this.mwpVisitModel != null) {
      data['mwpVisitModel'] = this.mwpVisitModel.toJson();
    }
    if (this.siteFloorsEntity != null) {
      data['siteFloorsEntity'] =
          this.siteFloorsEntity.map((v) => v.toJson()).toList();
    }
    if (this.sitephotosEntity != null) {
      data['sitephotosEntity'] =
          this.sitephotosEntity.map((v) => v.toJson()).toList();
    }
    // if (this.siteVisitHistoryEntity != null) {
    //   data['siteVisitHistoryEntity'] =
    //       this.siteVisitHistoryEntity.map((v) => v.toJson()).toList();
    // }
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
  String createdOn;
   double leadId;
   int siteId;
   String siteSegment;
   String updatedBy;
  String updatedOn;
  String dealerConfirmedChangedBy;
  String dealerConfirmedChangedOn;
  String isDealerConfirmedChangedBySo;
  String subdealerId;
  String siteSubDealerName;

  String totalBalancePotential;

  SitesModal(
      {this.assignedTo,
        this.createdOn,
        this.dealerConfirmedChangedBy,
        this.dealerConfirmedChangedOn,
        this.inactiveReasonText,
        this.leadId,
        this.noOfFloors,
        this.siteAddress,
        this.siteBuiltArea,
        this.siteClosureReasonText,
        this.siteCompetitionId,
        this.siteConstructionId,
        this.siteCreationDate,
        this.siteDealerId,
        this.siteDealerName,
         this.siteSubDealerName,
        this.siteDistrict,
        this.siteGeotagLatitude,
        this.siteGeotagLongitude,
        this.siteGeotagType,
        this.siteId,
        this.siteNextVisitDate,
        this.siteOppertunityId,
        this.siteOwnerContactNumber,
        this.siteOwnerName,
        this.sitePincode,
        this.sitePlotNumber,
        this.siteProbabilityWinningId,
        this.siteProductDemo,
        this.siteProductOralBriefing,
        this.siteReraNumber,
        this.siteScore,
        this.siteSegment,
        this.siteSoId,
        this.siteSoname,
        this.siteStageId,
        this.siteState,
        this.siteStatusId,
        this.siteTaluk,
        this.siteTotalSitePotential,
        this.updatedBy,
        this.updatedOn,
        this.isDealerConfirmedChangedBySo,
        this.subdealerId,
        this.totalBalancePotential
      });

  SitesModal.fromJson(Map<String, dynamic> json) {
    assignedTo = json['assignedTo'].toString() ?? "";
    createdOn = json['createdOn'].toString() ?? "";
    dealerConfirmedChangedBy = json['dealerConfirmedChangedBy'].toString() ?? "";
    dealerConfirmedChangedOn = json['dealerConfirmedChangedOn'].toString()??"";
    inactiveReasonText = json['inactiveReasonText'].toString() ?? "";
    leadId = json['leadId'];
    noOfFloors = json['noOfFloors'];
    siteAddress = json['siteAddress'].toString() ?? "";
    siteBuiltArea = json['siteBuiltArea'];
    siteClosureReasonText = json['siteClosureReasonText'].toString() ?? "";
    siteCompetitionId = json['siteCompetitionId'];
    siteConstructionId = json['siteConstructionId'];
    siteCreationDate = json['siteCreationDate'].toString() ?? "";
    siteDealerId = json['siteDealerId'].toString() ?? "";
    siteDealerName = json['siteDealerName'].toString() ?? "";
    siteDistrict = json['siteDistrict'].toString() ?? "";
    siteGeotagLatitude = json['siteGeotag_latitude'].toString() ?? "";
    siteGeotagLongitude = json['siteGeotag_longitude'].toString() ?? "";
    siteGeotagType = json['siteGeotag_type'].toString() ?? "";
    siteId = json['siteId'];
    siteNextVisitDate = json['siteNextVisitDate'].toString() ?? "";
    siteOppertunityId = json['siteOppertunityId'];
    siteOwnerContactNumber = json['siteOwnerContactNumber'].toString() ?? "";
    siteOwnerName = json['siteOwnerName'].toString() ?? "";
    sitePincode = json['sitePincode'];
    sitePlotNumber = json['sitePlotNumber'];
    siteProbabilityWinningId = json['siteProbabilityWinningId'];
    siteProductDemo = json['siteProductDemo'];
    siteProductOralBriefing = json['siteProductOralBriefing'].toString() ?? "";
    siteReraNumber = json['siteRera_number'].toString() ?? "";
    siteScore = json['siteScore'];
    siteSegment = json['siteSegment'].toString() ?? "";
    siteSoId = json['siteSoId'].toString() ?? "";
    siteSoname = json['siteSoname'].toString() ?? "";
    siteStageId = json['siteStageId'];
    siteState = json['siteState'];
    siteStatusId = json['siteStatusId'];
    siteTaluk = json['siteTaluk'];
    siteTotalSitePotential = json['siteTotalSitePotential'];
    updatedBy = json['updatedBy'].toString() ?? "";
    updatedOn = json['updatedOn'].toString() ?? "";
    isDealerConfirmedChangedBySo = json['isDealerConfirmedChangedBySo'].toString() ?? "";
    subdealerId = json['subdealerId'].toString() ?? "";
    siteSubDealerName = json['siteSubDealerName'].toString() ?? "";

    totalBalancePotential = json['totalBalancePotential']!=null? json['totalBalancePotential'].toString():"";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedTo'] = this.assignedTo;
    data['createdOn'] = this.createdOn;
    data['dealerConfirmedChangedBy'] = this.dealerConfirmedChangedBy;
    data['dealerConfirmedChangedOn'] = this.dealerConfirmedChangedOn;
    data['inactiveReasonText'] = this.inactiveReasonText;
    data['leadId'] = this.leadId;
    data['noOfFloors'] = this.noOfFloors;
    data['siteAddress'] = this.siteAddress;
    data['siteBuiltArea'] = this.siteBuiltArea;
    data['siteClosureReasonText'] = this.siteClosureReasonText;
    data['siteCompetitionId'] = this.siteCompetitionId;
    data['siteConstructionId'] = this.siteConstructionId;
    data['siteCreationDate'] = this.siteCreationDate;
    data['siteDealerId'] = this.siteDealerId;
    data['siteDealerName'] = this.siteDealerName;
    data['siteDistrict'] = this.siteDistrict;
    data['siteGeotag_latitude'] = this.siteGeotagLatitude;
    data['siteGeotag_longitude'] = this.siteGeotagLongitude;
    data['siteGeotag_type'] = this.siteGeotagType;
    data['siteId'] = this.siteId;
    data['siteNextVisitDate'] = this.siteNextVisitDate;
    data['siteOppertunityId'] = this.siteOppertunityId;
    data['siteOwnerContactNumber'] = this.siteOwnerContactNumber;
    data['siteOwnerName'] = this.siteOwnerName;
    data['sitePincode'] = this.sitePincode;
    data['sitePlotNumber'] = this.sitePlotNumber;
    data['siteProbabilityWinningId'] = this.siteProbabilityWinningId;
    data['siteProductDemo'] = this.siteProductDemo;
    data['siteProductOralBriefing'] = this.siteProductOralBriefing;
    data['siteRera_number'] = this.siteReraNumber;
    data['siteScore'] = this.siteScore;
    data['siteSegment'] = this.siteSegment;
    data['siteSoId'] = this.siteSoId;
    data['siteSoname'] = this.siteSoname;
    data['siteStageId'] = this.siteStageId;
    data['siteState'] = this.siteState;
    data['siteStatusId'] = this.siteStatusId;
    data['siteTaluk'] = this.siteTaluk;
    data['siteTotalSitePotential'] = this.siteTotalSitePotential;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    data['isDealerConfirmedChangedBySo'] = this.isDealerConfirmedChangedBySo;
    data['subdealerId'] = this.subdealerId;
    data['siteSubDealerName'] = this.siteSubDealerName;
    data['totalBalancePotential'] = this.totalBalancePotential;
    return data;
  }
}

class MwpVisitModel {
  int id;
  String visitSubType;
  int docId;
  String visitDate;
  String visitType;
  String visitStartTime;
  String visitStartLat;
  String visitStartLong;
  String visitEndTime;
  String visitEndLat;
  String visitEndLong;
  int nextVisitDate;
  String visitOutcomes;
  String remark;
  String inflName;

  MwpVisitModel(
      {this.id,
        this.visitSubType,
        this.docId,
        this.visitDate,
        this.visitType,
        this.visitStartTime,
        this.visitStartLat,
        this.visitStartLong,
        this.visitEndTime,
        this.visitEndLat,
        this.visitEndLong,
        this.nextVisitDate,
        this.visitOutcomes,
        this.remark,
        this.inflName});

  MwpVisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitSubType = json['visitSubType'];
    docId = json['docId'];
    visitDate = json['visitDate'];
    visitType = json['visitType'];
    visitStartTime = json['visitStartTime'];
    visitStartLat = json['visitStartLat'];
    visitStartLong = json['visitStartLong'];
    visitEndTime = json['visitEndTime'];
    visitEndLat = json['visitEndLat'];
    visitEndLong = json['visitEndLong'];
    nextVisitDate = json['nextVisitDate'];
    visitOutcomes = json['visitOutcomes'];
    remark = json['remark'];
    inflName = json['inflName'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visitSubType'] = this.visitSubType;
    data['docId'] = this.docId;
    data['visitDate'] = this.visitDate;
    data['visitType'] = this.visitType;
    data['visitStartTime'] = this.visitStartTime;
    data['visitStartLat'] = this.visitStartLat;
    data['visitStartLong'] = this.visitStartLong;
    data['visitEndTime'] = this.visitEndTime;
    data['visitEndLat'] = this.visitEndLat;
    data['visitEndLong'] = this.visitEndLong;
    data['nextVisitDate'] = this.nextVisitDate;
    data['visitOutcomes'] = this.visitOutcomes;
    data['remark'] = this.remark;
    data['inflName'] = this.inflName;
    return data;
  }
}

class SiteFloorsEntity {
  int id;
  String siteFloorTxt;

  SiteFloorsEntity({this.id, this.siteFloorTxt});

  SiteFloorsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteFloorTxt = json['siteFloorTxt'].toString() ?? "";
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
    photoName = json['photoName'].toString() ?? "";
    createdBy = json['createdBy'].toString() ?? "";
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
/*
class SiteVisitHistoryEntity {
  int id;
  // String totalBalancePotential;
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
  String authorisedBy;
  String authorisedOn;


  SiteVisitHistoryEntity(
      {this.id,
        // this.totalBalancePotential,
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
        this.receiptNumber,this.authorisedBy, this.authorisedOn});

  SiteVisitHistoryEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // totalBalancePotential = json['totalBalancePotential'].toString() ?? "";
    constructionStageId = json['constructionStageId'];
    floorId = json['floorId'];
    stagePotential = json['stagePotential'].toString() ?? "";
    brandId = json['brandId'];
    brandPrice = json['brandPrice'].toString() ?? "";
    constructionDate = json['constructionDate'].toString() ?? "";
    siteId = json['siteId'];
    supplyDate = json['supplyDate'].toString() ?? "";
    supplyQty = json['supplyQty'].toString() ?? "";
    stageStatus = json['stageStatus'].toString() ?? "";
    createdOn = json['createdOn'];
    createdBy = json['createdBy'].toString() ?? "";
    soldToParty = json['soldToParty'].toString() ?? "";
    shipToParty = json['shipToParty'].toString() ?? "";
    soCode = json['soCode'].toString() ?? "";
    isAuthorised = json['isAuthorised'].toString() ?? "";
    isExpanded = false;
    receiptNumber = json['receiptNumber'].toString() ?? "";
    authorisedBy = json['authorisedBy'].toString()??"";
    authorisedOn = json['authorisedOn'].toString() ??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['totalBalancePotential'] = this.totalBalancePotential;
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
    data['authorisedBy'] = this.authorisedBy;
    data['authorisedOn'] = this.authorisedOn;
    return data;
  }
}
*/
class SiteStageEntity {
  int id;
  String siteStageDesc;

  SiteStageEntity({this.id, this.siteStageDesc});

  SiteStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteStageDesc = json['siteStageDesc'].toString() ?? "";
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
    constructionStageText = json['constructionStageText'].toString() ?? "";
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
    siteProbabilityStatus = json['siteProbabilityStatus'].toString() ?? "";
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
    competitionStatus = json['competitionStatus'].toString() ?? "";
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
    brandName = json['brandName'].toString() ?? "";
    productName = json['productName'].toString() ?? "";
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
    inflName = json['inflName'].toString() ?? "";
    inflContact = json['inflContact'].toString() ?? "";
    inflTypeId = json['inflTypeId'];
    inflCatId = json['inflCatId'];
    ilpIntrested = json['ilpIntrested'].toString() ?? "";
    createdOn = json['createdOn'];
    isPrimarybool = json['isPrimarybool'];
    isPrimary = json['isPrimary'].toString() ?? "";
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
  String floorId;


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
      this.createdOn,
      this.floorId
      });

  SiteNextStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['siteId'];
    constructionStageId = json['constructionStageId'];
    stagePotential = json['stagePotential'].toString() ?? "";
    brandId = json['brandId'];
    brandPrice = json['brandPrice'].toString() ?? "";
    stageStatus = json['stageStatus'].toString() ?? "";
    constructionStartDt = json['constructionStartDt'].toString() ?? "";
    nextStageSupplyDate = json['nextStageSupplyDate'].toString() ?? "";
    nextStageSupplyQty = json['nextStageSupplyQty'].toString() ?? "";
    createdBy = json['createdBy'].toString() ?? "";
    createdOn = json['createdOn'];
    floorId = json['floorId'].toString() ?? "";
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
    data['floorId'] = this.floorId;
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
    siteCommentText = json['siteCommentText'].toString() ?? "";
    creatorName = json['creatorName'].toString() ?? "";
    createdBy = json['createdBy'].toString() ?? "";
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
    inflTypeDesc = json['inflTypeDesc'].toString() ?? "";
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
    inflCatDesc = json['inflCatDesc'].toString() ?? "";
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
    opportunityStatus = json['opportunityStatus'].toString() ?? "";
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
    isDelete = json['isDelete'].toString() ?? "";
    createdBy = json['createdBy'].toString() ?? "";
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    isPrimary = json['isPrimary'].toString() ?? "";
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
    soldToParty = json['soldToParty'].toString() ?? "";
    soldToPartyName = json['soldToPartyName'].toString() ?? "";
    shipToParty = json['shipToParty'].toString() ?? "";
    shipToPartyName = json['shipToPartyName'].toString() ?? "";
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
class ProductListModel {
  int brandId;
  var brandPrice = TextEditingController();
  var supplyDate = TextEditingController();
  var supplyQty = TextEditingController();
  var isExpanded = ExpandableController();
  BrandModelforDB brandModelForDB;


  ProductListModel(
      {this.brandId,
        this.brandPrice,
        this.supplyDate,
        this.supplyQty,
      this.isExpanded,
      this.brandModelForDB});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    brandPrice.text = json['brandPrice'].toString() ?? "";
    supplyDate.text = json['supplyDate'].toString() ?? "";
    supplyQty.text = json['supplyQty'].toString() ?? "";
    isExpanded.expanded = json['isExpanded'];
    brandModelForDB = json['brandModelForDB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandId'] = this.brandId;
    data['brandPrice'] = this.brandPrice.text;
    data['supplyDate'] = this.supplyDate.text;
    data['supplyQty'] = this.supplyQty.text;
    data['isExpanded'] = this.isExpanded.expanded;
    data['brandModelForDB'] = this.brandModelForDB;
    return data;
  }
}


