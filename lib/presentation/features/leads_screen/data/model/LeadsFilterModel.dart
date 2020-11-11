class LeadsFilterModel {
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadStageEntity> leadStageEntity;

  LeadsFilterModel({this.leadStatusEntity, this.leadStageEntity});

  LeadsFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>();
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity.add(new LeadStatusEntity.fromJson(v));
      });
    }
    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>();
      json['leadStageEntity'].forEach((v) {
        leadStageEntity.add(new LeadStageEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadStatusEntity {
  int id;
  String leadStatusDesc;

  LeadStatusEntity({this.id, this.leadStatusDesc});

  LeadStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStatusDesc = json['leadStatusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStatusDesc'] = this.leadStatusDesc;
    return data;
  }
}

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
