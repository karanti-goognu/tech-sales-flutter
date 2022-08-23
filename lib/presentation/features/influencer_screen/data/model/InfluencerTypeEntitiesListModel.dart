class InfluencerTypeEntitiesList {
  int? inflTypeId;
  String? inflTypeDesc;
  String? infRegFlag;

  InfluencerTypeEntitiesList(
      {this.inflTypeId, this.inflTypeDesc, this.infRegFlag});

  InfluencerTypeEntitiesList.fromJson(Map<String, dynamic> json) {
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
