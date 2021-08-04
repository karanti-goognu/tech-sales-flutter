class PendingSupplyDetails {
  PendingSupplyDetailsEntity response;

  PendingSupplyDetails({this.response});

  PendingSupplyDetails.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new PendingSupplyDetailsEntity.fromJson(json['response'])
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

class PendingSupplyDetailsEntity {
  String respCode;
  String respMsg;
  PendingSuppliesDetailsModel pendingSuppliesDetailsModel;

  PendingSupplyDetailsEntity({this.respCode, this.respMsg, this.pendingSuppliesDetailsModel});

  PendingSupplyDetailsEntity.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    pendingSuppliesDetailsModel = json['pendingSuppliesDetailsModel'] != null
        ? new PendingSuppliesDetailsModel.fromJson(
        json['pendingSuppliesDetailsModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.pendingSuppliesDetailsModel != null) {
      data['pendingSuppliesDetailsModel'] =
          this.pendingSuppliesDetailsModel.toJson();
    }
    return data;
  }
}

class PendingSuppliesDetailsModel {
  String siteId;
  String assignedTo;
  String siteSupplyHistoryId;
  Null siteStageHistoryId;
  Null referenceId;
  String floorId;
  String floorText;
  String stageConstructionId;
  String stageConstructionDesc;
  String sitePotentialMt;
  String brandId;
  String brandName;
  String productName;
  Null brandPrice;
  String supplyQty;
  String supplyDate;
  String soldToParty;
  String soldToPartyName;
  String shipToParty;
  String shipToPartyName;
  String isAuthorised;
  String supplyCreatedOn;

  PendingSuppliesDetailsModel(
      {this.siteId,
        this.assignedTo,
        this.siteSupplyHistoryId,
        this.siteStageHistoryId,
        this.referenceId,
        this.floorId,
        this.floorText,
        this.stageConstructionId,
        this.stageConstructionDesc,
        this.sitePotentialMt,
        this.brandId,
        this.brandName,
        this.productName,
        this.brandPrice,
        this.supplyQty,
        this.supplyDate,
        this.soldToParty,
        this.soldToPartyName,
        this.shipToParty,
        this.shipToPartyName,
        this.isAuthorised,
        this.supplyCreatedOn});

  PendingSuppliesDetailsModel.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    assignedTo = json['assignedTo'];
    siteSupplyHistoryId = json['siteSupplyHistoryId'];
    siteStageHistoryId = json['siteStageHistoryId'];
    referenceId = json['referenceId'];
    floorId = json['floorId'];
    floorText = json['floorText'];
    stageConstructionId = json['stageConstructionId'];
    stageConstructionDesc = json['stageConstructionDesc'];
    sitePotentialMt = json['sitePotentialMt'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productName = json['productName'];
    brandPrice = json['brandPrice'];
    supplyQty = json['supplyQty'];
    supplyDate = json['supplyDate'];
    soldToParty = json['soldToParty'];
    soldToPartyName = json['soldToPartyName'];
    shipToParty = json['shipToParty'];
    shipToPartyName = json['shipToPartyName'];
    isAuthorised = json['isAuthorised'];
    supplyCreatedOn = json['supplyCreatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['assignedTo'] = this.assignedTo;
    data['siteSupplyHistoryId'] = this.siteSupplyHistoryId;
    data['siteStageHistoryId'] = this.siteStageHistoryId;
    data['referenceId'] = this.referenceId;
    data['floorId'] = this.floorId;
    data['floorText'] = this.floorText;
    data['stageConstructionId'] = this.stageConstructionId;
    data['stageConstructionDesc'] = this.stageConstructionDesc;
    data['sitePotentialMt'] = this.sitePotentialMt;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['productName'] = this.productName;
    data['brandPrice'] = this.brandPrice;
    data['supplyQty'] = this.supplyQty;
    data['supplyDate'] = this.supplyDate;
    data['soldToParty'] = this.soldToParty;
    data['soldToPartyName'] = this.soldToPartyName;
    data['shipToParty'] = this.shipToParty;
    data['shipToPartyName'] = this.shipToPartyName;
    data['isAuthorised'] = this.isAuthorised;
    data['supplyCreatedOn'] = this.supplyCreatedOn;
    return data;
  }
}
