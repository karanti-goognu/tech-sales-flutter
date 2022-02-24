class SiteVisitRequestModel {
  int? docId;
  String? dspAvailableQty;
  String? eventType;
  int? id;
  String? isDspAvailable;
  String? nextVisitDate;
  String? referenceId;
  String? remark;
  String? visitDate;
  String? visitEndLat;
  String? visitEndLong;
  String? visitEndTime;
  String? visitOutcomes;
  String? visitStartLat;
  String? visitStartLong;
  String? visitStartTime;
  String? visitSubType;
  String? visitType;

  SiteVisitRequestModel(
      {this.docId,
        this.dspAvailableQty,
        this.eventType,
        this.id,
        this.isDspAvailable,
        this.nextVisitDate,
        this.referenceId,
        this.remark,
        this.visitDate,
        this.visitEndLat,
        this.visitEndLong,
        this.visitEndTime,
        this.visitOutcomes,
        this.visitStartLat,
        this.visitStartLong,
        this.visitStartTime,
        this.visitSubType,
        this.visitType});

  SiteVisitRequestModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    dspAvailableQty = json['dspAvailableQty'];
    eventType = json['eventType'];
    id = json['id'];
    isDspAvailable = json['isDspAvailable'];
    nextVisitDate = json['nextVisitDate'];
    referenceId = json['referenceId'];
    remark = json['remark'];
    visitDate = json['visitDate'];
    visitEndLat = json['visitEndLat'];
    visitEndLong = json['visitEndLong'];
    visitEndTime = json['visitEndTime'];
    visitOutcomes = json['visitOutcomes'];
    visitStartLat = json['visitStartLat'];
    visitStartLong = json['visitStartLong'];
    visitStartTime = json['visitStartTime'];
    visitSubType = json['visitSubType'];
    visitType = json['visitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docId'] = this.docId;
    data['dspAvailableQty'] = this.dspAvailableQty;
    data['eventType'] = this.eventType;
    data['id'] = this.id;
    data['isDspAvailable'] = this.isDspAvailable;
    data['nextVisitDate'] = this.nextVisitDate;
    data['referenceId'] = this.referenceId;
    data['remark'] = this.remark;
    data['visitDate'] = this.visitDate;
    data['visitEndLat'] = this.visitEndLat;
    data['visitEndLong'] = this.visitEndLong;
    data['visitEndTime'] = this.visitEndTime;
    data['visitOutcomes'] = this.visitOutcomes;
    data['visitStartLat'] = this.visitStartLat;
    data['visitStartLong'] = this.visitStartLong;
    data['visitStartTime'] = this.visitStartTime;
    data['visitSubType'] = this.visitSubType;
    data['visitType'] = this.visitType;
    return data;
  }
}


class SiteVisitResponseModel {
  String? respCode;
  String? respMsg;

  SiteVisitResponseModel({this.respCode, this.respMsg});

  SiteVisitResponseModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}



