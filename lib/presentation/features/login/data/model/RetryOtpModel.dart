class RetryOtpModel {
  String respCode;
  String respMsg;

  RetryOtpModel(
      {this.respCode,
      this.respMsg,});

  static RetryOtpModel fromMap(Map<String, dynamic> json) {
    if (json == null) return null;

    //{"resp-code":"DM1011","resp-msg":"OTP generated successfully","otp-sms-time":"900000","otp-retry-sms-time":"180000"}
    return RetryOtpModel(
        respCode: json['resp-code'],
        respMsg: json['resp-msg'],
    );
  }

  RetryOtpModel.fromJson(Map<String, dynamic> json) {
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
