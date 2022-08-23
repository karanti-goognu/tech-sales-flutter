

import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeEntitiesListModel.dart';

class InfluencerViewModel {
  String? respCode;
  String? respMsg;
  InfluencerModel? influencerModel;
  List<InfluencerTypeEntitiesList>? influencerTypeEntitiesList;
  List<CategoryEntitiesList>? categoryEntitiesList;

  InfluencerViewModel(
      {this.respCode,
        this.respMsg,
        this.influencerModel,
        this.influencerTypeEntitiesList,
        this.categoryEntitiesList});

  InfluencerViewModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];

    if(!json.containsKey('influencerModel'))
      influencerModel = null;

    influencerModel = json['influencerModel'] != null
        ? new InfluencerModel.fromJson(json['influencerModel'])
        : null;

    if(!json.containsKey('influencerTypeEntitiesList'))
      influencerTypeEntitiesList = new List<InfluencerTypeEntitiesList>.empty(growable: true);

    if (json['influencerTypeEntitiesList'] != null) {
      influencerTypeEntitiesList = new List<InfluencerTypeEntitiesList>.empty(growable: true);
      json['influencerTypeEntitiesList'].forEach((v) {
        influencerTypeEntitiesList!
            .add(new InfluencerTypeEntitiesList.fromJson(v));
      });
    }

    if(!json.containsKey('categoryEntitiesList'))
      categoryEntitiesList = new List<CategoryEntitiesList>.empty(growable: true);

    if (json['categoryEntitiesList'] != null) {
      categoryEntitiesList = new List<CategoryEntitiesList>.empty(growable: true);
      json['categoryEntitiesList'].forEach((v) {
        categoryEntitiesList!.add(new CategoryEntitiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerModel != null) {
      data['influencerModel'] = this.influencerModel!.toJson();
    }
    if (this.influencerTypeEntitiesList != null) {
      data['influencerTypeEntitiesList'] =
          this.influencerTypeEntitiesList!.map((v) => v.toJson()).toList();
    }
    if (this.categoryEntitiesList != null) {
      data['categoryEntitiesList'] =
          this.categoryEntitiesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfluencerModel {
  String? inflName;
  int? inflTypeId;
  String? mobileNumber;

  InfluencerModel({this.inflName, this.inflTypeId, this.mobileNumber});

  InfluencerModel.fromJson(Map<String, dynamic> json) {
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}

class CategoryEntitiesList {
  int? inflCatId;
  String? inflCatDesc;

  CategoryEntitiesList({this.inflCatId, this.inflCatDesc});

  CategoryEntitiesList.fromJson(Map<String, dynamic> json) {
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

