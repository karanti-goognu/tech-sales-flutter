

import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventDealersModelList.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventInfluencerModelList.dart';

class DealerInfModel {
  String? respCode;
  String? respMsg;
  List<EventDealersModelList>? eventDealersModelList;
  List<EventInfluencerModelList>? eventInfluencerModelList;
  List<DealersModel>? dealersModel;

  DealerInfModel(
      {this.respCode,
        this.respMsg,
        this.eventDealersModelList,
        this.eventInfluencerModelList,
        this.dealersModel});

  DealerInfModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['event-dealers-model-list'] != null) {
      eventDealersModelList = new List<EventDealersModelList>.empty(growable: true);
      json['event-dealers-model-list'].forEach((v) {
        eventDealersModelList!.add(new EventDealersModelList.fromJson(v));
      });
    }
    if (json['event-influencer-model-list'] != null) {
      eventInfluencerModelList = new List<EventInfluencerModelList>.empty(growable: true);
      json['event-influencer-model-list'].forEach((v) {
        eventInfluencerModelList!.add(new EventInfluencerModelList.fromJson(v));
      });
    }
    if (json['dealers-model'] != null) {
      dealersModel = new List<DealersModel>.empty(growable: true);
      json['dealers-model'].forEach((v) {
        dealersModel!.add(new DealersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.eventDealersModelList != null) {
      data['event-dealers-model-list'] =
          this.eventDealersModelList!.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerModelList != null) {
      data['event-influencer-model-list'] =
          this.eventInfluencerModelList!.map((v) => v.toJson()).toList();
    }
    if (this.dealersModel != null) {
      data['dealers-model'] = this.dealersModel!.map((v) => v.toJson()).toList();
    }
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

