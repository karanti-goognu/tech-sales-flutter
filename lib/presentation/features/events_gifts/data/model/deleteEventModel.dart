

class DeleteEventModel {
  int? eventId;
  String? referenceId;
  String? respCode;
  String? respMsg;

  DeleteEventModel(
      {this.eventId, this.referenceId, this.respCode, this.respMsg});

  DeleteEventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    referenceId = json['referenceId'];
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['referenceId'] = this.referenceId;
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

