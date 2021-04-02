class GetMWPResponse {
  String respCode;
  String respMsg;
  List<String> listOfMonthYear;
  MwpplanModel mwpplanModel;

  GetMWPResponse(
      {this.respCode, this.respMsg, this.listOfMonthYear, this.mwpplanModel});

  GetMWPResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    listOfMonthYear = json['listOfMonthYear'].cast<String>();
    mwpplanModel = json['mwpplanModel'] != null
        ? new MwpplanModel.fromJson(json['mwpplanModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['listOfMonthYear'] = this.listOfMonthYear;
    if (this.mwpplanModel != null) {
      data['mwpplanModel'] = this.mwpplanModel.toJson();
    }
    return data;
  }
}

class MwpplanModel {
  int id;
  int tsoId;
  String mwpMonth;
  String referenceId;
  double totalConvMt;
  int newIlpMembers;
  int dspSlabConvNo;
  double siteConvMt;
  int siteConvNo;
  int siteVisitesNo;
  int siteUniqueVisitsNo;
  int inflVisitsNo;
  int masonMeetNo;
  int counterMeetNo;
  int contractorMeetNo;
  int miniContractorMeetNo;
  int consumerMeetNo;
  double actualTotalConvMt;
  int actualNewIlpMembers;
  int actualDspSlabConvNo;
  double actualSiteConvMt;
  int actualSiteConvNo;
  int actualSiteVisitesNo;
  int actualSiteUniqueVisitsNo;
  int actualInflVisitsNo;
  int actualMasonMeetNo;
  int actualCounterMeetNo;
  int actualContractorMeetNo;
  int actualMiniContractorMeetNo;
  int actualConsumerMeetNo;
  String status;
  String createdBy;
  int createdOn;
  int submittedOn;
  int approvedOn;
  int rejectedOn;
  String actionedBy;


  int slabServices;
  int blockLevelMeet;
  int contractorVisit;
  double dspConversionVol;
  int techVanDemo;
  int techVanService;
  int technocratMeet;
  int technocratVisit;

  int actualSlabServices;
  int actualBlockLevelMeet;
  int actualContractorVisit;
  double actualDspConversionVol;
  int actualTechVanDemo;
  int actualTechVanService;
  int actualTechnocratMeet;
  int actualTechnocratVisit;


     MwpplanModel(
      {this.actionedBy,
        this.actualConsumerMeetNo,
        this.actualContractorMeetNo,
        this.actualCounterMeetNo,
        this.actualDspSlabConvNo,
        this.actualInflVisitsNo,
        this.actualMasonMeetNo,
        this.actualMiniContractorMeetNo,
        this.actualNewIlpMembers,
        this.actualSiteConvMt,
        this.actualSiteConvNo,
        this.actualSiteUniqueVisitsNo,
        this.actualSiteVisitesNo,
        this.actualTotalConvMt,
        this.approvedOn,
        this.blockLevelMeet,
        this.consumerMeetNo,
        this.contractorMeetNo,
        this.contractorVisit,
        this.counterMeetNo,
        this.createdBy,
        this.createdOn,
        this.dspConversionVol,
        this.dspSlabConvNo,
        this.id,
        this.inflVisitsNo,
        this.masonMeetNo,
        this.miniContractorMeetNo,
        this.mwpMonth,
        this.newIlpMembers,
        this.referenceId,
        this.rejectedOn,
        this.siteConvMt,
        this.siteConvNo,
        this.siteUniqueVisitsNo,
        this.siteVisitesNo,
        this.slabServices,
        this.status,

        this.submittedOn,
        this.techVanDemo,
        this.techVanService,
        this.technocratMeet,
        this.technocratVisit,
        this.totalConvMt,
        this.tsoId,

        this.actualBlockLevelMeet,
        this.actualContractorVisit,
        this.actualDspConversionVol,
        this.actualSlabServices,
        this.actualTechnocratMeet,
        this.actualTechnocratVisit,
        this.actualTechVanDemo,
        this.actualTechVanService
      });

  MwpplanModel.fromJson(Map<String, dynamic> json) {
    actionedBy = json['actionedBy'];
    actualConsumerMeetNo = json['actualConsumerMeetNo'];
    actualContractorMeetNo = json['actualContractorMeetNo'];
    actualCounterMeetNo = json['actualCounterMeetNo'];
    actualDspSlabConvNo = json['actualDspSlabConvNo'];
    actualInflVisitsNo = json['actualInflVisitsNo'];
    actualMasonMeetNo = json['actualMasonMeetNo'];
    actualMiniContractorMeetNo = json['actualMiniContractorMeetNo'];
    actualNewIlpMembers = json['actualNewIlpMembers'];
    actualSiteConvMt = json['actualSiteConvMt'];
    actualSiteConvNo = json['actualSiteConvNo'];
    actualSiteUniqueVisitsNo = json['actualSiteUniqueVisitsNo'];
    actualSiteVisitesNo = json['actualSiteVisitesNo'];
    actualTotalConvMt = json['actualTotalConvMt'];
    approvedOn = json['approvedOn'];
    blockLevelMeet = json['blockLevelMeet'];
    consumerMeetNo = json['consumerMeetNo'];
    contractorMeetNo = json['contractorMeetNo'];
    contractorVisit = json['contractorVisit'];
    counterMeetNo = json['counterMeetNo'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dspConversionVol = json['dspConversionVol'];
    dspSlabConvNo = json['dspSlabConvNo'];
    id = json['id'];
    inflVisitsNo = json['inflVisitsNo'];
    masonMeetNo = json['masonMeetNo'];
    miniContractorMeetNo = json['miniContractorMeetNo'];
    mwpMonth = json['mwpMonth'];
    newIlpMembers = json['newIlpMembers'];
    referenceId = json['referenceId'];
    rejectedOn = json['rejectedOn'];
    siteConvMt = json['siteConvMt'];
    siteConvNo = json['siteConvNo'];
    siteUniqueVisitsNo = json['siteUniqueVisitsNo'];
    siteVisitesNo = json['siteVisitesNo'];
    slabServices = json['slabServices'];
    status = json['status'];
    submittedOn = json['submittedOn'];
    techVanDemo = json['techVanDemo'];
    techVanService = json['techVanService'];
    technocratMeet = json['technocratMeet'];
    technocratVisit = json['technocratVisit'];
    totalConvMt = json['totalConvMt'];
    tsoId = json['tsoId'];
    actualBlockLevelMeet = json['actualBlockLevelMeet'];
    actualContractorVisit = json['actualContractorVisit'];
    actualDspConversionVol = json['actualDspConversionVol'];
    actualSlabServices = json['actualSlabServices'];
    actualTechnocratMeet = json['actualTechnocratMeet'];
    actualTechnocratVisit = json['actualTechnocratVisit'];
    actualTechVanDemo = json['actualTechVanDemo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionedBy'] = this.actionedBy;
    data['actualConsumerMeetNo'] = this.actualConsumerMeetNo;
    data['actualContractorMeetNo'] = this.actualContractorMeetNo;
    data['actualCounterMeetNo'] = this.actualCounterMeetNo;
    data['actualDspSlabConvNo'] = this.actualDspSlabConvNo;
    data['actualInflVisitsNo'] = this.actualInflVisitsNo;
    data['actualMasonMeetNo'] = this.actualMasonMeetNo;
    data['actualMiniContractorMeetNo'] = this.actualMiniContractorMeetNo;
    data['actualNewIlpMembers'] = this.actualNewIlpMembers;
    data['actualSiteConvMt'] = this.actualSiteConvMt;
    data['actualSiteConvNo'] = this.actualSiteConvNo;
    data['actualSiteUniqueVisitsNo'] = this.actualSiteUniqueVisitsNo;
    data['actualSiteVisitesNo'] = this.actualSiteVisitesNo;
    data['actualTotalConvMt'] = this.actualTotalConvMt;
    data['approvedOn'] = this.approvedOn;
    data['blockLevelMeet'] = this.blockLevelMeet;
    data['consumerMeetNo'] = this.consumerMeetNo;
    data['contractorMeetNo'] = this.contractorMeetNo;
    data['contractorVisit'] = this.contractorVisit;
    data['counterMeetNo'] = this.counterMeetNo;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['dspConversionVol'] = this.dspConversionVol;
    data['dspSlabConvNo'] = this.dspSlabConvNo;
    data['id'] = this.id;
    data['inflVisitsNo'] = this.inflVisitsNo;
    data['masonMeetNo'] = this.masonMeetNo;
    data['miniContractorMeetNo'] = this.miniContractorMeetNo;
    data['mwpMonth'] = this.mwpMonth;
    data['newIlpMembers'] = this.newIlpMembers;
    data['referenceId'] = this.referenceId;
    data['rejectedOn'] = this.rejectedOn;
    data['siteConvMt'] = this.siteConvMt;
    data['siteConvNo'] = this.siteConvNo;
    data['siteUniqueVisitsNo'] = this.siteUniqueVisitsNo;
    data['siteVisitesNo'] = this.siteVisitesNo;
    data['slabServices'] = this.slabServices;
    data['status'] = this.status;
    data['submittedOn'] = this.submittedOn;
    data['techVanDemo'] = this.techVanDemo;
    data['techVanService'] = this.techVanService;
    data['technocratMeet'] = this.technocratMeet;
    data['technocratVisit'] = this.technocratVisit;
    data['totalConvMt'] = this.totalConvMt;
    data['tsoId'] = this.tsoId;
    data['actualBlockLevelMeet'] = this.actualBlockLevelMeet;
    data['actualContractorVisit'] = this.actualContractorVisit;
    data['actualDspConversionVol'] = this.actualDspConversionVol;
    data['actualSlabServices'] = this.actualSlabServices;
    data['actualTechnocratMeet'] = this.actualTechnocratMeet;
    data['actualTechnocratVisit'] = this.actualTechnocratVisit;
    data['actualTechVanDemo'] = this.actualTechVanDemo;
    return data;
  }
}