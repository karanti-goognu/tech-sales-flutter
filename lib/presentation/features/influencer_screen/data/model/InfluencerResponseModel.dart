class InfluencerResponseModel {
  Response response;

  InfluencerResponseModel({this.response});

  InfluencerResponseModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  String respCode;
  String respMsg;
  String membershipId;
  String influencerContact;
  String influencerName;
  String inFlTypeId;

  Response(
      {this.respCode,
        this.respMsg,
        this.membershipId,
        this.influencerContact,
        this.influencerName,
        this.inFlTypeId});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    membershipId = json['membershipId'];
    influencerContact = json['influencerContact'];
    influencerName = json['influencerName'];
    inFlTypeId = json['inFlTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['membershipId'] = this.membershipId;
    data['influencerContact'] = this.influencerContact;
    data['influencerName'] = this.influencerName;
    data['inFlTypeId'] = this.inFlTypeId;
    return data;
  }
}

