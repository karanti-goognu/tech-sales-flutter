class SaveEventResponse {
  String respCode;
  String respMsg;
  String eventId;
  String referenceId;

  SaveEventResponse({this.respCode, this.respMsg, this.eventId, this.referenceId});

  SaveEventResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    eventId = json['eventId'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['eventId'] = this.eventId;
    data['referenceId'] = this.referenceId;
    return data;
  }
}