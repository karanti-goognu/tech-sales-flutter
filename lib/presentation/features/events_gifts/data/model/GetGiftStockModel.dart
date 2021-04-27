class GetGiftStockModel {
  List<GiftStockModelList> giftStockModelList;
  String respCode;
  String respMsg;

  GetGiftStockModel({this.giftStockModelList, this.respCode, this.respMsg});

  GetGiftStockModel.fromJson(Map<String, dynamic> json) {
    if (json['giftStockModelList'] != null) {
      giftStockModelList = new List<GiftStockModelList>();
      json['giftStockModelList'].forEach((v) {
        giftStockModelList.add(new GiftStockModelList.fromJson(v));
      });
    }
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giftStockModelList != null) {
      data['giftStockModelList'] =
          this.giftStockModelList.map((v) => v.toJson()).toList();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

class GiftStockModelList {
  String eventDate;
  int eventId;
  String giftAddDate;
  int giftInHandQty;
  int giftOpeningStockQty;
  int giftQty;
  int giftStockId;
  int giftTypeId;
  String giftTypeText;
  int giftUtilisedQty;
  String referenceId;
  int tsoId;

  GiftStockModelList(
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
        this.tsoId});

  GiftStockModelList.fromJson(Map<String, dynamic> json) {
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
    data['tsoId'] = this.tsoId;
    return data;
  }
}