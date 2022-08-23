

import 'GetGiftStockModel.dart';

class LogsModel {
  List<GiftStockList>? giftStockModelList;
  List<GiftTypeModelList>? giftTypeModelList;
  String? respCode;
  String? respMsg;

  LogsModel(
      {this.giftStockModelList,
        this.giftTypeModelList,
        this.respCode,
        this.respMsg});

  LogsModel.fromJson(Map<String, dynamic> json) {
    if(!json.containsKey('giftStockModelList'))
      giftStockModelList = new List<GiftStockList>.empty(growable: true);

    if (json['giftStockModelList'] != null) {
      giftStockModelList = new List<GiftStockList>.empty(growable: true);
      json['giftStockModelList'].forEach((v) {
        giftStockModelList!.add(new GiftStockList.fromJson(v));
      });
    }

    if(!json.containsKey('giftTypeModelList'))
      giftTypeModelList = new List<GiftTypeModelList>.empty(growable: true);

    if (json['giftTypeModelList'] != null) {
      giftTypeModelList = new List<GiftTypeModelList>.empty(growable: true);
      json['giftTypeModelList'].forEach((v) {
        giftTypeModelList!.add(new GiftTypeModelList.fromJson(v));
      });
    }
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giftStockModelList != null) {
      data['giftStockModelList'] =
          this.giftStockModelList!.map((v) => v.toJson()).toList();
    }
    if (this.giftTypeModelList != null) {
      data['giftTypeModelList'] =
          this.giftTypeModelList!.map((v) => v.toJson()).toList();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

class GiftStockList {
  String? eventDate;
  int? eventId;
  String? giftAddDate;
  int? giftInHandQty;
  int? giftOpeningStockQty;
  int? giftQty;
  int? giftStockId;
  int? giftTypeId;
  String? giftTypeText;
  int? giftUtilisedQty;
  String? referenceId;
  int? stockAddedQty;
  int? tsoId;

  GiftStockList(
      {this.eventDate,
        this.eventId,
        this.giftAddDate,
        this.giftInHandQty,
        this.giftOpeningStockQty,
        this.giftQty,
        this.giftStockId,
        this.giftTypeId,
        this.giftTypeText,
        this.giftUtilisedQty,
        this.referenceId,
        this.stockAddedQty,
        this.tsoId});

  GiftStockList.fromJson(Map<String, dynamic> json) {
    eventDate = json['eventDate'];
    eventId = json['eventId'];
    giftAddDate = json['giftAddDate'];
    giftInHandQty = json['giftInHandQty'];
    giftOpeningStockQty = json['giftOpeningStockQty'];
    giftQty = json['giftQty'];
    giftStockId = json['giftStockId'];
    giftTypeId = json['giftTypeId'];
    giftTypeText = json['giftTypeText'];
    giftUtilisedQty = json['giftUtilisedQty'];
    referenceId = json['referenceId'];
    stockAddedQty = json['stockAddedQty'];
    tsoId = json['tsoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventDate'] = this.eventDate;
    data['eventId'] = this.eventId;
    data['giftAddDate'] = this.giftAddDate;
    data['giftInHandQty'] = this.giftInHandQty;
    data['giftOpeningStockQty'] = this.giftOpeningStockQty;
    data['giftQty'] = this.giftQty;
    data['giftStockId'] = this.giftStockId;
    data['giftTypeId'] = this.giftTypeId;
    data['giftTypeText'] = this.giftTypeText;
    data['giftUtilisedQty'] = this.giftUtilisedQty;
    data['referenceId'] = this.referenceId;
    data['stockAddedQty'] = this.stockAddedQty;
    data['tsoId'] = this.tsoId;
    return data;
  }
}

