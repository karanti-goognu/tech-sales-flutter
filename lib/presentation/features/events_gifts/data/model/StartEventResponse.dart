

class StartEventResponse {
  String eventDate;
  int eventID;
  int eventTypeId;
  String eventTypeText;
  String respCode;
  String respMsg;

  StartEventResponse(
      {this.eventDate,
        this.eventID,
        this.eventTypeId,
        this.eventTypeText,
        this.respCode,
        this.respMsg});

  StartEventResponse.fromJson(Map<String, dynamic> json) {
    eventDate = json['eventDate'];
    eventID = json['eventID'];
    eventTypeId = json['eventTypeId'];
    eventTypeText = json['eventTypeText'];
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventDate'] = this.eventDate;
    data['eventID'] = this.eventID;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeText'] = this.eventTypeText;
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

