class UpdateDealerInfModel {
  List<EventDealerRequestsList> eventDealerRequestsList;
  List<EventInfluencerRequestsList> eventInfluencerRequestsList;
  String referenceID;

  UpdateDealerInfModel(
      {this.eventDealerRequestsList,
        this.eventInfluencerRequestsList,
        this.referenceID});

  UpdateDealerInfModel.fromJson(Map<String, dynamic> json) {
    if (json['event_dealer_requests_list'] != null) {
      eventDealerRequestsList = new List<EventDealerRequestsList>();
      json['event_dealer_requests_list'].forEach((v) {
        eventDealerRequestsList.add(new EventDealerRequestsList.fromJson(v));
      });
    }
    if (json['event_influencer_requests_list'] != null) {
      eventInfluencerRequestsList = new List<EventInfluencerRequestsList>();
      json['event_influencer_requests_list'].forEach((v) {
        eventInfluencerRequestsList
            .add(new EventInfluencerRequestsList.fromJson(v));
      });
    }
    referenceID = json['referenceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventDealerRequestsList != null) {
      data['event_dealer_requests_list'] =
          this.eventDealerRequestsList.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerRequestsList != null) {
      data['event_influencer_requests_list'] =
          this.eventInfluencerRequestsList.map((v) => v.toJson()).toList();
    }
    data['referenceID'] = this.referenceID;
    return data;
  }
}

class EventDealerRequestsList {
  String createdBy;
  String createdOn;
  String dealerId;
  String dealerName;
  int eventDealerId;
  int eventId;
  String eventStage;
  String isActive;
  String modifiedBy;
  String modifiedOn;

  EventDealerRequestsList(
      {this.createdBy,
        this.createdOn,
        this.dealerId,
        this.dealerName,
        this.eventDealerId,
        this.eventId,
        this.eventStage,
        this.isActive,
        this.modifiedBy,
        this.modifiedOn});

  EventDealerRequestsList.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
    eventDealerId = json['eventDealerId'];
    eventId = json['eventId'];
    eventStage = json['eventStage'];
    isActive = json['isActive'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    data['eventDealerId'] = this.eventDealerId;
    data['eventId'] = this.eventId;
    data['eventStage'] = this.eventStage;
    data['isActive'] = this.isActive;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}

class EventInfluencerRequestsList {
  int eventId;
  int eventInflId;
  String inflContact;
  int inflId;
  String inflName;
  int inflTypeId;
  String isActive;

  EventInfluencerRequestsList(
      {this.eventId,
        this.eventInflId,
        this.inflContact,
        this.inflId,
        this.inflName,
        this.inflTypeId,
        this.isActive});

  EventInfluencerRequestsList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventInflId = json['eventInflId'];
    inflContact = json['inflContact'];
    inflId = json['inflId'];
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventInflId'] = this.eventInflId;
    data['inflContact'] = this.inflContact;
    data['inflId'] = this.inflId;
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
    data['isActive'] = this.isActive;
    return data;
  }
}

