class SrFilterModel {
  List<LeadStatusEntity>? leadStatusEntity;
  List<LeadStageEntity>? leadStageEntity;
  List<SrComplainResolutionEntity>? srComplainResolutionEntity;
  List<SrComplaintTypeEntity>? srComplaintTypeEntity;
  List<String>? severity;

  SrFilterModel(
      {this.leadStatusEntity,
        this.leadStageEntity,
        this.srComplainResolutionEntity,
        this.srComplaintTypeEntity,
        this.severity});

  SrFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>.empty(growable: true);
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity!.add(new LeadStatusEntity.fromJson(v));
      });
    }
    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>.empty(growable: true);
      json['leadStageEntity'].forEach((v) {
        leadStageEntity!.add(new LeadStageEntity.fromJson(v));
      });
    }
    if (json['srComplainResolutionEntity'] != null) {
      srComplainResolutionEntity = new List<SrComplainResolutionEntity>.empty(growable: true);
      json['srComplainResolutionEntity'].forEach((v) {
        srComplainResolutionEntity!
            .add(new SrComplainResolutionEntity.fromJson(v));
      });
    }
    if (json['srComplaintTypeEntity'] != null) {
      srComplaintTypeEntity = new List<SrComplaintTypeEntity>.empty(growable: true);
      json['srComplaintTypeEntity'].forEach((v) {
        srComplaintTypeEntity!.add(new SrComplaintTypeEntity.fromJson(v));
      });
    }
    severity = json['Severity'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity!.map((v) => v.toJson()).toList();
    }
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity!.map((v) => v.toJson()).toList();
    }
    if (this.srComplainResolutionEntity != null) {
      data['srComplainResolutionEntity'] =
          this.srComplainResolutionEntity!.map((v) => v.toJson()).toList();
    }
    if (this.srComplaintTypeEntity != null) {
      data['srComplaintTypeEntity'] =
          this.srComplaintTypeEntity!.map((v) => v.toJson()).toList();
    }
    data['Severity'] = this.severity;
    return data;
  }
}

class LeadStatusEntity {
  int? id;
  String? leadStatusDesc;

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

class LeadStageEntity {
  int? id;
  String? leadStageDesc;

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

class SrComplainResolutionEntity {
  int? id;
  String? resolutionText;

  SrComplainResolutionEntity({this.id, this.resolutionText});

  SrComplainResolutionEntity.fromJson(Map<String, dynamic> json) {
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

class SrComplaintTypeEntity {
  int? id;
  int? requestId;
  String? serviceRequestTypeText;
  Null complaintSeverity;

  SrComplaintTypeEntity(
      {this.id,
        this.requestId,
        this.serviceRequestTypeText,
        this.complaintSeverity});

  SrComplaintTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    serviceRequestTypeText = json['service_request_type_text'];
    complaintSeverity = json['complaint_severity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['service_request_type_text'] = this.serviceRequestTypeText;
    data['complaint_severity'] = this.complaintSeverity;
    return data;
  }
}