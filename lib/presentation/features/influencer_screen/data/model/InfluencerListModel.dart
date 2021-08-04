class InfluencerListModel {
  Response response;

  InfluencerListModel({this.response});

  InfluencerListModel.fromJson(Map<String, dynamic> json) {
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
  List<InfluencerTypeList> influencerTypeList;
  List<IlpInfluencerEntity> ilpInfluencerEntity;
  String totalInfluencerCount;

  Response(
      {this.respCode,
        this.respMsg,
        this.influencerTypeList,
        this.ilpInfluencerEntity,
        this.totalInfluencerCount});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['influencerTypeList'] != null) {
      influencerTypeList = new List<InfluencerTypeList>();
      json['influencerTypeList'].forEach((v) {
        influencerTypeList.add(new InfluencerTypeList.fromJson(v));
      });
    }
    if (json['ilpInfluencerEntity'] != null) {
      ilpInfluencerEntity = new List<IlpInfluencerEntity>();
      json['ilpInfluencerEntity'].forEach((v) {
        ilpInfluencerEntity.add(new IlpInfluencerEntity.fromJson(v));
      });
    }
    totalInfluencerCount = json['totalInfluencerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerTypeList != null) {
      data['influencerTypeList'] =
          this.influencerTypeList.map((v) => v.toJson()).toList();
    }
    if (this.ilpInfluencerEntity != null) {
      data['ilpInfluencerEntity'] =
          this.ilpInfluencerEntity.map((v) => v.toJson()).toList();
    }
    data['totalInfluencerCount'] = this.totalInfluencerCount;
    return data;
  }
}

class InfluencerTypeList {
  int inflTypeId;
  String inflTypeText;
  String ilpRegFlag;

  InfluencerTypeList({this.inflTypeId, this.inflTypeText, this.ilpRegFlag});

  InfluencerTypeList.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['infl_type_id'];
    inflTypeText = json['infl_type_text'];
    ilpRegFlag = json['ilp_reg_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_type_id'] = this.inflTypeId;
    data['infl_type_text'] = this.inflTypeText;
    data['ilp_reg_flag'] = this.ilpRegFlag;
    return data;
  }
}

class IlpInfluencerEntity {
  String joiningDate;
  String membershipId;
  String mobileNumber;
  String inflName;
  String inflTypeId;
  String inflTypeText;
  String monthlyPotentialVolMt;
  String stateName;
  String districtName;
  String pinCode;
  String inflCategoryId;
  String inflCategoryText;
  String baseCity;
  String email;
  String giftAddress;
  String activeSitesCount;
  String averageMonthlyVol;

  IlpInfluencerEntity(
      {this.joiningDate,
        this.membershipId,
        this.mobileNumber,
        this.inflName,
        this.inflTypeId,
        this.inflTypeText,
        this.monthlyPotentialVolMt,
        this.stateName,
        this.districtName,
        this.pinCode,
        this.inflCategoryId,
        this.inflCategoryText,
        this.baseCity,
        this.email,
        this.giftAddress,
        this.activeSitesCount,
        this.averageMonthlyVol});

  IlpInfluencerEntity.fromJson(Map<String, dynamic> json) {
    joiningDate = json['joiningDate'];
    membershipId = json['membershipId'];
    mobileNumber = json['mobileNumber'];
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
    inflTypeText = json['inflTypeText'];
    monthlyPotentialVolMt = json['monthlyPotentialVolMt'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    pinCode = json['pinCode'];
    inflCategoryId = json['inflCategoryId'];
    inflCategoryText = json['inflCategoryText'];
    baseCity = json['baseCity'];
    email = json['email'];
    giftAddress = json['giftAddress'];
    activeSitesCount = json['activeSitesCount'];
    averageMonthlyVol = json['averageMonthlyVol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['joiningDate'] = this.joiningDate;
    data['membershipId'] = this.membershipId;
    data['mobileNumber'] = this.mobileNumber;
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeText'] = this.inflTypeText;
    data['monthlyPotentialVolMt'] = this.monthlyPotentialVolMt;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['pinCode'] = this.pinCode;
    data['inflCategoryId'] = this.inflCategoryId;
    data['inflCategoryText'] = this.inflCategoryText;
    data['baseCity'] = this.baseCity;
    data['email'] = this.email;
    data['giftAddress'] = this.giftAddress;
    data['activeSitesCount'] = this.activeSitesCount;
    data['averageMonthlyVol'] = this.averageMonthlyVol;
    return data;
  }
}

