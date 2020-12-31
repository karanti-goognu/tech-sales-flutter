class SrComplaintModel {
  String respCode;
  String respMsg;
  List<ServiceRequestComplaintDepartmentEntity>
      serviceRequestComplaintDepartmentEntity;
  List<ServiceRequestComplaintRequestEntity>
      serviceRequestComplaintRequestEntity;
  List<ServiceRequestComplaintTypeEntity> serviceRequestComplaintTypeEntity;

  SrComplaintModel(
      {this.respCode,
      this.respMsg,
      this.serviceRequestComplaintDepartmentEntity,
      this.serviceRequestComplaintRequestEntity,
      this.serviceRequestComplaintTypeEntity});

  SrComplaintModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['serviceRequestComplaintDepartmentEntity'] != null) {
      serviceRequestComplaintDepartmentEntity =
          new List<ServiceRequestComplaintDepartmentEntity>();
      json['serviceRequestComplaintDepartmentEntity'].forEach((v) {
        serviceRequestComplaintDepartmentEntity
            .add(new ServiceRequestComplaintDepartmentEntity.fromJson(v));
      });
    }
    if (json['serviceRequestComplaintRequestEntity'] != null) {
      serviceRequestComplaintRequestEntity =
          new List<ServiceRequestComplaintRequestEntity>();
      json['serviceRequestComplaintRequestEntity'].forEach((v) {
        serviceRequestComplaintRequestEntity
            .add(new ServiceRequestComplaintRequestEntity.fromJson(v));
      });
    }
    if (json['serviceRequestComplaintTypeEntity'] != null) {
      serviceRequestComplaintTypeEntity =
          new List<ServiceRequestComplaintTypeEntity>();
      json['serviceRequestComplaintTypeEntity'].forEach((v) {
        serviceRequestComplaintTypeEntity
            .add(new ServiceRequestComplaintTypeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.serviceRequestComplaintDepartmentEntity != null) {
      data['serviceRequestComplaintDepartmentEntity'] = this
          .serviceRequestComplaintDepartmentEntity
          .map((v) => v.toJson())
          .toList();
    }
    if (this.serviceRequestComplaintRequestEntity != null) {
      data['serviceRequestComplaintRequestEntity'] = this
          .serviceRequestComplaintRequestEntity
          .map((v) => v.toJson())
          .toList();
    }
    if (this.serviceRequestComplaintTypeEntity != null) {
      data['serviceRequestComplaintTypeEntity'] = this
          .serviceRequestComplaintTypeEntity
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}



class ServiceRequestComplaintDepartmentEntity {
  int id;
  String departmentText;

  ServiceRequestComplaintDepartmentEntity({this.id, this.departmentText});

  ServiceRequestComplaintDepartmentEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentText = json['departmentText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departmentText'] = this.departmentText;
    return data;
  }
}

class ServiceRequestComplaintRequestEntity {
  int id;
  String requestText;

  ServiceRequestComplaintRequestEntity({this.id, this.requestText});

  ServiceRequestComplaintRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestText = json['requestText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestText'] = this.requestText;
    return data;
  }
}

class ServiceRequestComplaintTypeEntity {
  int id;
  int requestId;
  String serviceRequestTypeText;
  String complaintSeverity;

  ServiceRequestComplaintTypeEntity(
      {this.id,
      this.requestId,
      this.serviceRequestTypeText,
      this.complaintSeverity});

  ServiceRequestComplaintTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    serviceRequestTypeText = json['serviceRequestTypeText'];
    complaintSeverity = json['complaintSeverity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestId'] = this.requestId;
    data['serviceRequestTypeText'] = this.serviceRequestTypeText;
    data['complaintSeverity'] = this.complaintSeverity;
    return data;
  }
}
