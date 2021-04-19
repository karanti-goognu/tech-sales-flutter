class AddEventModel {
  String respCode;
  String respMsg;
  List<EventTypeModels> eventTypeModels;
  List<Null> dealersModels;

  AddEventModel(
      {this.respCode, this.respMsg, this.eventTypeModels, this.dealersModels});

  AddEventModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['eventTypeModels'] != null) {
      eventTypeModels = new List<EventTypeModels>();
      json['eventTypeModels'].forEach((v) {
        eventTypeModels.add(new EventTypeModels.fromJson(v));
      });
    }
    if (json['dealersModels'] != null) {
      dealersModels = new List<Null>();
      json['dealersModels'].forEach((v) {
       // dealersModels.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.eventTypeModels != null) {
      data['eventTypeModels'] =
          this.eventTypeModels.map((v) => v.toJson()).toList();
    }
    if (this.dealersModels != null) {
      // data['dealersModels'] =
      //     this.dealersModels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventTypeModels {
  int eventTypeId;
  String eventTypeText;

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

