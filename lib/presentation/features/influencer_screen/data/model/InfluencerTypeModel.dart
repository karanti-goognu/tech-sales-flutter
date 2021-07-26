class InfluencerTypeModel {
  String respCode;
  String respMsg;
  List<InfluencerTypeList> influencerTypeList;
  List<InfluencerCategoryList> influencerCategoryList;
  List<InfluencerSourceList> influencerSourceList;

  InfluencerTypeModel(
      {this.respCode,
        this.respMsg,
        this.influencerTypeList,
        this.influencerCategoryList,
        this.influencerSourceList});

  InfluencerTypeModel.fromJson(Map<String, dynamic> json) {
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

class InfluencerCategoryList {
  int inflCatId;
  String inflCatText;

  InfluencerCategoryList({this.inflCatId, this.inflCatText});

  InfluencerCategoryList.fromJson(Map<String, dynamic> json) {
    inflCatId = json['infl_cat_id'];
    inflCatText = json['infl_cat_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_cat_id'] = this.inflCatId;
    data['infl_cat_text'] = this.inflCatText;
    return data;
  }
}

class InfluencerSourceList {
  int inflSourceId;
  String inflSourceText;

  InfluencerSourceList({this.inflSourceId, this.inflSourceText});

  InfluencerSourceList.fromJson(Map<String, dynamic> json) {
    inflSourceId = json['infl_source_id'];
    inflSourceText = json['infl_source_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_source_id'] = this.inflSourceId;
    data['infl_source_text'] = this.inflSourceText;
    return data;
  }
}

