class SaveServiceRequest {
  int requestDepartmentId;
  int requestId;
  String creatorType;
  String creatorId;
  String creatorContactNumber;
  int siteId;
  String description;
  String severity;
  String state;
  String district;
  String taluk;
  String pincode;
  int resolutionStatusId;
  String createdBy;
  List<SrComplaintSubtypeMappingEntity> srComplaintSubtypeMappingEntity;
  List<SrComplaintPhotosEntity> srComplaintPhotosEntity;

  SaveServiceRequest(
      {this.requestDepartmentId,
        this.requestId,
        this.creatorType,
        this.creatorId,
        this.creatorContactNumber,
        this.siteId,
        this.description,
        this.severity,
        this.state,
        this.district,
        this.taluk,
        this.pincode,
        this.resolutionStatusId,
        this.createdBy,
        this.srComplaintSubtypeMappingEntity,
        this.srComplaintPhotosEntity});

  SaveServiceRequest.fromJson(Map<String, dynamic> json) {
    requestDepartmentId = json['requestDepartmentId'];
    requestId = json['requestId'];
    creatorType = json['creatorType'];
    creatorId = json['creatorId'];
    creatorContactNumber = json['creatorContactNumber'];
    siteId = json['siteId'];
    description = json['description'];
    severity = json['severity'];
    state = json['state'];
    district = json['district'];
    taluk = json['taluk'];
    pincode = json['pincode'];
    resolutionStatusId = json['resolutionStatusId'];
    createdBy = json['createdBy'];
    if (json['srComplaintSubtypeMappingEntity'] != null) {
      srComplaintSubtypeMappingEntity =
      new List<SrComplaintSubtypeMappingEntity>.empty(growable: true);
      json['srComplaintSubtypeMappingEntity'].forEach((v) {
        srComplaintSubtypeMappingEntity
            .add(new SrComplaintSubtypeMappingEntity.fromJson(v));
      });
    }
    if (json['srComplaintPhotosEntity'] != null) {
      srComplaintPhotosEntity = new List<SrComplaintPhotosEntity>.empty(growable: true);
      json['srComplaintPhotosEntity'].forEach((v) {
        srComplaintPhotosEntity.add(new SrComplaintPhotosEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestDepartmentId'] = this.requestDepartmentId;
    data['requestId'] = this.requestId;
    data['creatorType'] = this.creatorType;
    data['creatorId'] = this.creatorId;
    data['creatorContactNumber'] = this.creatorContactNumber;
    data['siteId'] = this.siteId;
    data['description'] = this.description;
    data['severity'] = this.severity;
    data['state'] = this.state;
    data['district'] = this.district;
    data['taluk'] = this.taluk;
    data['pincode'] = this.pincode;
    data['resolutionStatusId'] = this.resolutionStatusId;
    data['createdBy'] = this.createdBy;
    if (this.srComplaintSubtypeMappingEntity != null) {
      data['srComplaintSubtypeMappingEntity'] =
          this.srComplaintSubtypeMappingEntity.map((v) => v.toJson()).toList();
    }
    if (this.srComplaintPhotosEntity != null) {
      data['srComplaintPhotosEntity'] =
          this.srComplaintPhotosEntity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SrComplaintSubtypeMappingEntity {
  Null serviceRequestComplaintId;
  int serviceRequestComplaintTypeId;
  String createdBy;

  SrComplaintSubtypeMappingEntity(
      {this.serviceRequestComplaintId,
        this.serviceRequestComplaintTypeId,
        this.createdBy});

  SrComplaintSubtypeMappingEntity.fromJson(Map<String, dynamic> json) {
    serviceRequestComplaintId = json['serviceRequestComplaintId'];
    serviceRequestComplaintTypeId = json['serviceRequestComplaintTypeId'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceRequestComplaintId'] = this.serviceRequestComplaintId;
    data['serviceRequestComplaintTypeId'] = this.serviceRequestComplaintTypeId;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class SrComplaintPhotosEntity {
  int srComplaintId;
  String photoName;
  String createdBy;

  SrComplaintPhotosEntity({this.srComplaintId, this.photoName, this.createdBy});

  SrComplaintPhotosEntity.fromJson(Map<String, dynamic> json) {
    srComplaintId = json['srComplaintId'];
    photoName = json['photoName'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srComplaintId'] = this.srComplaintId;
    data['photoName'] = this.photoName;
    data['createdBy'] = this.createdBy;
    return data;
  }
}