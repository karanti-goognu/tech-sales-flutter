class InfluencerTypeModel {
  Response response;

  InfluencerTypeModel({this.response});

  InfluencerTypeModel.fromJson(Map<String, dynamic> json) {
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
  List<InfluencerCategoryList> influencerCategoryList;
  List<InfluencerSourceList> influencerSourceList;
  List<SiteBrandList> siteBrandList;

  Response(
      {this.respCode,
        this.respMsg,
        this.influencerTypeList,
        this.influencerCategoryList,
        this.influencerSourceList,
        this.siteBrandList});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['influencerTypeList'] != null) {
      influencerTypeList = new List<InfluencerTypeList>();
      json['influencerTypeList'].forEach((v) {
        influencerTypeList.add(new InfluencerTypeList.fromJson(v));
      });
    }
    if (json['influencerCategoryList'] != null) {
      influencerCategoryList = new List<InfluencerCategoryList>();
      json['influencerCategoryList'].forEach((v) {
        influencerCategoryList.add(new InfluencerCategoryList.fromJson(v));
      });
    }
    if (json['influencerSourceList'] != null) {
      influencerSourceList = new List<InfluencerSourceList>();
      json['influencerSourceList'].forEach((v) {
        influencerSourceList.add(new InfluencerSourceList.fromJson(v));
      });
    }

    if (json['siteBrandList'] != null) {
      siteBrandList = new List<SiteBrandList>();
      json['siteBrandList'].forEach((v) {
        siteBrandList.add(new SiteBrandList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerTypeList != null) {
      data['influencerTypeList'] =
          this.influencerTypeList.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryList != null) {
      data['influencerCategoryList'] =
          this.influencerCategoryList.map((v) => v.toJson()).toList();
    }

    if (this.influencerSourceList != null) {
      data['influencerSourceList'] =
          this.influencerSourceList.map((v) => v.toJson()).toList();
    }

    if (this.siteBrandList != null) {
      data['siteBrandList'] =
          this.siteBrandList.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class InfluencerTypeList {
  int inflTypeId;
  String inflTypeDesc;
  String infRegFlag;

  InfluencerTypeList({this.inflTypeId, this.inflTypeDesc, this.infRegFlag});

  InfluencerTypeList.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
    infRegFlag = json['infRegFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    data['infRegFlag'] = this.infRegFlag;
    return data;
  }
}

class InfluencerCategoryList {
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryList({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryList.fromJson(Map<String, dynamic> json) {
    inflCatId = json['inflCatId'];
    inflCatDesc = json['inflCatDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflCatId'] = this.inflCatId;
    data['inflCatDesc'] = this.inflCatDesc;
    return data;
  }
}

class InfluencerSourceList {
  int inflSourceId;
  String inflSourceText;

  InfluencerSourceList({this.inflSourceId, this.inflSourceText});

  InfluencerSourceList.fromJson(Map<String, dynamic> json) {
    inflSourceId = json['inflSourceId'];
    inflSourceText = json['inflSourceText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflSourceId'] = this.inflSourceId;
    data['inflSourceText'] = this.inflSourceText;
    return data;
  }
}

class SiteBrandList {
  int id;
  String brandName;
  String productName;
  String isPrimary;

  SiteBrandList({this.id, this.brandName,this.productName,this.isPrimary});

  SiteBrandList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    productName = json['productName'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    data['productName'] = this.productName;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

