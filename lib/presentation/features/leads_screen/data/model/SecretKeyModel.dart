class SecretKeyModel {
  String respCode;
  String respMsg;
  String secretKey;

  SecretKeyModel({this.respCode, this.respMsg, this.secretKey});

  SecretKeyModel.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    secretKey = json['secret-key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['secret-key'] = this.secretKey;
    return data;
  }
}
