class UpdateVisitResponseModel {
  MwpVisitModelUpdate mwpVisitModel;
  Null mwpMeetModel;

  UpdateVisitResponseModel(
      {this.mwpVisitModel, this.mwpMeetModel});

  UpdateVisitResponseModel.fromJson(Map<String, dynamic> json) {

    mwpVisitModel = json['mwpVisitModel'] != null
        ? new MwpVisitModelUpdate.fromJson(json['mwpVisitModel'])
        : null;
    mwpMeetModel = json['mwpMeetModel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mwpVisitModel != null) {
      data['mwpVisitModel'] = this.mwpVisitModel.toJson();
    }
    data['mwpMeetModel'] = this.mwpMeetModel;
    return data;
  }
}

class MwpVisitModelUpdate {
  int id;
  String visitDate;
  String visitType;
  String visitStartTime;
  double visitStartLat;
  double visitStartLong;
  String visitEndTime;
  String nextVisitDate;
  double visitEndLat;
  double visitEndLong;
  String visitOutcomes;
  String remark;
  String visitSubType;
  String docId;
  String dspAvailableQty;
  String isDspAvailable;


  MwpVisitModelUpdate(this.id,
      this.visitDate,
      this.visitType,
      this.visitStartTime,
      this.visitStartLat,
      this.visitStartLong,
      this.visitEndTime,
      this.visitEndLat,
      this.visitEndLong,
      this.nextVisitDate,
      this.visitOutcomes,
      this.remark,
      this.visitSubType,
      this.docId,
      this.dspAvailableQty,
      this.isDspAvailable);


  MwpVisitModelUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitDate = json['visitDate'];
    visitType = json['visitType'];
    visitStartTime = json['visitStartTime'];
    visitStartLat = json['visitStartLat'];
    visitStartLong = json['visitStartLong'];
    visitEndTime = json['visitEndTime'];
    visitEndLat = json['visitEndLat'];
    visitEndLong = json['visitEndLong'];
    nextVisitDate = json['nextVisitDate'];
    visitOutcomes = json['visitOutcomes'];
    remark = json['remark'];
    visitSubType = json['visitSubType'];
    docId = json['docId'];
    dspAvailableQty = json['dspAvailableQty'];
    isDspAvailable = json['isDspAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visitDate'] = this.visitDate;
    data['visitType'] = this.visitType;
    data['visitStartTime'] = this.visitStartTime;
    data['visitStartLat'] = this.visitStartLat;
    data['visitStartLong'] = this.visitStartLong;
    data['visitEndTime'] = this.visitEndTime;
    data['visitEndLat'] = this.visitEndLat;
    data['visitEndLong'] = this.visitEndLong;
    data['nextVisitDate'] = this.nextVisitDate;
    data['visitOutcomes'] = this.visitOutcomes;
    data['remark'] = this.remark;
    data['visitSubType'] = this.visitSubType;
    data['docId'] = this.docId;
    data['dspAvailableQty'] = this.dspAvailableQty;
    data['isDspAvailable'] = this.isDspAvailable;
    return data;
  }
}

