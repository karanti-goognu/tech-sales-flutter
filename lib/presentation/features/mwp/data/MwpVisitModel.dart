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
    visitOutcomes = json['visitOutcomes'];
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
    data['visitOutcomes'] = this.visitOutcomes;
    return data;
  }
}