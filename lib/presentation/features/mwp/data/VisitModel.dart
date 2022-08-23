

class VisitResponseModel {
  String? respCode;
  String? respMsg;
  MwpVisitModel? mwpVisitModel;
  Null mwpMeetModel;

  VisitResponseModel(
      {this.respCode, this.respMsg, this.mwpVisitModel, this.mwpMeetModel});

  VisitResponseModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];

    if (!json.containsKey('mwpVisitModel'))
      mwpVisitModel = null;

    mwpVisitModel = json['mwpVisitModel'] != null
        ? new MwpVisitModel.fromJson(json['mwpVisitModel'])
        : null;
    mwpMeetModel = json['mwpMeetModel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.mwpVisitModel != null) {
      data['mwpVisitModel'] = this.mwpVisitModel!.toJson();
    }
    data['mwpMeetModel'] = this.mwpMeetModel;
    return data;
  }
}

class MwpVisitModel {
  int? id;
  String? visitSubType;
  int? docId;
  String? visitDate;
  String? visitType;
  String? visitStartTime;
  String? visitStartLat;
  String? visitStartLong;
  String? visitEndTime;
  String? visitEndLat;
  String? visitEndLong;
  String? visitOutcomes;
  int? nextVisitDate;
  String? remark;
  String? dspAvailableQty;
  String? isDspAvailable;

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
      this.visitOutcomes,
      this.visitEndLong,
      this.remark,
        this.dspAvailableQty,
        this.isDspAvailable});

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
    visitOutcomes = json['visitOutcomes'];
    nextVisitDate = json['nextVisitDate'];
    remark = json['remark'];
    dspAvailableQty = json['dspAvailableQty'];
    isDspAvailable = json['isDspAvailable'];
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
    data['visitOutcomes'] = this.visitOutcomes;
    data['visitStartLong'] = this.visitStartLong;
    data['visitEndTime'] = this.visitEndTime;
    data['visitEndLat'] = this.visitEndLat;
    data['visitEndLong'] = this.visitEndLong;
    data['nextVisitDate'] = this.nextVisitDate;
    data['remark'] = this.remark;
    data['dspAvailableQty'] = this.dspAvailableQty;
    data['isDspAvailable'] = this.isDspAvailable;
    return data;
  }
}
