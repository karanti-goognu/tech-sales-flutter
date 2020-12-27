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
      this.inflVisitsNo,
      this.masonMeetNo,
      this.counterMeetNo,
      this.contractorMeetNo,
      this.miniContractorMeetNo,
      this.consumerMeetNo,
      this.status,
      this.createdBy,
      this.actionedBy);

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
    inflVisitsNo = json['inflVisitsNo'];
    masonMeetNo = json['masonMeetNo'];
    counterMeetNo = json['counterMeetNo'];
    contractorMeetNo = json['contractorMeetNo'];
    miniContractorMeetNo = json['miniContractorMeetNo'];
    consumerMeetNo = json['consumerMeetNo'];
    status = json['status'];
    createdBy = json['createdBy'];
    actionedBy = json['actionedBy'];
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
    data['inflVisitsNo'] = this.inflVisitsNo;
    data['masonMeetNo'] = this.masonMeetNo;
    data['counterMeetNo'] = this.counterMeetNo;
    data['contractorMeetNo'] = this.contractorMeetNo;
    data['miniContractorMeetNo'] = this.miniContractorMeetNo;
    data['consumerMeetNo'] = this.consumerMeetNo;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['actionedBy'] = this.actionedBy;
    return data;
  }
}
