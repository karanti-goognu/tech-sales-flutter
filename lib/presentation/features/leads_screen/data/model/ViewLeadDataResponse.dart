class ViewLeadDataResponse {
  String respCode;
  String respMsg;
  List<LeadStageEntity> leadStageEntity;
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadInfluencerEntity> leadInfluencerEntity;
  List<LeadcommentsEnitiy> leadcommentsEnitiy;
  List<LeadphotosEntity> leadphotosEntity;
  List<InfluencerEntity> influencerEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;
  LeadsEntity leadsEntity;
  List<DealerList> dealerList;

  ViewLeadDataResponse(
      {this.respCode,
        this.respMsg,
        this.leadStageEntity,
        this.leadStatusEntity,
        this.leadInfluencerEntity,
        this.leadcommentsEnitiy,
        this.leadphotosEntity,
        this.influencerEntity,
        this.influencerCategoryEntity,
        this.influencerTypeEntity,
        this.leadsEntity,
        this.dealerList});

  ViewLeadDataResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>();
      json['leadStageEntity'].forEach((v) {
        leadStageEntity.add(new LeadStageEntity.fromJson(v));
      });
    }
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>();
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity.add(new LeadStatusEntity.fromJson(v));
      });
    }
    if (json['leadInfluencerEntity'] != null) {
      leadInfluencerEntity = new List<LeadInfluencerEntity>();
      json['leadInfluencerEntity'].forEach((v) {
        leadInfluencerEntity.add(new LeadInfluencerEntity.fromJson(v));
      });
    }
    if (json['leadcommentsEnitiy'] != null) {
      leadcommentsEnitiy = new List<LeadcommentsEnitiy>();
      json['leadcommentsEnitiy'].forEach((v) {
        leadcommentsEnitiy.add(new LeadcommentsEnitiy.fromJson(v));
      });
    }
    if (json['leadphotosEntity'] != null) {
      leadphotosEntity = new List<LeadphotosEntity>();
      json['leadphotosEntity'].forEach((v) {
        leadphotosEntity.add(new LeadphotosEntity.fromJson(v));
      });
    }
    if (json['influencerEntity'] != null) {
      influencerEntity = new List<InfluencerEntity>();
      json['influencerEntity'].forEach((v) {
        influencerEntity.add(new InfluencerEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>();
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
    leadsEntity = json['leadsEntity'] != null
        ? new LeadsEntity.fromJson(json['leadsEntity'])
        : null;
    if (json['dealerList'] != null) {
      dealerList = new List<DealerList>();
      json['dealerList'].forEach((v) {
        dealerList.add(new DealerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadInfluencerEntity != null) {
      data['leadInfluencerEntity'] =
          this.leadInfluencerEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadcommentsEnitiy != null) {
      data['leadcommentsEnitiy'] =
          this.leadcommentsEnitiy.map((v) => v.toJson()).toList();
    }
    if (this.leadphotosEntity != null) {
      data['leadphotosEntity'] =
          this.leadphotosEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerEntity != null) {
      data['influencerEntity'] =
          this.influencerEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerTypeEntity != null) {
      data['influencerTypeEntity'] =
          this.influencerTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadsEntity != null) {
      data['leadsEntity'] = this.leadsEntity.toJson();
    }
    if (this.dealerList != null) {
      data['dealerList'] = this.dealerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadStageEntity {
  int id;
  String leadStageDesc;

  LeadStageEntity({this.id, this.leadStageDesc});

  LeadStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStageDesc = json['leadStageDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStageDesc'] = this.leadStageDesc;
    return data;
  }
}

class LeadStatusEntity {
  int id;
  String leadStatusDesc;

  LeadStatusEntity({this.id, this.leadStatusDesc});

  LeadStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStatusDesc = json['leadStatusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStatusDesc'] = this.leadStatusDesc;
    return data;
  }
}

class LeadInfluencerEntity {
  int id;
  int leadId;
  int inflId;
  String isDelete;
  String createdBy;
  int createdOn;
  Null updatedBy;
  Null updatedOn;

  LeadInfluencerEntity(
      {this.id,
        this.leadId,
        this.inflId,
        this.isDelete,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn});

  LeadInfluencerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
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
    data['leadId'] = this.leadId;
    data['inflId'] = this.inflId;
    data['isDelete'] = this.isDelete;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}

class LeadphotosEntity {
  int id;
  int leadId;
  String photoName;
  String createdBy;
  int createdOn;

  LeadphotosEntity(
      {this.id, this.leadId, this.photoName, this.createdBy, this.createdOn});

  LeadphotosEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    photoName = json['photoName'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadId'] = this.leadId;
    data['photoName'] = this.photoName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
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

class LeadsEntity {
  int leadId;
  String leadSegment;
  String assignedTo;
  Null siteSubTypeId;
  int leadStatusId;
  int leadStageId;
  String contactName;
  String contactNumber;
  String geotagType;
  String leadLatitude;
  String leadLongitude;
  String leadAddress;
  String leadPincode;
  String leadStateName;
  String leadDistrictName;
  String leadTalukName;
  String leadSitePotentialMt;
  String leadReraNumber;
  Null leadRejectReason;
  String leadIsDuplicate;
  Null leadOriginalId;
  Null siteConverted;
  String createdBy;
  int createdOn;
  Null updatedBy;
  Null updatedOn;
  Null assignDate;
  String rejectionComment;
  String leadscol;
  Null nextDateCconstruction;
  String nextStageConstruction;
  Null siteDealerId;

  LeadsEntity(
      {this.leadId,
        this.leadSegment,
        this.assignedTo,
        this.siteSubTypeId,
        this.leadStatusId,
        this.leadStageId,
        this.contactName,
        this.contactNumber,
        this.geotagType,
        this.leadLatitude,
        this.leadLongitude,
        this.leadAddress,
        this.leadPincode,
        this.leadStateName,
        this.leadDistrictName,
        this.leadTalukName,
        this.leadSitePotentialMt,
        this.leadReraNumber,
        this.leadRejectReason,
        this.leadIsDuplicate,
        this.leadOriginalId,
        this.siteConverted,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.assignDate,
        this.rejectionComment,
        this.leadscol,
        this.nextDateCconstruction,
        this.nextStageConstruction,
        this.siteDealerId});

  LeadsEntity.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    leadSegment = json['leadSegment'];
    assignedTo = json['assignedTo'];
    siteSubTypeId = json['siteSubTypeId'];
    leadStatusId = json['leadStatusId'];
    leadStageId = json['leadStageId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    geotagType = json['geotagType'];
    leadLatitude = json['leadLatitude'];
    leadLongitude = json['leadLongitude'];
    leadAddress = json['leadAddress'];
    leadPincode = json['leadPincode'];
    leadStateName = json['leadStateName'];
    leadDistrictName = json['leadDistrictName'];
    leadTalukName = json['leadTalukName'];
    leadSitePotentialMt = json['leadSitePotentialMt'];
    leadReraNumber = json['leadReraNumber'];
    leadRejectReason = json['leadRejectReason'];
    leadIsDuplicate = json['leadIsDuplicate'];
    leadOriginalId = json['leadOriginalId'];
    siteConverted = json['siteConverted'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    assignDate = json['assignDate'];
    rejectionComment = json['rejectionComment'];
    leadscol = json['leadscol'];
    nextDateCconstruction = json['nextDateCconstruction'];
    nextStageConstruction = json['nextStageConstruction'];
    siteDealerId = json['siteDealerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['leadSegment'] = this.leadSegment;
    data['assignedTo'] = this.assignedTo;
    data['siteSubTypeId'] = this.siteSubTypeId;
    data['leadStatusId'] = this.leadStatusId;
    data['leadStageId'] = this.leadStageId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['geotagType'] = this.geotagType;
    data['leadLatitude'] = this.leadLatitude;
    data['leadLongitude'] = this.leadLongitude;
    data['leadAddress'] = this.leadAddress;
    data['leadPincode'] = this.leadPincode;
    data['leadStateName'] = this.leadStateName;
    data['leadDistrictName'] = this.leadDistrictName;
    data['leadTalukName'] = this.leadTalukName;
    data['leadSitePotentialMt'] = this.leadSitePotentialMt;
    data['leadReraNumber'] = this.leadReraNumber;
    data['leadRejectReason'] = this.leadRejectReason;
    data['leadIsDuplicate'] = this.leadIsDuplicate;
    data['leadOriginalId'] = this.leadOriginalId;
    data['siteConverted'] = this.siteConverted;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    data['assignDate'] = this.assignDate;
    data['rejectionComment'] = this.rejectionComment;
    data['leadscol'] = this.leadscol;
    data['nextDateCconstruction'] = this.nextDateCconstruction;
    data['nextStageConstruction'] = this.nextStageConstruction;
    data['siteDealerId'] = this.siteDealerId;
    return data;
  }
}

class DealerList {
  String dealerId;
  String dealerName;

  DealerList({this.dealerId, this.dealerName});

  DealerList.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}

class LeadcommentsEnitiy {
  int id;
  int leadId;
  String commentText;
  String creatorName;
  String createdBy;
  int createdOn;

  LeadcommentsEnitiy(
      {this.id,
        this.leadId,
        this.commentText,
        this.creatorName,
        this.createdBy,
        this.createdOn});

  LeadcommentsEnitiy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    commentText = json['commentText'];
    creatorName = json['creatorName'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadId'] = this.leadId;
    data['commentText'] = this.commentText;
    data['creatorName'] = this.creatorName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}