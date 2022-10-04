class InfluencerTypeEntitiesList {
  int? inflTypeId;
  String? inflTypeDesc;
  String? infRegFlag;
  String? profile;


  InfluencerTypeEntitiesList(
      {this.inflTypeId, this.inflTypeDesc, this.infRegFlag});

  InfluencerTypeEntitiesList.fromJson(Map<String, dynamic> json) {
    print(json);
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
    infRegFlag = json['infRegFlag'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    data['infRegFlag'] = this.infRegFlag;
    data['profile'] = this.profile;
    return data;
  }
}
