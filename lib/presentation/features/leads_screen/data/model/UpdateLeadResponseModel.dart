class UpdateLeadResponseModel {
  String respCode;
  String respMsg;
  String leadId;
  String assignedTo;



  UpdateLeadResponseModel(
      {this.respCode, this.respMsg, this.leadId, this.assignedTo});

  UpdateLeadResponseModel.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    leadId = json['lead-Id'];
    assignedTo = json['assigned-To'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['lead-Id'] = this.leadId;
    data['assigned-To'] = this.assignedTo;
    return data;
  }
}
