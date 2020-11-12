class AddLeadInitialModel{

  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;


  AddLeadInitialModel({this.siteSubTypeEntity, this.influencerCategoryEntity,this.influencerTypeEntity });

  AddLeadInitialModel.fromJson(Map<String, dynamic> json) {
    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>();
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>();
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siteSubTypeEntity != null) {
      data['siteSubTypeEntity'] =
          this.siteSubTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerTypeEntity != null) {
      data['influencerTypeEntity'] =
          this.influencerTypeEntity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}








class SiteSubTypeEntity {
  int siteSubId;
  String siteSubTypeDesc;

  SiteSubTypeEntity({this.siteSubId, this.siteSubTypeDesc});

  SiteSubTypeEntity.fromJson(Map<String, dynamic> json) {
    siteSubId = json['siteSubId'];
    siteSubTypeDesc = json['siteSubTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteSubId'] = this.siteSubId;
    data['siteSubTypeDesc'] = this.siteSubTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntity {
  int infl_cat_id;
  String infl_cat_desc;

  InfluencerCategoryEntity({this.infl_cat_id, this.infl_cat_desc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
    infl_cat_id = json['infl_cat_id'];
    infl_cat_desc = json['infl_cat_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_cat_id'] = this.infl_cat_id;
    data['infl_cat_desc'] = this.infl_cat_desc;
    return data;
  }
}

class InfluencerTypeEntity {
  int infl_type_id;
  String infl_type_desc;

  InfluencerTypeEntity({this.infl_type_id, this.infl_type_desc});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    infl_type_id = json['infl_type_id'];
    infl_type_desc = json['infl_type_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_type_id'] = this.infl_type_id;
    data['infl_type_desc'] = this.infl_type_desc;
    return data;
  }
}
