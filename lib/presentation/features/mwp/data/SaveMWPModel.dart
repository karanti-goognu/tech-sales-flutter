

/*
class SaveMWPModel {
  String mwpMonth;
  String referenceId;
  int totalConvMt;
  int newIlpMembers;
  int dspSlabConvNo;
  int siteConvMt;
  int siteConvNo;
  int siteVisitesNo;
  int siteUniqueVisitsNo;
  int inflVisitsNo;
  int masonMeetNo;
  int counterMeetNo;
  int contractorMeetNo;
  int miniContractorMeetNo;
  int consumerMeetNo;
  String status;
  String createdBy;
  String actionedBy;

  double dspConversionVol;
  int contractorVisit;
  int technocratVisit;
  int techVanDemo;
  int techVanService;
  int slabServices;
  int technocratMeet;
  int blockLevelMeet;
  int headMasonMeet;
  int newInfluencer;
  int counterVisit;
  int ilpVolume;


  SaveMWPModel(
      this.mwpMonth,
      this.referenceId,
      this.totalConvMt,
      this.newIlpMembers,
      this.dspSlabConvNo,
      this.siteConvMt,
      this.siteConvNo,
      this.siteVisitesNo,
      this.siteUniqueVisitsNo,
     /* this.inflVisitsNo,*/
      this.masonMeetNo,
      this.counterMeetNo,
      this.contractorMeetNo,
      this.miniContractorMeetNo,
      this.consumerMeetNo,
      this.status,
      this.createdBy,
      this.actionedBy,
      this.dspConversionVol,
      this.contractorVisit,
      this.technocratVisit,
      this.techVanDemo,
      this.techVanService,
      this.slabServices,
      this.technocratMeet,
      this.blockLevelMeet,
      this.headMasonMeet,
      this.newInfluencer,
      this.counterVisit,
      this.ilpVolume
      );

  SaveMWPModel.fromJson(Map<String, dynamic> json) {
    mwpMonth = json['mwpMonth'];
    referenceId = json['referenceId'];
    totalConvMt = json['totalConvMt'];
    newIlpMembers = json['newIlpMembers'];
    dspSlabConvNo = json['dspSlabConvNo'];
    siteConvMt = json['siteConvMt'];
    siteConvNo = json['siteConvNo'];
    siteVisitesNo = json['siteVisitesNo'];
    siteUniqueVisitsNo = json['siteUniqueVisitsNo'];
  /*  inflVisitsNo = json['inflVisitsNo'];*/
    masonMeetNo = json['masonMeetNo'];
    counterMeetNo = json['counterMeetNo'];
    contractorMeetNo = json['contractorMeetNo'];
    miniContractorMeetNo = json['miniContractorMeetNo'];
    consumerMeetNo = json['consumerMeetNo'];
    status = json['status'];
    createdBy = json['createdBy'];
    actionedBy = json['actionedBy'];
    dspConversionVol = json['dspConversionVol'];
    contractorVisit = json['contractorVisit'];
    technocratVisit = json['technocratVisit'];
    techVanDemo = json['techVanDemo'];
    techVanService = json['techVanService'];
    slabServices = json['slabServices'];
    technocratMeet = json['technocratMeet'];
    blockLevelMeet = json['blockLevelMeet'];
    headMasonMeet = json['headMasonMeet'];
    newInfluencer = json['newInfluencer'];
    counterVisit = json[''];
    ilpVolume = json[''];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mwpMonth'] = this.mwpMonth;
    data['referenceId'] = this.referenceId;
    data['totalConvMt'] = this.totalConvMt;
    data['newIlpMembers'] = this.newIlpMembers;
    data['dspSlabConvNo'] = this.dspSlabConvNo;
    data['siteConvMt'] = this.siteConvMt;
    data['siteConvNo'] = this.siteConvNo;
    data['siteVisitesNo'] = this.siteVisitesNo;
    data['siteUniqueVisitsNo'] = this.siteUniqueVisitsNo;
    data['inflVisitsNo'] = 0;
    data['masonMeetNo'] = this.masonMeetNo;
    data['counterMeetNo'] = this.counterMeetNo;
    data['contractorMeetNo'] = this.contractorMeetNo;
    data['miniContractorMeetNo'] = this.miniContractorMeetNo;
    data['consumerMeetNo'] = this.consumerMeetNo;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['actionedBy'] = this.actionedBy;
    data['dspConversionVol'] = this.dspConversionVol;
    data['contractorVisit'] = this.contractorVisit;
    data['technocratVisit'] = this.technocratVisit;
    data['techVanDemo'] = this.techVanDemo;
    data['techVanService'] = this.techVanService;
    data['slabServices'] = this.slabServices;
    data['technocratMeet'] = this.technocratMeet;
    data['blockLevelMeet'] = this.blockLevelMeet;
    data['headMasonMeet'] = this.headMasonMeet;
    data['newInfluencer'] = this.newInfluencer;
    data[''] = this.counterVisit;
    data[''] = this.ilpVolume;
    return data;
  }
}
*/

import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';

class SaveMWPModel {
  String? mwpMonth;
  String? referenceId;
  String? status;
  String? createdBy;
  String? actionedBy;
  List<MwpPlannigList>? mwpPlannigList;


  SaveMWPModel(
      this.mwpMonth,
      this.referenceId,
      this.status,
      this.createdBy,
      this.actionedBy,
      this.mwpPlannigList
      );

  SaveMWPModel.fromJson(Map<String, dynamic> json) {
    mwpMonth = json['mwpMonth'];
    referenceId = json['referenceId'];
    status = json['status'];
    createdBy = json['createdBy'];
    actionedBy = json['actionedBy'];
    if (json['mwpPlannigList'] != null) {
      mwpPlannigList = <MwpPlannigList>[];
      json['mwpPlannigList'].forEach((v) {
        mwpPlannigList!.add(new MwpPlannigList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mwpMonth'] = this.mwpMonth;
    data['referenceId'] = this.referenceId;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['actionedBy'] = this.actionedBy;
    if (this.mwpPlannigList != null) {
      data['mwpPlannigList'] =
          this.mwpPlannigList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class MwpPlannigList {
//   String name;
//   int id;
//   int actualValue;
//   int targetValue;
//
//   MwpPlannigList({this.name, this.id, this.actualValue, this.targetValue});
//
//   MwpPlannigList.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     id = json['id'];
//     actualValue = json['actualValue'];
//     targetValue = json['targetValue'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['id'] = this.id;
//     data['actualValue'] = this.actualValue;
//     data['targetValue'] = this.targetValue;
//     return data;
//   }
// }


