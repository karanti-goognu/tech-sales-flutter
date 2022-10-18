class LeadVisitListModel {
  String? respCode;
  String? respMsg;
  List<LeadListModel>? leadListModel;

  LeadVisitListModel({this.respCode, this.respMsg, this.leadListModel});

  LeadVisitListModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if ( json['leadListModel'] != null ) {
      leadListModel = new List<LeadListModel>.empty(growable: true);
      json['leadListModel'].forEach((v) {
        print(v);
        leadListModel?.add(new LeadListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.leadListModel != null) {
      data['leadListModel'] =
          this.leadListModel?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadListModel {
  int? leadId;
  String? contactNumber;
  String? contactName;
  String? leadStatus;
  String? verificationType;

  LeadListModel({this.leadId, this.contactNumber, this.contactName, this.leadStatus, this.verificationType});

  LeadListModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('leadId'))
      leadId = json['leadId'];
    if (json.containsKey('contactNumber'))
      contactNumber = json['contactNumber'];
    if (json.containsKey('contactName'))
      contactName = json['contactName'];
    if (json.containsKey('leadStatus'))
      leadStatus = json['leadStatus'];
    if (json.containsKey('verificationType'))
      verificationType = json['verificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['contactNumber'] = this.contactNumber;
    data['contactName'] = this.contactName;
    data['leadStatus'] = this.leadStatus;
    data['verificationType'] = this.verificationType;
    return data;
  }
}
