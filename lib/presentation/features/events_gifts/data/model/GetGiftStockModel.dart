class GetGiftStockModel {
  String? respCode;
  String? respMsg;
  List<GiftStockModelList>? giftStockModelList;
  List<GiftTypeModelList>? giftTypeModelList;

  GetGiftStockModel(
      {this.respCode,
        this.respMsg,
        this.giftStockModelList,
        this.giftTypeModelList});

  GetGiftStockModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['giftStockModelList'] != null) {
      giftStockModelList = new List<GiftStockModelList>.empty(growable: true);
      json['giftStockModelList'].forEach((v) {
        giftStockModelList!.add(new GiftStockModelList.fromJson(v));
      });
    }
    if (json['giftTypeModelList'] != null) {
      giftTypeModelList = new List<GiftTypeModelList>.empty(growable: true);
      json['giftTypeModelList'].forEach((v) {
        giftTypeModelList!.add(new GiftTypeModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.giftStockModelList != null) {
      data['giftStockModelList'] =
          this.giftStockModelList!.map((v) => v.toJson()).toList();
    }
    if (this.giftTypeModelList != null) {
      data['giftTypeModelList'] =
          this.giftTypeModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiftStockModelList {
  int? giftTypeId;
  String? giftTypeText;
  String? referenceId;
  int? giftOpeningStockQty;
  int? giftInHandQty;
  int? giftUtilisedQty;

  GiftStockModelList(
      {this.giftTypeId,
        this.giftTypeText,
        this.referenceId,
        this.giftOpeningStockQty,
        this.giftInHandQty,
        this.giftUtilisedQty});

  GiftStockModelList.fromJson(Map<String, dynamic> json) {
    giftTypeId = json['giftTypeId'];
    giftTypeText = json['giftTypeText'];
    referenceId = json['referenceId'];
    giftOpeningStockQty = json['giftOpeningStockQty'];
    giftInHandQty = json['giftInHandQty'];
    giftUtilisedQty = json['giftUtilisedQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giftTypeId'] = this.giftTypeId;
    data['giftTypeText'] = this.giftTypeText;
    data['referenceId'] = this.referenceId;
    data['giftOpeningStockQty'] = this.giftOpeningStockQty;
    data['giftInHandQty'] = this.giftInHandQty;
    data['giftUtilisedQty'] = this.giftUtilisedQty;
    return data;
  }
}

class GiftTypeModelList {
  int? giftTypeId;
  String? giftTypeText;
  int? giftStockInHand;

  GiftTypeModelList({this.giftTypeId, this.giftTypeText, this.giftStockInHand});

  GiftTypeModelList.fromJson(Map<String, dynamic> json) {
    giftTypeId = json['giftTypeId'];
    giftTypeText = json['giftTypeText'];
    giftStockInHand = json['giftStockInHand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giftTypeId'] = this.giftTypeId;
    data['giftTypeText'] = this.giftTypeText;
    data['giftStockInHand'] = this.giftStockInHand;
    return data;
  }
}