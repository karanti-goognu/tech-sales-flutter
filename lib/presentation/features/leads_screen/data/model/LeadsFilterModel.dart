import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadStageEntity.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/LeadStatusModel.dart';

class LeadsFilterModel {
  List<LeadStatusEntity>? leadStatusEntity;
  List<LeadStageEntity>? leadStageEntity;

  LeadsFilterModel({this.leadStatusEntity, this.leadStageEntity});

  LeadsFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>.empty(growable: true);
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity!.add(new LeadStatusEntity.fromJson(v));
      });
    }
    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>.empty(growable: true);
      json['leadStageEntity'].forEach((v) {
        leadStageEntity!.add(new LeadStageEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity!.map((v) => v.toJson()).toList();
    }
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
