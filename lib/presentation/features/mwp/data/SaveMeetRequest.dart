class SaveMeetRequest {
  String referenceId;
  String eventType;
  String visitMeetType;
  String visitMeetDate;
  int dalmiaInflCount;
  int nonDalmiaInflCount;
  String venue;
  int expectedLeadsCount;
  int giftsDistributedCount;
  String eventLocation;
  String isSaveDraft;
  String createdBy;
  List<MwpMeetDealers> mwpMeetDealers;

  SaveMeetRequest(
      this.referenceId,
        this.eventType,
        this.visitMeetType,
        this.visitMeetDate,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.venue,
        this.expectedLeadsCount,
        this.giftsDistributedCount,
        this.eventLocation,
        this.isSaveDraft,
        this.createdBy,
        this.mwpMeetDealers);

  SaveMeetRequest.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    eventType = json['eventType'];
    visitMeetType = json['visitMeetType'];
    visitMeetDate = json['visitMeetDate'];
    dalmiaInflCount = json['dalmiaInflCount'];
    nonDalmiaInflCount = json['nonDalmiaInflCount'];
    venue = json['venue'];
    expectedLeadsCount = json['expectedLeadsCount'];
    giftsDistributedCount = json['giftsDistributedCount'];
    eventLocation = json['eventLocation'];
    isSaveDraft = json['isSaveDraft'];
    createdBy = json['createdBy'];
    if (json['mwpMeetDealers'] != null) {
      mwpMeetDealers = new List<MwpMeetDealers>();
      json['mwpMeetDealers'].forEach((v) {
        mwpMeetDealers.add(new MwpMeetDealers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceId'] = this.referenceId;
    data['eventType'] = this.eventType;
    data['visitMeetType'] = this.visitMeetType;
    data['visitMeetDate'] = this.visitMeetDate;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
    data['venue'] = this.venue;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['giftsDistributedCount'] = this.giftsDistributedCount;
    data['eventLocation'] = this.eventLocation;
    data['isSaveDraft'] = this.isSaveDraft;
    data['createdBy'] = this.createdBy;
    if (this.mwpMeetDealers != null) {
      data['mwpMeetDealers'] =
          this.mwpMeetDealers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MwpMeetDealers {
  String dealerId;

  MwpMeetDealers({this.dealerId});

  MwpMeetDealers.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    return data;
  }
}