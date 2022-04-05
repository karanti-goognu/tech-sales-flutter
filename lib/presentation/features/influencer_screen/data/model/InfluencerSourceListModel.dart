class InfluencerSourceList {
  int? inflSourceId;
  String? inflSourceText;

  InfluencerSourceList({this.inflSourceId, this.inflSourceText});

  InfluencerSourceList.fromJson(Map<String, dynamic> json) {
    inflSourceId = json['inflSourceId'];
    inflSourceText = json['inflSourceText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflSourceId'] = this.inflSourceId;
    data['inflSourceText'] = this.inflSourceText;
    return data;
  }
}
