

class MwpVisitModelUpdate {
  int? id;
  String? visitDate;
  String? visitType;
  String? visitStartTime;
  double? visitStartLat;
  double? visitStartLong;
  String? visitEndTime;
  String? nextVisitDate;
  double? visitEndLat;
  double? visitEndLong;
  String? visitOutcomes;
  String? remark;



  MwpVisitModelUpdate(
      this.id,
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
      this.remark
  );


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
    nextVisitDate= json['nextVisitDate'];
    visitOutcomes = json['visitOutcomes'];
    remark = json['remark'];
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
    return data;
  }
}