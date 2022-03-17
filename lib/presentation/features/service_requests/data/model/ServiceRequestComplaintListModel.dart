

class ServiceRequestComplaintListModel {
  double? totalCount;
  double? totalPotential;
  List<SrComplaintListModal>? srComplaintListModal;
  String? respCode;
  String? respMsg;

  ServiceRequestComplaintListModel(
      {this.totalCount,
        this.totalPotential,
        this.srComplaintListModal,
        this.respCode,
        this.respMsg});

  ServiceRequestComplaintListModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    totalPotential = json['totalPotential'];
    if (json['srComplaintListModal'] != null) {
      srComplaintListModal = new List<SrComplaintListModal>.empty(growable: true);
      json['srComplaintListModal'].forEach((v) {
        srComplaintListModal!.add(new SrComplaintListModal.fromJson(v));
      });
    }
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['totalPotential'] = this.totalPotential;
    if (this.srComplaintListModal != null) {
      data['srComplaintListModal'] =
          this.srComplaintListModal!.map((v) => v.toJson()).toList();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class SrComplaintListModal {
  int? siteId;
  String? createdOn;
  String? district;
  double? sitePotential;
  int? srComplaintId;
  String? request;
  String? srComplaintRequestType;
  String? severity;
  int? slaRemaining;
  String? status;
  String? escalationLevel;
  String? creatorContact;
  String? siteContact;
  String? summarySrOfSite;
  String? requesterName;

  SrComplaintListModal(
      {this.siteId,
        this.createdOn,
        this.district,
        this.sitePotential,
        this.srComplaintId,
        this.request,
        this.srComplaintRequestType,
        this.severity,
        this.slaRemaining,
        this.status,
        this.escalationLevel,
        this.creatorContact,
        this.siteContact,
        this.summarySrOfSite,
        this.requesterName});

  SrComplaintListModal.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    createdOn = json['createdOn'];
    district = json['district'];
    sitePotential = json['sitePotential'];
    srComplaintId = json['srComplaintId'];
    request = json['request'];
    srComplaintRequestType = json['srComplaintRequestType'];
    severity = json['severity'];
    slaRemaining = json['slaRemaining'];
    status = json['status'];
    escalationLevel = json['escalationLevel'];
    creatorContact = json['creatorContact'];
    siteContact = json['siteContact'];
    summarySrOfSite = json['summarySrOfSite'];
    requesterName = json['requesterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['createdOn'] = this.createdOn;
    data['district'] = this.district;
    data['sitePotential'] = this.sitePotential;
    data['srComplaintId'] = this.srComplaintId;
    data['request'] = this.request;
    data['srComplaintRequestType'] = this.srComplaintRequestType;
    data['severity'] = this.severity;
    data['slaRemaining'] = this.slaRemaining;
    data['status'] = this.status;
    data['escalationLevel'] = this.escalationLevel;
    data['creatorContact'] = this.creatorContact;
    data['siteContact'] = this.siteContact;
    data['summarySrOfSite'] = this.summarySrOfSite;
    data['requesterName'] = this.requesterName;
    return data;
  }
}