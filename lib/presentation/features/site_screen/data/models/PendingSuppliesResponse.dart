class PendingSupplyDataResponse {
  SupplyResponse response;

  PendingSupplyDataResponse(
      {this.response});

  PendingSupplyDataResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    return data;
  }

}

class SupplyResponse{
  String respCode;
  String respMsg;
  List<PendingSuppliesModel> pendingSuppliesModel;
  int pendingSupplyListCount;


  SupplyResponse(
      {this.pendingSuppliesModel,
        this.respCode,
        this.respMsg,
        this.pendingSupplyListCount});

  SupplyResponse.fromJson(Map<String, dynamic> json) {
    if (json['pendingSuppliesModel'] != null) {
      pendingSuppliesModel = new List<PendingSuppliesModel>();
      json['pendingSuppliesModel'].forEach((v) {
        pendingSuppliesModel.add(new PendingSuppliesModel.fromJson(v));
      });
    }
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    pendingSupplyListCount = json['pendingSupplyListCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingSuppliesModel != null) {
      data['pendingSuppliesModel'] = this.pendingSuppliesModel.map((v) => v.toJson()).toList();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['pendingSupplyListCount'] = this.pendingSupplyListCount;
    return data;
  }

}

class PendingSuppliesModel {
  String siteId;
  String siteSupplyHistoryId;
  String siteStageHistoryId;
  String assigneTo;
  String siteDistrict;
  String inflId;
  String productName;
  String requestDate;
  String dealerId;
  String sitePotentialMt;
  String pendingQty;
  String approvedQty;
  String dealerName;
  String dealerContact;


  PendingSuppliesModel(
      {this.siteId,
        this.siteSupplyHistoryId,
        this.siteStageHistoryId,
        this.assigneTo,
        this.siteDistrict,
        this.inflId,
        this.productName,
        this.requestDate,
        this.dealerId,
        this.sitePotentialMt,
        this.pendingQty,
        this.approvedQty,
        this.dealerName,
        this.dealerContact});

  PendingSuppliesModel.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    siteSupplyHistoryId = json['siteSupplyHistoryId'];
    siteStageHistoryId = json['siteStageHistoryId'];
    assigneTo = json['assigneTo'];
    siteDistrict = json['siteDistrict'];
    inflId = json['inflId'];
    productName = json['productName'];
    requestDate = json['requestDate'];
    dealerId = json['dealerId'];
    sitePotentialMt = json['sitePotentialMt'];
    pendingQty = json['pendingQty'];
    approvedQty = json['approvedQty'];
    dealerName = json['dealerName'];
    dealerContact = json['dealerContact'];

  }

  Map<String, dynamic> toJson() {final Map<String, dynamic> data = new Map<String, dynamic>();
  data['siteId'] = this.siteId;
  data['siteSupplyHistoryId'] = this.siteSupplyHistoryId;
  data['siteStageHistoryId'] = this.siteStageHistoryId;
  data['siteDistrict'] = this.siteDistrict;
  data['inflId'] = this.inflId;
  data['productName'] = this.productName;
  data['requestDate'] = this.requestDate;
  data['dealerId'] = this.dealerId;
  data['sitePotentialMt'] = this.sitePotentialMt;
  data['pendingQty'] = this.pendingQty;
  data['approvedQty'] = this.approvedQty;
  data['dealerName'] = this.dealerName;
  data['dealerContact'] = this.dealerContact;
  return data;
  }
}
