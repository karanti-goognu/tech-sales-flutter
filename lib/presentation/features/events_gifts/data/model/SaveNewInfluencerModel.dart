

class SaveNewInfluencerModel {
  String? ilpIntrested;
  int? influencerCategoryId;
  String? influencerName;
  int? influencerTypeId;
  String? mobileNumber;
  String? ilpRegFlag;

  SaveNewInfluencerModel(
      {this.ilpIntrested,
        this.influencerCategoryId,
        this.influencerName,
        this.influencerTypeId,
        this.mobileNumber,
        this.ilpRegFlag
      });

  SaveNewInfluencerModel.fromJson(Map<String, dynamic> json) {
    ilpIntrested = json['ilp_intrested'];
    influencerCategoryId = json['influencer_category_id'];
    influencerName = json['influencer_name'];
    influencerTypeId = json['influencer_type_id'];
    mobileNumber = json['mobile_number'];
    ilpRegFlag = json['ilpRegFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilp_intrested'] = this.ilpIntrested;
    data['influencer_category_id'] = this.influencerCategoryId;
    data['influencer_name'] = this.influencerName;
    data['influencer_type_id'] = this.influencerTypeId;
    data['mobile_number'] = this.mobileNumber;
    data['ilpRegFlag'] = this.ilpRegFlag;
    return data;
  }
}

