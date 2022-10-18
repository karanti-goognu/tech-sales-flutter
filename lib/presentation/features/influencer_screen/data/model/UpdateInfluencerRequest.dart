class UpdateInfluencerRequest {
  int? docId;
  int? inflId;
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
  String? totalSites;
  String? dalmiaSites;
  String? totalBags;
  String? dalmiaBags;

  UpdateInfluencerRequest(
      {this.docId,
      this.inflId,
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
      this.visitType,
      this.totalSites,
      this.dalmiaSites,
      this.totalBags,
      this.dalmiaBags});

  UpdateInfluencerRequest.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    inflId = json['inflId'];
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
    totalSites = json['totalSites'];
    dalmiaSites = json['dalmiaSites'];
    totalBags = json['totalBags'];
    dalmiaBags = json['dalmiaBags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docId'] = this.docId;
    data['inflId'] = this.inflId;
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
    data['totalSites'] = this.totalSites;
    data['dalmiaSites'] = this.dalmiaSites;
    data['totalBags'] = this.totalBags;
    data['dalmiaBags'] = this.dalmiaBags;

    return data;
  }
}
