class ComplaintViewModel {
  String resCode;
  String resMsg;
  int id;
  String escalationLevel;
  String sla;
  int tsoId;
  String referenceId;
  int requestDepartment;
  String deaprtmentText;
  int requestId;
  String requestText;
  String creatorType;
  String creatorId;
  Null creatorName;
  int siteId;
  String description;
  String severity;
  String state;
  String district;
  String taluk;
  String pincode;
  int resoulutionStatus;
  String createdBy;
  String createdOn;
  Null updatedBy;
  String updatedOn;
  List<SrcSubtypeMappingModal> srcSubtypeMappingModal;
  List<SrcResolutionEntity> srcResolutionEntity;
  List<SrComplaintActionList> srComplaintActionList;

  ComplaintViewModel(
      {this.resCode,
        this.resMsg,
        this.id,
        this.escalationLevel,
        this.sla,
        this.tsoId,
        this.referenceId,
        this.requestDepartment,
        this.deaprtmentText,
        this.requestId,
        this.requestText,
        this.creatorType,
        this.creatorId,
        this.creatorName,
        this.siteId,
        this.description,
        this.severity,
        this.state,
        this.district,
        this.taluk,
        this.pincode,
        this.resoulutionStatus,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.srcSubtypeMappingModal,
        this.srcResolutionEntity,
        this.srComplaintActionList});

  ComplaintViewModel.fromJson(Map<String, dynamic> json) {
    resCode = json['resCode'];
    resMsg = json['resMsg'];
    id = json['id'];
    escalationLevel = json['escalationLevel'];
    sla = json['sla'];
    tsoId = json['tsoId'];
    referenceId = json['referenceId'];
    requestDepartment = json['requestDepartment'];
    deaprtmentText = json['deaprtmentText'];
    requestId = json['requestId'];
    requestText = json['requestText'];
    creatorType = json['creatorType'];
    creatorId = json['creatorId'];
    creatorName = json['creatorName'];
    siteId = json['siteId'];
    description = json['description'];
    severity = json['severity'];
    state = json['state'];
    district = json['district'];
    taluk = json['taluk'];
    pincode = json['pincode'];
    resoulutionStatus = json['resoulutionStatus'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    if (json['srcSubtypeMappingModal'] != null) {
      srcSubtypeMappingModal = new List<SrcSubtypeMappingModal>();
      json['srcSubtypeMappingModal'].forEach((v) {
        srcSubtypeMappingModal.add(new SrcSubtypeMappingModal.fromJson(v));
      });
    }
    if (json['srcResolutionEntity'] != null) {
      srcResolutionEntity = new List<SrcResolutionEntity>();
      json['srcResolutionEntity'].forEach((v) {
        srcResolutionEntity.add(new SrcResolutionEntity.fromJson(v));
      });
    }
    if (json['srComplaintActionList'] != null) {
      srComplaintActionList = new List<SrComplaintActionList>();
      json['srComplaintActionList'].forEach((v) {
        srComplaintActionList.add(new SrComplaintActionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resCode'] = this.resCode;
    data['resMsg'] = this.resMsg;
    data['id'] = this.id;
    data['escalationLevel'] = this.escalationLevel;
    data['sla'] = this.sla;
    data['tsoId'] = this.tsoId;
    data['referenceId'] = this.referenceId;
    data['requestDepartment'] = this.requestDepartment;
    data['deaprtmentText'] = this.deaprtmentText;
    data['requestId'] = this.requestId;
    data['requestText'] = this.requestText;
    data['creatorType'] = this.creatorType;
    data['creatorId'] = this.creatorId;
    data['creatorName'] = this.creatorName;
    data['siteId'] = this.siteId;
    data['description'] = this.description;
    data['severity'] = this.severity;
    data['state'] = this.state;
    data['district'] = this.district;
    data['taluk'] = this.taluk;
    data['pincode'] = this.pincode;
    data['resoulutionStatus'] = this.resoulutionStatus;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['updatedBy'] = this.updatedBy;
    data['updatedOn'] = this.updatedOn;
    if (this.srcSubtypeMappingModal != null) {
      data['srcSubtypeMappingModal'] =
          this.srcSubtypeMappingModal.map((v) => v.toJson()).toList();
    }
    if (this.srcResolutionEntity != null) {
      data['srcResolutionEntity'] =
          this.srcResolutionEntity.map((v) => v.toJson()).toList();
    }
    if (this.srComplaintActionList != null) {
      data['srComplaintActionList'] =
          this.srComplaintActionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SrcSubtypeMappingModal {
  int id;
  String requestTypeText;

  SrcSubtypeMappingModal({this.id, this.requestTypeText});

  SrcSubtypeMappingModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestTypeText = json['requestTypeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestTypeText'] = this.requestTypeText;
    return data;
  }
}

class SrcResolutionEntity {
  int id;
  String resolutionText;

  SrcResolutionEntity({this.id, this.resolutionText});

  SrcResolutionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resolutionText = json['resolutionText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resolutionText'] = this.resolutionText;
    return data;
  }
}

class SrComplaintActionList {
  int id;
  int srComplaintId;
  String requestNature;
  double locationLat;
  double locationLong;
  String productComplaint;
  String techvanReqd;
  String productType;
  int purchaseDate;
  String sourcePlant;
  String productBatch;
  int bagsCount;
  int resolutionStatusId;
  String comment;
  int nextVisitDate;
  String createdBy;
  int createdOn;

  SrComplaintActionList(
      {this.id,
        this.srComplaintId,
        this.requestNature,
        this.locationLat,
        this.locationLong,
        this.productComplaint,
        this.techvanReqd,
        this.productType,
        this.purchaseDate,
        this.sourcePlant,
        this.productBatch,
        this.bagsCount,
        this.resolutionStatusId,
        this.comment,
        this.nextVisitDate,
        this.createdBy,
        this.createdOn});

  SrComplaintActionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    srComplaintId = json['srComplaintId'];
    requestNature = json['requestNature'];
    locationLat = json['locationLat'];
    locationLong = json['locationLong'];
    productComplaint = json['productComplaint'];
    techvanReqd = json['techvanReqd'];
    productType = json['productType'];
    purchaseDate = json['purchaseDate'];
    sourcePlant = json['sourcePlant'];
    productBatch = json['productBatch'];
    bagsCount = json['bagsCount'];
    resolutionStatusId = json['resolutionStatusId'];
    comment = json['comment'];
    nextVisitDate = json['nextVisitDate'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['srComplaintId'] = this.srComplaintId;
    data['requestNature'] = this.requestNature;
    data['locationLat'] = this.locationLat;
    data['locationLong'] = this.locationLong;
    data['productComplaint'] = this.productComplaint;
    data['techvanReqd'] = this.techvanReqd;
    data['productType'] = this.productType;
    data['purchaseDate'] = this.purchaseDate;
    data['sourcePlant'] = this.sourcePlant;
    data['productBatch'] = this.productBatch;
    data['bagsCount'] = this.bagsCount;
    data['resolutionStatusId'] = this.resolutionStatusId;
    data['comment'] = this.comment;
    data['nextVisitDate'] = this.nextVisitDate;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    return data;
  }
}