class AccessKeyModel {
  String accessKey;
  String respCode;
  String respMsg;

  AccessKeyModel({this.accessKey, this.respCode, this.respMsg});

  AccessKeyModel.fromJson(Map<String, dynamic> json) {
    this.accessKey = json['access-key'];
    this.respCode = json['resp-code'];
    this.respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access-key'] = this.accessKey;
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}
