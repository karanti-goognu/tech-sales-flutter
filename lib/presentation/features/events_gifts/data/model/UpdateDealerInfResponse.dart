import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventDealersModelList.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventInfluencerModelList.dart';

class UpdateDealerInfResponse {
  List<DealersModel>? dealersModel;
  List<EventDealersModelList>? eventDealersModelList;
  List<EventInfluencerModelList>? eventInfluencerModelList;
  String? respCode;
  String? respMsg;

  UpdateDealerInfResponse(
      {this.dealersModel,
      this.eventDealersModelList,
      this.eventInfluencerModelList,
      this.respCode,
      this.respMsg});

  UpdateDealerInfResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('dealers-model'))
      dealersModel = new List<DealersModel>.empty(growable: true);

    if (json['dealers-model'] != null) {
      dealersModel = new List<DealersModel>.empty(growable: true);
      json['dealers-model'].forEach((v) {
        dealersModel!.add(new DealersModel.fromJson(v));
      });
    }

    if (!json.containsKey('event-dealers-model-list'))
      eventDealersModelList =
          new List<EventDealersModelList>.empty(growable: true);

    if (json['event-dealers-model-list'] != null) {
      eventDealersModelList =
          new List<EventDealersModelList>.empty(growable: true);
      json['event-dealers-model-list'].forEach((v) {
        eventDealersModelList!.add(new EventDealersModelList.fromJson(v));
      });
    }

    if (!json.containsKey('event-influencer-model-list'))
      eventInfluencerModelList =
          new List<EventInfluencerModelList>.empty(growable: true);

    if (json['event-influencer-model-list'] != null) {
      eventInfluencerModelList =
          new List<EventInfluencerModelList>.empty(growable: true);
      json['event-influencer-model-list'].forEach((v) {
        eventInfluencerModelList!.add(new EventInfluencerModelList.fromJson(v));
      });
    }
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dealersModel != null) {
      data['dealers-model'] =
          this.dealersModel!.map((v) => v.toJson()).toList();
    }
    if (this.eventDealersModelList != null) {
      data['event-dealers-model-list'] =
          this.eventDealersModelList!.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerModelList != null) {
      data['event-influencer-model-list'] =
          this.eventInfluencerModelList!.map((v) => v.toJson()).toList();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

class DealersModel {
  String? dealerId;
  String? dealerName;

  DealersModel({this.dealerId, this.dealerName});

  DealersModel.fromJson(Map<String, dynamic> json) {
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
