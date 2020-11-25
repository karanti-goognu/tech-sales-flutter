class JourneyModel {
  JourneyEntity journeyEntity;
  String respCode;
  String respMsg;

  JourneyModel({this.journeyEntity, this.respCode, this.respMsg});

  JourneyModel.fromJson(Map<String, dynamic> json) {
    journeyEntity = json['journeyEntity'] != null
        ? new JourneyEntity.fromJson(json['journeyEntity'])
        : null;
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.journeyEntity != null) {
      data['journeyEntity'] = this.journeyEntity.toJson();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class JourneyEntity {
  int id;
  String referenceId;
  String journeyDate;
  String journeyStartTime;
  String journeyStartLat;
  String journeyStartLong;
  String journeyEndTime;
  String journeyEndLat;
  String journeyEndLong;

  JourneyEntity(
      {this.id,
        this.referenceId,
        this.journeyDate,
        this.journeyStartTime,
        this.journeyStartLat,
        this.journeyStartLong,
        this.journeyEndTime,
        this.journeyEndLat,
        this.journeyEndLong});

  JourneyEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['referenceId'];
    journeyDate = json['journeyDate'];
    journeyStartTime = json['journeyStartTime'];
    journeyStartLat = json['journeyStartLat'];
    journeyStartLong = json['journeyStartLong'];
    journeyEndTime = json['journeyEndTime'];
    journeyEndLat = json['journeyEndLat'];
    journeyEndLong = json['journeyEndLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referenceId'] = this.referenceId;
    data['journeyDate'] = this.journeyDate;
    data['journeyStartTime'] = this.journeyStartTime;
    data['journeyStartLat'] = this.journeyStartLat;
    data['journeyStartLong'] = this.journeyStartLong;
    data['journeyEndTime'] = this.journeyEndTime;
    data['journeyEndLat'] = this.journeyEndLat;
    data['journeyEndLong'] = this.journeyEndLong;
    return data;
  }
}