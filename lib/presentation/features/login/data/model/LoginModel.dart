

class LoginModel {
  String? respCode;
  String? respMsg;
  String? otpTokenId;
  String? otpSmsTime;
  String? otpRetrySmsTime;

  LoginModel(
      {this.respCode,
      this.respMsg,
      this.otpTokenId,
      this.otpSmsTime,
      this.otpRetrySmsTime});

  static LoginModel fromMap(Map<String, dynamic> json) {
    return LoginModel(
        respCode: json['resp-code'],
        respMsg: json['resp-msg'],
        otpTokenId: json['otp-token-id'],
        otpSmsTime: json['otp-sms-time'],
        otpRetrySmsTime: json['otp-retry-sms-time']);
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    otpTokenId = json['otp-token-id'];
    otpSmsTime = json['otp-sms-time'];
    otpRetrySmsTime = json['otp-retry-sms-time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['otp-token-id'] = this.otpTokenId;
    data['otp-sms-time'] = this.otpSmsTime;
    data['otp-retry-sms-time'] = this.otpRetrySmsTime;
    return data;
  }
}
