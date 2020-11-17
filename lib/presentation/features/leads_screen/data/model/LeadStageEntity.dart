class LeadStageEntity {
  int id;
  String leadStageDesc;

  LeadStageEntity({this.id, this.leadStageDesc});

  LeadStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStageDesc = json['leadStageDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStageDesc'] = this.leadStageDesc;
    return data;
  }
}
