

class DealerInfModel {
  String? respCode;
  String? respMsg;
  List<EventDealersModelList>? eventDealersModelList;
  List<EventInfluencerModelList>? eventInfluencerModelList;
  List<DealersModel>? dealersModel;

  DealerInfModel(
      {this.respCode,
        this.respMsg,
        this.eventDealersModelList,
        this.eventInfluencerModelList,
        this.dealersModel});

  DealerInfModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['event-dealers-model-list'] != null) {
      eventDealersModelList = new List<EventDealersModelList>.empty(growable: true);
      json['event-dealers-model-list'].forEach((v) {
        eventDealersModelList!.add(new EventDealersModelList.fromJson(v));
      });
    }
    if (json['event-influencer-model-list'] != null) {
      eventInfluencerModelList = new List<EventInfluencerModelList>.empty(growable: true);
      json['event-influencer-model-list'].forEach((v) {
        eventInfluencerModelList!.add(new EventInfluencerModelList.fromJson(v));
      });
    }
    if (json['dealers-model'] != null) {
      dealersModel = new List<DealersModel>.empty(growable: true);
      json['dealers-model'].forEach((v) {
        dealersModel!.add(new DealersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.eventDealersModelList != null) {
      data['event-dealers-model-list'] =
          this.eventDealersModelList!.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerModelList != null) {
      data['event-influencer-model-list'] =
          this.eventInfluencerModelList!.map((v) => v.toJson()).toList();
    }
    if (this.dealersModel != null) {
      data['dealers-model'] = this.dealersModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventDealersModelList {
  int? eventDealerId;
  int? eventId;
  String? dealerId;
  String? dealerName;
  String? eventStage;
  String? isActive;

  EventDealersModelList(
      {this.eventDealerId,
        this.eventId,
        this.dealerId,
        this.dealerName,
        this.eventStage,
        this.isActive});

  EventDealersModelList.fromJson(Map<String, dynamic> json) {
    eventDealerId = json['eventDealerId'];
    eventId = json['eventId'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
    eventStage = json['eventStage'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventDealerId'] = this.eventDealerId;
    data['eventId'] = this.eventId;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    data['eventStage'] = this.eventStage;
    data['isActive'] = this.isActive;
    return data;
  }
}

class EventInfluencerModelList {
  int? eventId;
  int? eventInflId;
  String? inflContact;
  int? inflId;
  String? inflName;
  int? inflTypeId;
  String? isActive;


  EventInfluencerModelList(
      {this.eventId,
        this.eventInflId,
        this.inflContact,
        this.inflId,
        this.inflName,
        this.inflTypeId,
        this.isActive});

  EventInfluencerModelList.fromJson(Map<String, dynamic> json) {
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

class DealersModel {
  String? dealerId;
  String? dealerName;

  DealersModel({this.dealerId, this.dealerName});

  DealersModel.fromJson(Map<String, dynamic> json) {
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

