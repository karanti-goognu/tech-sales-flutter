import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventListModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventStatusEntity.dart';

class ApprovedEventsModel {
  String? respCode;
  String? respMsg;
  List<EventListModels>? eventListModels;
  List<EventStatusEntities>? eventStatusEntities;

  ApprovedEventsModel(
      {this.respCode,
        this.respMsg,
        this.eventListModels,
        this.eventStatusEntities});

  ApprovedEventsModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['eventListModels'] != null) {
      eventListModels = new List<EventListModels>.empty(growable: true);
      json['eventListModels'].forEach((v) {
        eventListModels!.add(new EventListModels.fromJson(v));
      });
    }
    if (json['eventStatusEntities'] != null) {
      eventStatusEntities = new List<EventStatusEntities>.empty(growable: true);
      json['eventStatusEntities'].forEach((v) {
        eventStatusEntities!.add(new EventStatusEntities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.eventListModels != null) {
      data['eventListModels'] =
          this.eventListModels!.map((v) => v.toJson()).toList();
    }
    if (this.eventStatusEntities != null) {
      data['eventStatusEntities'] =
          this.eventStatusEntities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



