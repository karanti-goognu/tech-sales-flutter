class PendingSupplyData {
  PendingSupplyDataResponse response;

  PendingSupplyData({this.response});

  PendingSupplyData.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new PendingSupplyDataResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class PendingSupplyDataResponse {
  String respCode;
  String respMsg;
  List<PendingSuppliesModel> pendingSuppliesModel;
  int pendingSupplyListCount;

  PendingSupplyDataResponse(
      {this.respCode,
        this.respMsg,
        this.pendingSuppliesModel,
        this.pendingSupplyListCount});

  PendingSupplyDataResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['pendingSuppliesModel'] != null) {
      pendingSuppliesModel = new List<PendingSuppliesModel>();
      json['pendingSuppliesModel'].forEach((v) {
        pendingSuppliesModel.add(new PendingSuppliesModel.fromJson(v));
      });
    }
    pendingSupplyListCount = json['pendingSupplyListCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.pendingSuppliesModel != null) {
      data['pendingSuppliesModel'] =
          this.pendingSuppliesModel.map((v) => v.toJson()).toList();
    }
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
  String inflName;

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
        this.dealerContact,
        this.inflName});

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
    inflName = json['inflName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['siteSupplyHistoryId'] = this.siteSupplyHistoryId;
    data['siteStageHistoryId'] = this.siteStageHistoryId;
    data['assigneTo'] = this.assigneTo;
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
    data['inflName'] = this.inflName;
    return data;
  }
}
