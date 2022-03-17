

class UpdateSiteModel {
  String? respCode;
  String? respMsg;
  String? siteId;
  String? assignedTo;

  UpdateSiteModel({this.respCode, this.respMsg, this.siteId, this.assignedTo});

  UpdateSiteModel.fromJson(Map<String, dynamic> json) {
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    siteId = json['site-Id'];
    assignedTo = json['assigned-To'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['site-Id'] = this.siteId;
    data['assigned-To'] = this.assignedTo;
    return data;
  }
}
