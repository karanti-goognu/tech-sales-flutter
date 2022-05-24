import 'package:flutter/cupertino.dart';

class PendingSupplyDetails {
  PendingSupplyDetailsEntity? response;

  PendingSupplyDetails({this.response});

  PendingSupplyDetails.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new PendingSupplyDetailsEntity.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class PendingSupplyDetailsEntity {
  String? respCode;
  String? respMsg;
  PendingSuppliesDetailsModel? pendingSuppliesDetailsModel;

  PendingSupplyDetailsEntity(
      {this.respCode, this.respMsg, this.pendingSuppliesDetailsModel});

  PendingSupplyDetailsEntity.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];

    if (!json.containsKey('pendingSuppliesDetailsModel'))
      pendingSuppliesDetailsModel = null;

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
          this.pendingSuppliesDetailsModel!.toJson();
    }
    return data;
  }
}

class PendingSuppliesDetailsModel {
  String? siteId;
  String? assignedTo;
  String? siteSupplyHistoryId;
  String? siteStageHistoryId;
  String? referenceId;
  String? floorId;
  TextEditingController? floorText = new TextEditingController();
  String? stageConstructionId;
  TextEditingController? stageConstructionDesc = new TextEditingController();
  TextEditingController? sitePotentialMt = new TextEditingController();
  String? brandId;
  TextEditingController? brandName = new TextEditingController();
  TextEditingController? productName = new TextEditingController();
  TextEditingController? brandPrice = new TextEditingController();
  TextEditingController? supplyQty = new TextEditingController();
  TextEditingController? supplyDate = new TextEditingController();
  TextEditingController? counter = new TextEditingController();
  String? soldToParty;
  String? soldToPartyName;
  String? shipToParty;
  String? shipToPartyName;
  String? isAuthorised;
  String? supplyCreatedOn;
  String? influencerName;
  List<ConstStage>? constStage;
  List<SiteFloorlist>? siteFloorlist;
  String? siteOwnerName;
  String? siteOwnerNumber;
  String? influencerContactNumber;
  String? requestInitiatedBy;

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
      this.counter,
      this.siteOwnerName,
      this.siteOwnerNumber,
      this.influencerContactNumber,
      this.requestInitiatedBy,
      this.constStage,
      this.siteFloorlist});

  PendingSuppliesDetailsModel.fromJson(Map<String, dynamic> json) {
    siteId = json['siteId'];
    assignedTo = json['assignedTo'];
    siteSupplyHistoryId = json['siteSupplyHistoryId'];
    siteStageHistoryId = json['siteStageHistoryId']; //null
    referenceId = json['referenceId']; //null
    floorId = json['floorId'];
    floorText!.text = json['floorText'];
    stageConstructionId = json['stageConstructionId'];
    stageConstructionDesc!.text = json['stageConstructionDesc'] ?? "";
    sitePotentialMt!.text = json['sitePotentialMt'] ?? "";
    counter!.text = json['shipToPartyName'] ?? "";
    brandId = json['brandId'];
    brandName!.text = json['brandName'];
    productName!.text = json['productName'];
    brandPrice!.text = json['brandPrice'] ?? "";
    supplyQty!.text = json['supplyQty'];
    supplyDate!.text = json['supplyDate'];
    soldToParty = json['soldToParty'];
    soldToPartyName = json['soldToPartyName'];
    shipToParty = json['shipToParty'];
    shipToPartyName = json['shipToPartyName'];
    isAuthorised = json['isAuthorised'];
    supplyCreatedOn = json['supplyCreatedOn'];
    influencerName = json['influencerName'];
    siteOwnerName = json['siteOwnerName'];
    siteOwnerNumber = json['siteOwnerNumber'];
    influencerContactNumber = json['influencerContactNumber'];
    requestInitiatedBy = json['requestInitiatedBy'];

    if (json['constStage'] != null) {
      constStage = new List<ConstStage>.empty(growable: true);
      json['constStage'].forEach((v) {
        constStage!.add(new ConstStage.fromJson(v));
      });
    }
    if (json['siteFloorlist'] != null) {
      siteFloorlist = new List<SiteFloorlist>.empty(growable: true);
      json['siteFloorlist'].forEach((v) {
        siteFloorlist!.add(new SiteFloorlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteId'] = this.siteId;
    data['assignedTo'] = this.assignedTo;
    data['siteSupplyHistoryId'] = this.siteSupplyHistoryId;
    data['siteStageHistoryId'] = this.siteStageHistoryId;
    data['referenceId'] = this.referenceId;
    data['floorId'] = this.floorId;
    data['floorText'] = this.floorText!.text;
    data['stageConstructionId'] = this.stageConstructionId;
    data['stageConstructionDesc'] = this.stageConstructionDesc!.text;
    data['sitePotentialMt'] = this.sitePotentialMt!.text;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName!.text;
    data['productName'] = this.productName!.text;
    data['brandPrice'] = this.brandPrice!.text;
    data['supplyQty'] = this.supplyQty!.text;
    data['supplyDate'] = this.supplyDate!.text;
    data['shipToPartyName'] = this.counter!.text;
    data['soldToParty'] = this.soldToParty;
    data['soldToPartyName'] = this.soldToPartyName;
    data['shipToParty'] = this.shipToParty;
    data['shipToPartyName'] = this.shipToPartyName;
    data['isAuthorised'] = this.isAuthorised;
    data['supplyCreatedOn'] = this.supplyCreatedOn;
    data['influencerName'] = this.influencerName;

    data['siteOwnerName'] = this.siteOwnerName;
    data['siteOwnerNumber'] = this.siteOwnerNumber;
    data['influencerContactNumber'] = this.influencerContactNumber;
    data['requestInitiatedBy'] = this.requestInitiatedBy;

    if (this.constStage != null) {
      data['constStage'] = this.constStage!.map((v) => v.toJson()).toList();
    }
    if (this.siteFloorlist != null) {
      data['siteFloorlist'] =
          this.siteFloorlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConstStage {
  int? id;
  String? constructionStageText;

  ConstStage({this.id, this.constructionStageText});

  ConstStage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    constructionStageText = json['constructionStageText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['constructionStageText'] = this.constructionStageText;
    return data;
  }
}

class SiteFloorlist {
  int? id;
  String? siteFloorTxt;

  SiteFloorlist({this.id, this.siteFloorTxt});

  SiteFloorlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteFloorTxt = json['siteFloorTxt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteFloorTxt'] = this.siteFloorTxt;
    return data;
  }
}
