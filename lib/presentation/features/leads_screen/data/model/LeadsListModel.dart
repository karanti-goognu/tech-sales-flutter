import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsEntity.dart';

class LeadsListModel {
  List<LeadsEntity>? leadsEntity;
  String? respCode;
  String? respMsg;
  String? totalLeadPotential;
  String? totalLeadCount;

  LeadsListModel(
      {this.leadsEntity,
      this.respCode,
      this.respMsg,
      this.totalLeadPotential,
      this.totalLeadCount});

  LeadsListModel.fromJson(Map<String, dynamic> json) {
    if (json['leadsEntity'] != null) {
      leadsEntity = new List<LeadsEntity>.empty(growable: true);
      json['leadsEntity'].forEach((v) {
        leadsEntity!.add(new LeadsEntity.fromJson(v));
      });
    }
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
    totalLeadPotential = json['total_Lead_Potential'];
    totalLeadCount = json['total_Lead_Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadsEntity != null) {
      data['leadsEntity'] = this.leadsEntity!.map((v) => v.toJson()).toList();
    }
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    data['total_Lead_Potential'] = this.totalLeadPotential;
    data['total_Lead_Count'] = this.totalLeadCount;
    return data;
  }
}

