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
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryEntity({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
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

class InfluencerTypeEntity {
  int inflTypeId;
  String inflTypeDesc;

  InfluencerTypeEntity({this.inflTypeId, this.inflTypeDesc});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    inflTypeId= json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    return data;
  }
}
