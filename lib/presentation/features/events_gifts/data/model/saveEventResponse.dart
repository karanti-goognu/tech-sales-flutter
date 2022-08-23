

class SaveEventResponse {
  String? respCode;
  String? respMsg;
  String? referenceId;
  int? eventId;

  SaveEventResponse(
      {this.respCode, this.respMsg, this.referenceId, this.eventId});

  SaveEventResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    referenceId = json['referenceId'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['referenceId'] = this.referenceId;
    data['eventId'] = this.eventId;
    return data;
  }
}

