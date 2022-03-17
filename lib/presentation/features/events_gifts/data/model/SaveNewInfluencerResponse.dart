

class SaveNewInfluencerResponse {
  String? ilpInterested;
  int? influencerCategoryId;
  String? influencerCategoryText;
  String? influencerName;
  int? influencerTypeId;
  String? influencerTypeText;
  String? mobileNumber;
  String? respCode;
  String? respMsg;
  int? inflId;

  SaveNewInfluencerResponse(
      {this.ilpInterested,
        this.influencerCategoryId,
        this.influencerCategoryText,
        this.influencerName,
        this.influencerTypeId,
        this.influencerTypeText,
        this.mobileNumber,
        this.respCode,
        this.respMsg,
        this.inflId
      });

  SaveNewInfluencerResponse.fromJson(Map<String, dynamic> json) {
    ilpInterested = json['ilp_intrested'];
    influencerCategoryId = json['influencer_category_id'];
    influencerCategoryText = json['influencer_category_text'];
    influencerName = json['influencer_name'];
    influencerTypeId = json['influencer_type_id'];
    influencerTypeText = json['influencer_type_text'];
    mobileNumber = json['mobile_number'];
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    inflId = json['infl_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilp_intrested'] = this.ilpInterested;
    data['influencer_category_id'] = this.influencerCategoryId;
    data['influencer_category_text'] = this.influencerCategoryText;
    data['influencer_name'] = this.influencerName;
    data['influencer_type_id'] = this.influencerTypeId;
    data['influencer_type_text'] = this.influencerTypeText;
    data['mobile_number'] = this.mobileNumber;
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['infl_id'] = this.inflId;
    return data;
  }
}

