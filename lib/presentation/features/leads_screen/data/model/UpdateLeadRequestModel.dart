

class UpdateLeadRequestModel {
  int? leadId;
  String? leadSegment;
  String? assignedTo;
  int? leadStatusId;
  int? leadStage;
  String? contactName;
  String? contactNumber;
  String? geotagType;
  String? leadLatitude;
  String? leadLongitude;
  String? leadAddress;
  String? leadPincode;
  String? leadStateName;
  String? leadDistrictName;
  String? leadTalukName;
  String? leadSalesPotentialMt;
  String? leadReraNumber;
  String? isStatus;
  String? updatedBy;
  String? leadIsDuplicate;
  String? rejectionComment;
  String? nextDateCconstruction;
  int? nextStageConstruction;
  String? siteDealerId;
  List<ListLeadcomments>? listLeadcomments;
  List<ListLeadImage>? listLeadImage;
  List<LeadInfluencerEntity>? leadInfluencerEntity;

  UpdateLeadRequestModel(
      {this.leadId,
      this.leadSegment,
      this.assignedTo,
      this.leadStatusId,
      this.leadStage,
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
      this.leadSalesPotentialMt,
      this.leadReraNumber,
      this.isStatus,
      this.updatedBy,
      this.leadIsDuplicate,
      this.rejectionComment,
      this.nextDateCconstruction,
      this.nextStageConstruction,
      this.siteDealerId,
      this.listLeadcomments,
      this.listLeadImage,
      this.leadInfluencerEntity});

  UpdateLeadRequestModel.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    leadSegment = json['leadSegment'];
    assignedTo = json['assignedTo'];
    leadStatusId = json['leadStatusId'];
    leadStage = json['leadStage'];
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
    leadSalesPotentialMt = json['leadSalesPotentialMt'];
    leadReraNumber = json['leadReraNumber'];
    isStatus = json['isStatus'];
    updatedBy = json['updatedBy'];
    leadIsDuplicate = json['leadIsDuplicate'];
    rejectionComment = json['rejectionComment'];
    nextDateCconstruction = json['nextDateCconstruction'];
    nextStageConstruction = json['nextStageConstruction'];
    siteDealerId = json['siteDealerId'];

    if (!json.containsKey('listLeadcomments'))
      listLeadcomments = new List<ListLeadcomments>.empty(growable: true);

    if (json['listLeadcomments'] != null) {
      listLeadcomments = new List<ListLeadcomments>.empty(growable: true);
      json['listLeadcomments'].forEach((v) {
        listLeadcomments!.add(new ListLeadcomments.fromJson(v));
      });
    }

    if (!json.containsKey('listLeadImage'))
      listLeadImage = new List<ListLeadImage>.empty(growable: true);

    if (json['listLeadImage'] != null) {
      listLeadImage = new List<ListLeadImage>.empty(growable: true);
      json['listLeadImage'].forEach((v) {
        listLeadImage!.add(new ListLeadImage.fromJson(v));
      });
    }

    if (!json.containsKey('leadInfluencerEntity'))
      leadInfluencerEntity = new List<LeadInfluencerEntity>.empty(growable: true);

    if (json['leadInfluencerEntity'] != null) {
      leadInfluencerEntity = new List<LeadInfluencerEntity>.empty(growable: true);
      json['leadInfluencerEntity'].forEach((v) {
        leadInfluencerEntity!.add(new LeadInfluencerEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['leadSegment'] = this.leadSegment;
    data['assignedTo'] = this.assignedTo;
    data['leadStatusId'] = this.leadStatusId;
    data['leadStage'] = this.leadStage;
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
    data['leadSalesPotentialMt'] = this.leadSalesPotentialMt;
    data['leadReraNumber'] = this.leadReraNumber;
    data['isStatus'] = this.isStatus;
    data['updatedBy'] = this.updatedBy;
    data['leadIsDuplicate'] = this.leadIsDuplicate;
    data['rejectionComment'] = this.rejectionComment;
    data['nextDateCconstruction'] = this.nextDateCconstruction;
    data['nextStageConstruction'] = this.nextStageConstruction;
    data['siteDealerId'] = this.siteDealerId;
    if (this.listLeadcomments != null) {
      data['listLeadcomments'] =
          this.listLeadcomments!.map((v) => v.toJson()).toList();
    }
    if (this.listLeadImage != null) {
      data['listLeadImage'] =
          this.listLeadImage!.map((v) => v.toJson()).toList();
    }
    if (this.leadInfluencerEntity != null) {
      data['leadInfluencerEntity'] =
          this.leadInfluencerEntity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListLeadcomments {
  int? leadId;
  String? createdBy;
  String? commentText;
  String? creatorName;

  ListLeadcomments(
      {this.leadId, this.createdBy, this.commentText, this.creatorName});

  ListLeadcomments.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    createdBy = json['createdBy'];
    commentText = json['commentText'];
    creatorName = json['creatorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['createdBy'] = this.createdBy;
    data['commentText'] = this.commentText;
    data['creatorName'] = this.creatorName;
    return data;
  }
}

class ListLeadImage {
  int? leadId;
  String? photoName;
  String? createdBy;

  ListLeadImage({this.leadId, this.photoName, this.createdBy});

  ListLeadImage.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    photoName = json['photoName'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['photoName'] = this.photoName;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class LeadInfluencerEntity {
  int? id;
  int? leadId;
  int? inflId;
  String? createdBy;
  String? isDelete;
  String? isPrimary;

  LeadInfluencerEntity(
      {this.id,
      this.isPrimary,
      this.leadId,
      this.inflId,
      this.createdBy,
      this.isDelete});

  LeadInfluencerEntity.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    inflId = json['inflId'];
    createdBy = json['createdBy'];
    isDelete = json['isDelete'];
    isPrimary = json['isPrimary'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['inflId'] = this.inflId;
    data['createdBy'] = this.createdBy;
    data['isDelete'] = this.isDelete;
    data['isPrimary'] = this.isPrimary;
    data['id'] = this.id;
    return data;
  }
}
