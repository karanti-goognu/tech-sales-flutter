

class StartEventResponse {
  String? respCode;
  String? respMsg;
  late int eventID;
  int? eventTypeId;
  String? eventTypeText;
  int? eventDate;

  StartEventResponse(
      {this.respCode,
        this.respMsg,
       required this.eventID,
        this.eventTypeId,
        this.eventTypeText,
        this.eventDate});

  StartEventResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    eventID = json['eventID'];
    eventTypeId = json['eventTypeId'];
    eventTypeText = json['eventTypeText'];
    eventDate = json['eventDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['eventID'] = this.eventID;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeText'] = this.eventTypeText;
    data['eventDate'] = this.eventDate;
    return data;
  }
}

