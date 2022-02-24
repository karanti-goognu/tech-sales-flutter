class SaveMWPResponse {
  String? respCode;
  String? respMsg;

  SaveMWPResponse({this.respCode, this.respMsg});

  SaveMWPResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}
