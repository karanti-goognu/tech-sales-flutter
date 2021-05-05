class InfDetailModel {
  String respCode;
  String respMsg;
  InfluencerModel influencerModel;
  List<InfluencerTypeEntitiesList> influencerTypeEntitiesList;
  List<InfluencerCategoryEntitiesList> influencerCategoryEntitiesList;

  InfDetailModel({this.respCode, this.respMsg, this.influencerModel,this.influencerTypeEntitiesList,
    this.influencerCategoryEntitiesList});

  InfDetailModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    influencerModel = json['influencer_model'] != null
        ? new InfluencerModel.fromJson(json['influencer_model'])
        : null;

    if (json['influencer_type_entities_list'] != null) {
      influencerTypeEntitiesList = new List<InfluencerTypeEntitiesList>();
      json['influencer_type_entities_list'].forEach((v) {
        influencerTypeEntitiesList
            .add(new InfluencerTypeEntitiesList.fromJson(v));
      });
    }
    if (json['influencer_category_entities_list'] != null) {
      influencerCategoryEntitiesList =
      new List<InfluencerCategoryEntitiesList>();
      json['influencer_category_entities_list'].forEach((v) {
        influencerCategoryEntitiesList
            .add(new InfluencerCategoryEntitiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerModel != null) {
      data['influencer_model'] = this.influencerModel.toJson();
    }

    if (this.influencerTypeEntitiesList != null) {
      data['influencer_type_entities_list'] =
          this.influencerTypeEntitiesList.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntitiesList != null) {
      data['influencer_category_entities_list'] =
          this.influencerCategoryEntitiesList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfluencerModel {
  String inflName;
  String inflContact;
  int inflTypeId;
  String influencerTypeText;
  int inflCatId;
  String influencerCategoryText;
  String ilpIntrested;

  InfluencerModel(
      {this.inflName,
        this.inflContact,
        this.inflTypeId,
        this.influencerTypeText,
        this.inflCatId,
        this.influencerCategoryText,
        this.ilpIntrested});

  InfluencerModel.fromJson(Map<String, dynamic> json) {
    inflName = json['infl_name'];
    inflContact = json['infl_contact'];
    inflTypeId = json['infl_type_id'];
    influencerTypeText = json['influencer_type_text'];
    inflCatId = json['infl_cat_id'];
    influencerCategoryText = json['influencer_category_text'];
    ilpIntrested = json['ilp_intrested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infl_name'] = this.inflName;
    data['infl_contact'] = this.inflContact;
    data['infl_type_id'] = this.inflTypeId;
    data['influencer_type_text'] = this.influencerTypeText;
    data['infl_cat_id'] = this.inflCatId;
    data['influencer_category_text'] = this.influencerCategoryText;
    data['ilp_intrested'] = this.ilpIntrested;
    return data;
  }
}

// class InfDetailsModel {
//   String respCode;
//   String respMsg;
//   List<InfluencerTypeEntitiesList> influencerTypeEntitiesList;
//   List<InfluencerCategoryEntitiesList> influencerCategoryEntitiesList;
//
//   InfDetailsModel(
//       {this.respCode,
//         this.respMsg,
//         this.influencerTypeEntitiesList,
//         this.influencerCategoryEntitiesList});
//
//   InfDetailsModel.fromJson(Map<String, dynamic> json) {
//     respCode = json['respCode'];
//     respMsg = json['respMsg'];
//     if (json['influencer_type_entities_list'] != null) {
//       influencerTypeEntitiesList = new List<InfluencerTypeEntitiesList>();
//       json['influencer_type_entities_list'].forEach((v) {
//         influencerTypeEntitiesList
//             .add(new InfluencerTypeEntitiesList.fromJson(v));
//       });
//     }
//     if (json['influencer_category_entities_list'] != null) {
//       influencerCategoryEntitiesList =
//       new List<InfluencerCategoryEntitiesList>();
//       json['influencer_category_entities_list'].forEach((v) {
//         influencerCategoryEntitiesList
//             .add(new InfluencerCategoryEntitiesList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['respCode'] = this.respCode;
//     data['respMsg'] = this.respMsg;
//     if (this.influencerTypeEntitiesList != null) {
//       data['influencer_type_entities_list'] =
//           this.influencerTypeEntitiesList.map((v) => v.toJson()).toList();
//     }
//     if (this.influencerCategoryEntitiesList != null) {
//       data['influencer_category_entities_list'] =
//           this.influencerCategoryEntitiesList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class InfluencerTypeEntitiesList {
  int inflTypeId;
  String inflTypeDesc;

  InfluencerTypeEntitiesList({this.inflTypeId, this.inflTypeDesc});

  InfluencerTypeEntitiesList.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntitiesList {
  int inflCatId;
  String inflCatDesc;

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



// class InfDetailsModel {
//   String msg;
//
//   InfDetailsModel({this.msg});
//
//   InfDetailsModel.fromJson(Map<String, dynamic> json) {
//     msg = json['msg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['msg'] = this.msg;
//     return data;
//   }
// }



