class DealerListResponse {
  String respCode;
  String respMsg;
  List<DealerList> dealerList;

  DealerListResponse({this.respCode, this.respMsg, this.dealerList});

  DealerListResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['dealerList'] != null) {
      dealerList = new List<DealerList>();
      json['dealerList'].forEach((v) {
        dealerList.add(new DealerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.dealerList != null) {
      data['dealerList'] = this.dealerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DealerList {
  String dealerId;
  String dealerName;
  bool dealerSelected = false;

  DealerList({this.dealerId, this.dealerName});

  DealerList.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}