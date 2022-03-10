class TotalPotentialModel {
  String respCode;
  String respMsg;
  int totalSitePotential;

  TotalPotentialModel({this.respCode, this.respMsg, this.totalSitePotential});

  TotalPotentialModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    totalSitePotential = json['totalSitePotential'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['totalSitePotential'] = this.totalSitePotential;
    return data;
  }
}

