class LeadsListModel {
  List<LeadsEntity> leadsEntity;
  String respCode;
  String respMsg;
  String totalLeadPotential;
  String totalLeadCount;

  LeadsListModel(
      {this.leadsEntity,
        this.respCode,
        this.respMsg,
        this.totalLeadPotential,
        this.totalLeadCount});

  LeadsListModel.fromJson(Map<String, dynamic> json) {
    if (json['leadsEntity'] != null) {
      leadsEntity = new List<LeadsEntity>();
      json['leadsEntity'].forEach((v) {
        leadsEntity.add(new LeadsEntity.fromJson(v));
      });
    }
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
    totalLeadPotential = json['total_Lead_Potential'];
    totalLeadCount = json['total_Lead_Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadsEntity != null) {
      data['leadsEntity'] = this.leadsEntity.map((v) => v.toJson()).toList();
    }
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    data['total_Lead_Potential'] = this.totalLeadPotential;
    data['total_Lead_Count'] = this.totalLeadCount;
    return data;
  }
}

class LeadsEntity {
  int leadId;
  String leadSegment;
  int siteSubTypeId;
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
  Null leadReraNumber;
  Null leadRejectReason;
  String leadIsDuplicate;
  Null leadOriginalId;
  String siteConverted;
  String createdBy;
  int createdOn;
  Null updatedBy;
  Null updatedOn;

  LeadsEntity(
      {this.leadId,
        this.leadSegment,
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
        this.updatedOn});

  LeadsEntity.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    leadSegment = json['leadSegment'];
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
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['leadSegment'] = this.leadSegment;
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
    data['updated_on'] = this.updatedOn;
    return data;
  }
}
