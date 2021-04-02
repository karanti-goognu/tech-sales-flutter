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
      this.blockLevelMeet
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
    return data;
  }
}
