import 'package:flutter/cupertino.dart';

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
  var floorText = new TextEditingController();
  String stageConstructionId;
  var stageConstructionDesc = new TextEditingController();
  var sitePotentialMt = new TextEditingController();
  String brandId;
  var brandName = new TextEditingController();
  var productName = new TextEditingController();
  var brandPrice = new TextEditingController();
  var supplyQty = new TextEditingController();
  var supplyDate = new TextEditingController();
  TextEditingController counter = new TextEditingController();
  String soldToParty;
  String soldToPartyName;
  String shipToParty;
  String shipToPartyName;
  String isAuthorised;
  String supplyCreatedOn;
  String influencerName;

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
        this.supplyCreatedOn,
      this.influencerName,
      this.counter});

  PendingSuppliesDetailsModel.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    assignedTo = json['assignedTo'];
    siteSupplyHistoryId = json['siteSupplyHistoryId'];
    siteStageHistoryId = json['siteStageHistoryId'];
    referenceId = json['referenceId'];
    floorId = json['floorId'];
    floorText.text = json['floorText'];
    stageConstructionId = json['stageConstructionId'];
    stageConstructionDesc.text = json['stageConstructionDesc'];
    sitePotentialMt.text = json['sitePotentialMt'];
    counter.text = json['shipToPartyName'];
    brandId = json['brandId'];
    brandName.text = json['brandName'];
    productName.text = json['productName'];
    brandPrice.text = json['brandPrice'];
    supplyQty.text = json['supplyQty'];
    supplyDate.text = json['supplyDate'];
    soldToParty = json['soldToParty'];
    soldToPartyName = json['soldToPartyName'];
    shipToParty = json['shipToParty'];
    shipToPartyName = json['shipToPartyName'];
    isAuthorised = json['isAuthorised'];
    supplyCreatedOn = json['supplyCreatedOn'];
    influencerName = json['influencerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['assignedTo'] = this.assignedTo;
    data['siteSupplyHistoryId'] = this.siteSupplyHistoryId;
    data['siteStageHistoryId'] = this.siteStageHistoryId;
    data['referenceId'] = this.referenceId;
    data['floorId'] = this.floorId;
    data['floorText'] = this.floorText.text;
    data['stageConstructionId'] = this.stageConstructionId;
    data['stageConstructionDesc'] = this.stageConstructionDesc.text;
    data['sitePotentialMt'] = this.sitePotentialMt.text;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName.text;
    data['productName'] = this.productName.text;
    data['brandPrice'] = this.brandPrice.text;
    data['supplyQty'] = this.supplyQty.text;
    data['supplyDate'] = this.supplyDate.text;
    data['shipToPartyName'] = this.counter.text;
    data['soldToParty'] = this.soldToParty;
    data['soldToPartyName'] = this.soldToPartyName;
    data['shipToParty'] = this.shipToParty;
    data['shipToPartyName'] = this.shipToPartyName;
    data['isAuthorised'] = this.isAuthorised;
    data['supplyCreatedOn'] = this.supplyCreatedOn;
    data['influencerName'] = this.influencerName;
    return data;
  }
}
