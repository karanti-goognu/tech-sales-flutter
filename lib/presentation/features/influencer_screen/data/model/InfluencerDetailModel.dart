import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeEntitiesListModel.dart';

class InfluencerDetailModel {
  String? respCode;
  String? respMsg;
  String? mobileNumber;
  InfluencerModel? influencerModel;
  List<InfluencerTypeEntitiesList>? influencerTypeEntitiesList;
  List<InfluencerCategoryEntitiesList>? influencerCategoryEntitiesList;

  InfluencerDetailModel(
      {this.respCode,
      this.respMsg,
      this.mobileNumber,
      this.influencerModel,
      this.influencerTypeEntitiesList,
      this.influencerCategoryEntitiesList});

  InfluencerDetailModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    mobileNumber = json['mobile_number'];

    if (!json.containsKey('influencer_model')) influencerModel = null;

    influencerModel = json['influencer_model'] != null
        ? new InfluencerModel.fromJson(json['influencer_model'])
        : null;

    if (!json.containsKey('influencer_type_entities_list'))
      influencerTypeEntitiesList =
          new List<InfluencerTypeEntitiesList>.empty(growable: true);

    if (json['influencer_type_entities_list'] != null) {
      influencerTypeEntitiesList =
          new List<InfluencerTypeEntitiesList>.empty(growable: true);
      json['influencer_type_entities_list'].forEach((v) {
        influencerTypeEntitiesList!
            .add(new InfluencerTypeEntitiesList.fromJson(v));
      });
    }

    if (!json.containsKey('influencer_category_entities_list'))
      influencerCategoryEntitiesList =
          new List<InfluencerCategoryEntitiesList>.empty(growable: true);
    if (json['influencer_category_entities_list'] != null) {
      influencerCategoryEntitiesList =
          new List<InfluencerCategoryEntitiesList>.empty(growable: true);
      json['influencer_category_entities_list'].forEach((v) {
        influencerCategoryEntitiesList!
            .add(new InfluencerCategoryEntitiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['mobile_number'] = this.mobileNumber;
    if (this.influencerModel != null) {
      data['influencer_model'] = this.influencerModel!.toJson();
    }

    if (this.influencerTypeEntitiesList != null) {
      data['influencer_type_entities_list'] =
          this.influencerTypeEntitiesList!.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntitiesList != null) {
      data['influencer_category_entities_list'] =
          this.influencerCategoryEntitiesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfluencerModel {
  String? ilpRegFlag;
  int? inflId;
  String? inflName;
  String? inflContact;
  int? inflTypeId;
  String? influencerTypeText;
  int? inflCatId;
  String? influencerCategoryText;
  String? ilpMember;
  int? sitesCount;
  int? monthlyPotential;
  int? monthlyLifting;

  InfluencerModel(
      {this.ilpRegFlag,
      this.inflId,
      this.inflName,
      this.inflContact,
      this.inflTypeId,
      this.influencerTypeText,
      this.inflCatId,
      this.influencerCategoryText,
      this.ilpMember,
      this.sitesCount,
      this.monthlyPotential,
      this.monthlyLifting});

  InfluencerModel.fromJson(Map<String, dynamic> json) {
    ilpRegFlag = json['ilp_reg_flag'];
    inflId = json['infl_id'];
    inflName = json['infl_name'];
    inflContact = json['infl_contact'];
    inflTypeId = json['infl_type_id'];
    influencerTypeText = json['influencer_type_text'];
    inflCatId = json['infl_cat_id'];
    influencerCategoryText = json['influencer_category_text'];
    ilpMember = json['ilpMember'];
    sitesCount = json['sitesCount'];
    monthlyPotential = json['monthlyPotential'];
    monthlyLifting = json['monthlyLifting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilp_reg_flag'] = this.ilpRegFlag;
    data['infl_id'] = this.inflId;
    data['infl_name'] = this.inflName;
    data['infl_contact'] = this.inflContact;
    data['infl_type_id'] = this.inflTypeId;
    data['influencer_type_text'] = this.influencerTypeText;
    data['infl_cat_id'] = this.inflCatId;
    data['influencer_category_text'] = this.influencerCategoryText;
    data['ilpMember'] = this.ilpMember;
    data['sitesCount'] = this.sitesCount;
    data['monthlyPotential'] = this.monthlyPotential;
    data['monthlyLifting'] = this.monthlyLifting;
    return data;
  }
}

class InfluencerCategoryEntitiesList {
  int? inflCatId;
  String? inflCatDesc;

  InfluencerCategoryEntitiesList({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntitiesList.fromJson(Map<String, dynamic> json) {
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
