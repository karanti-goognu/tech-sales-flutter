class SaveVisitRequest {
  String referenceId;
  String eventType;
  String visitMeetType;
  String docId;
  String visitMeetDate;
  String remarks;

  SaveVisitRequest(
      this.referenceId,
        this.eventType,
        this.visitMeetType,
        this.docId,
        this.visitMeetDate,
        this.remarks);

  SaveVisitRequest.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    eventType = json['eventType'];
    visitMeetType = json['visitMeetType'];
    docId = json['docId'];
    visitMeetDate = json['visitMeetDate'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceId'] = this.referenceId;
    data['eventType'] = this.eventType;
    data['visitMeetType'] = this.visitMeetType;
    data['docId'] = this.docId;
    data['visitMeetDate'] = this.visitMeetDate;
    data['remarks'] = this.remarks;
    return data;
  }
}