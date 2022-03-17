

class AddEventModel {
  String? respCode;
  String? respMsg;
  List<EventTypeModels>? eventTypeModels;
  List<DealersModels>? dealersModels;
  List<StatusEntitieList>? statusEntitieList;

  AddEventModel(
      {this.respCode,
        this.respMsg,
        this.eventTypeModels,
        this.dealersModels,
        this.statusEntitieList});

  AddEventModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['eventTypeModels'] != null) {
      eventTypeModels = new List<EventTypeModels>.empty(growable: true);
      json['eventTypeModels'].forEach((v) {
        eventTypeModels!.add(new EventTypeModels.fromJson(v));
      });
    }
    if (json['dealersModels'] != null) {
      dealersModels = new List<DealersModels>.empty(growable: true);
      json['dealersModels'].forEach((v) {
        dealersModels!.add(new DealersModels.fromJson(v));
      });
    }
    if (json['statusEntitieList'] != null) {
      statusEntitieList = new List<StatusEntitieList>.empty(growable: true);
      json['statusEntitieList'].forEach((v) {
        statusEntitieList!.add(new StatusEntitieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.eventTypeModels != null) {
      data['eventTypeModels'] =
          this.eventTypeModels!.map((v) => v.toJson()).toList();
    }
    if (this.dealersModels != null) {
      data['dealersModels'] =
          this.dealersModels!.map((v) => v.toJson()).toList();
    }
    if (this.statusEntitieList != null) {
      data['statusEntitieList'] =
          this.statusEntitieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventTypeModels {
  int? eventTypeId;
  String? eventTypeText;

  EventTypeModels({this.eventTypeId, this.eventTypeText});

  EventTypeModels.fromJson(Map<String, dynamic> json) {
    eventTypeId = json['eventTypeId'];
    eventTypeText = json['eventTypeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeText'] = this.eventTypeText;
    return data;
  }
}

class DealersModels {
  String? dealerId;
  String? dealerName;

  DealersModels({this.dealerId, this.dealerName});

  DealersModels.fromJson(Map<String, dynamic> json) {
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

class StatusEntitieList {
  int? eventStatusId;
  String? eventStatusText;

  StatusEntitieList({this.eventStatusId, this.eventStatusText});

  StatusEntitieList.fromJson(Map<String, dynamic> json) {
    eventStatusId = json['eventStatusId'];
    eventStatusText = json['eventStatusText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatusText'] = this.eventStatusText;
    return data;
  }
}

