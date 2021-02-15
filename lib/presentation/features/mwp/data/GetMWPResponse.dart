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
  Null rejectedOn;
  String actionedBy;

  MwpplanModel(
      {this.id,
        this.tsoId,
        this.mwpMonth,
        this.referenceId,
        this.totalConvMt,
        this.newIlpMembers,
        this.dspSlabConvNo,
        this.siteConvMt,
        this.siteConvNo,
        this.siteVisitesNo,
        this.siteUniqueVisitsNo,
        this.inflVisitsNo,
        this.masonMeetNo,
        this.counterMeetNo,
        this.contractorMeetNo,
        this.miniContractorMeetNo,
        this.consumerMeetNo,
        this.actualTotalConvMt,
        this.actualNewIlpMembers,
        this.actualDspSlabConvNo,
        this.actualSiteConvMt,
        this.actualSiteConvNo,
        this.actualSiteVisitesNo,
        this.actualSiteUniqueVisitsNo,
        this.actualInflVisitsNo,
        this.actualMasonMeetNo,
        this.actualCounterMeetNo,
        this.actualContractorMeetNo,
        this.actualMiniContractorMeetNo,
        this.actualConsumerMeetNo,
        this.status,
        this.createdBy,
        this.createdOn,
        this.submittedOn,
        this.approvedOn,
        this.rejectedOn,
        this.actionedBy});

  MwpplanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsoId = json['tsoId'];
    mwpMonth = json['mwpMonth'];
    referenceId = json['referenceId'];
    totalConvMt = json['totalConvMt'];
    newIlpMembers = json['newIlpMembers'];
    dspSlabConvNo = json['dspSlabConvNo'];
    siteConvMt = json['siteConvMt'];
    siteConvNo = json['siteConvNo'];
    siteVisitesNo = json['siteVisitesNo'];
    siteUniqueVisitsNo = json['siteUniqueVisitsNo'];
    inflVisitsNo = json['inflVisitsNo'];
    masonMeetNo = json['masonMeetNo'];
    counterMeetNo = json['counterMeetNo'];
    contractorMeetNo = json['contractorMeetNo'];
    miniContractorMeetNo = json['miniContractorMeetNo'];
    consumerMeetNo = json['consumerMeetNo'];
    actualTotalConvMt = json['actualTotalConvMt'];
    actualNewIlpMembers = json['actualNewIlpMembers'];
    actualDspSlabConvNo = json['actualDspSlabConvNo'];
    actualSiteConvMt = json['actualSiteConvMt'];
    actualSiteConvNo = json['actualSiteConvNo'];
    actualSiteVisitesNo = json['actualSiteVisitesNo'];
    actualSiteUniqueVisitsNo = json['actualSiteUniqueVisitsNo'];
    actualInflVisitsNo = json['actualInflVisitsNo'];
    actualMasonMeetNo = json['actualMasonMeetNo'];
    actualCounterMeetNo = json['actualCounterMeetNo'];
    actualContractorMeetNo = json['actualContractorMeetNo'];
    actualMiniContractorMeetNo = json['actualMiniContractorMeetNo'];
    actualConsumerMeetNo = json['actualConsumerMeetNo'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    submittedOn = json['submittedOn'];
    approvedOn = json['approvedOn'];
    rejectedOn = json['rejectedOn'];
    actionedBy = json['actionedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsoId'] = this.tsoId;
    data['mwpMonth'] = this.mwpMonth;
    data['referenceId'] = this.referenceId;
    data['totalConvMt'] = this.totalConvMt;
    data['newIlpMembers'] = this.newIlpMembers;
    data['dspSlabConvNo'] = this.dspSlabConvNo;
    data['siteConvMt'] = this.siteConvMt;
    data['siteConvNo'] = this.siteConvNo;
    data['siteVisitesNo'] = this.siteVisitesNo;
    data['siteUniqueVisitsNo'] = this.siteUniqueVisitsNo;
    data['inflVisitsNo'] = this.inflVisitsNo;
    data['masonMeetNo'] = this.masonMeetNo;
    data['counterMeetNo'] = this.counterMeetNo;
    data['contractorMeetNo'] = this.contractorMeetNo;
    data['miniContractorMeetNo'] = this.miniContractorMeetNo;
    data['consumerMeetNo'] = this.consumerMeetNo;
    data['actualTotalConvMt'] = this.actualTotalConvMt;
    data['actualNewIlpMembers'] = this.actualNewIlpMembers;
    data['actualDspSlabConvNo'] = this.actualDspSlabConvNo;
    data['actualSiteConvMt'] = this.actualSiteConvMt;
    data['actualSiteConvNo'] = this.actualSiteConvNo;
    data['actualSiteVisitesNo'] = this.actualSiteVisitesNo;
    data['actualSiteUniqueVisitsNo'] = this.actualSiteUniqueVisitsNo;
    data['actualInflVisitsNo'] = this.actualInflVisitsNo;
    data['actualMasonMeetNo'] = this.actualMasonMeetNo;
    data['actualCounterMeetNo'] = this.actualCounterMeetNo;
    data['actualContractorMeetNo'] = this.actualContractorMeetNo;
    data['actualMiniContractorMeetNo'] = this.actualMiniContractorMeetNo;
    data['actualConsumerMeetNo'] = this.actualConsumerMeetNo;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['submittedOn'] = this.submittedOn;
    data['approvedOn'] = this.approvedOn;
    data['rejectedOn'] = this.rejectedOn;
    data['actionedBy'] = this.actionedBy;
    return data;
  }
}