

class MeetResponseModelView {
  String? respCode;
  String? respMsg;
  Null mwpVisitModel;
  MwpMeetModelView? mwpMeetModel;
  List<DealerModelView>? dealerModel;

  MeetResponseModelView(
      {this.respCode,
      this.respMsg,
      this.mwpVisitModel,
      this.mwpMeetModel,
      this.dealerModel});

  MeetResponseModelView.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    mwpVisitModel = json['mwpVisitModel'];

    if (!json.containsKey('mwpMeetModel'))
      mwpMeetModel = null;

    mwpMeetModel = json['mwpMeetModel'] != null
        ? new MwpMeetModelView.fromJson(json['mwpMeetModel'])
        : null;

    if (!json.containsKey('dealerModel'))
      dealerModel = new List<DealerModelView>.empty(growable: true);

    if (json['dealerModel'] != null) {
      dealerModel = new List<DealerModelView>.empty(growable: true);
      json['dealerModel'].forEach((v) {
        dealerModel!.add(new DealerModelView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['mwpVisitModel'] = this.mwpVisitModel;
    if (this.mwpMeetModel != null) {
      data['mwpMeetModel'] = this.mwpMeetModel!.toJson();
    }
    if (this.dealerModel != null) {
      data['dealerModel'] = this.dealerModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MwpMeetModelView {
  int? id;
  String? meetType;
  String? meetDate;
  int? dalmiaInflCount;
  int? nonDalmiaInflCount;
  String? venue;
  int? expectedLeadsCount;
  int? giftsDistributedCount;
  String? eventLocation;
  String? isSaveDraft;
  List<MwpMeetDealersView>? mwpMeetDealers;

  MwpMeetModelView(
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
      this.mwpMeetDealers});

  MwpMeetModelView.fromJson(Map<String, dynamic> json) {
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
    if (json['mwpMeetDealers'] != null) {
      mwpMeetDealers = new List<MwpMeetDealersView>.empty(growable: true);
      json['mwpMeetDealers'].forEach((v) {
        mwpMeetDealers!.add(new MwpMeetDealersView.fromJson(v));
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
    if (this.mwpMeetDealers != null) {
      data['mwpMeetDealers'] =
          this.mwpMeetDealers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MwpMeetDealersView {
  int? id;
  int? mwpMeetId;
  String? dealerId;
  String? dealerName;

  MwpMeetDealersView({this.id, this.mwpMeetId, this.dealerId, this.dealerName});

  MwpMeetDealersView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mwpMeetId = json['mwpMeetId'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mwpMeetId'] = this.mwpMeetId;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}

class DealerModelView {
  String? dealerId;
  String? dealerName;

  DealerModelView({this.dealerId, this.dealerName});

  DealerModelView.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}
