class UpdateMeetRequest {
  MwpMeetModel mwpMeetModel;

  UpdateMeetRequest({this.mwpMeetModel});

  UpdateMeetRequest.fromJson(Map<String, dynamic> json) {
    mwpMeetModel = json['mwpMeetModel'] != null
        ? new MwpMeetModel.fromJson(json['mwpMeetModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mwpMeetModel != null) {
      data['mwpMeetModel'] = this.mwpMeetModel.toJson();
    }
    return data;
  }
}

class MwpMeetModel {
  int id;
  String meetType;
  String meetDate;
  int dalmiaInflCount;
  int nonDalmiaInflCount;
  String venue;
  int expectedLeadsCount;
  int giftsDistributedCount;
  String eventLocation;
  String isSaveDraft;
  String updatedBy;
  List<MwpMeetDealersUpdate> mwpMeetDealers;

  MwpMeetModel(
      {this.id,
        this.meetType,
        this.meetDate,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.venue,
        this.expectedLeadsCount,
        this.giftsDistributedCount,
        this.eventLocation,
        this.isSaveDraft,
        this.updatedBy,
        this.mwpMeetDealers});

  MwpMeetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetType = json['meetType'];
    meetDate = json['meetDate'];
    dalmiaInflCount = json['dalmiaInflCount'];
    nonDalmiaInflCount = json['nonDalmiaInflCount'];
    venue = json['venue'];
    expectedLeadsCount = json['expectedLeadsCount'];
    giftsDistributedCount = json['giftsDistributedCount'];
    eventLocation = json['eventLocation'];
    isSaveDraft = json['isSaveDraft'];
    updatedBy = json['updatedBy'];
    if (json['mwpMeetDealers'] != null) {
      mwpMeetDealers = new List<MwpMeetDealersUpdate>();
      json['mwpMeetDealers'].forEach((v) {
        mwpMeetDealers.add(new MwpMeetDealersUpdate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meetType'] = this.meetType;
    data['meetDate'] = this.meetDate;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
    data['venue'] = this.venue;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['giftsDistributedCount'] = this.giftsDistributedCount;
    data['eventLocation'] = this.eventLocation;
    data['isSaveDraft'] = this.isSaveDraft;
    data['updatedBy'] = this.updatedBy;
    if (this.mwpMeetDealers != null) {
      data['mwpMeetDealers'] =
          this.mwpMeetDealers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MwpMeetDealersUpdate {
  int id;
  int mwpMeetId;
  String dealerId;

  MwpMeetDealersUpdate({this.id, this.mwpMeetId, this.dealerId});

  MwpMeetDealersUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mwpMeetId = json['mwpMeetId'];
    dealerId = json['dealerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mwpMeetId'] = this.mwpMeetId;
    data['dealerId'] = this.dealerId;
    return data;
  }
}