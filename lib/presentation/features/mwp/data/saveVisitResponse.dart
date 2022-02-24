class SaveVisitResponse {
  String? respCode;
  String? respMsg;

  SaveVisitResponse({this.respCode, this.respMsg});

  SaveVisitResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}