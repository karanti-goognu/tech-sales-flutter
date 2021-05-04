import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';

class EventSearchModel {
  List<EventListModels> eventListModels;
  List<EventStatusEntities> eventStatusEntities;
  String respCode;
  String respMsg;

  EventSearchModel(
      {this.eventListModels,
        this.eventStatusEntities,
        this.respCode,
        this.respMsg});

  EventSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['eventListModels'] != null) {
      eventListModels = new List<EventListModels>();
      json['eventListModels'].forEach((v) {
        eventListModels.add(new EventListModels.fromJson(v));
      });
    }
    if (json['eventStatusEntities'] != null) {
      eventStatusEntities = new List<EventStatusEntities>();
      json['eventStatusEntities'].forEach((v) {
        eventStatusEntities.add(new EventStatusEntities.fromJson(v));
      });
    }
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventListModels != null) {
      data['eventListModels'] =
          this.eventListModels.map((v) => v.toJson()).toList();
    }
    if (this.eventStatusEntities != null) {
      data['eventStatusEntities'] =
          this.eventStatusEntities.map((v) => v.toJson()).toList();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

//class EventListModels {
//  int actualEventInflCount;
//  String actualEventVenue;
//  int count;
//  String dealerName;
//  String eventDate;
//  int eventId;
//  int eventInflCount;
//  int eventStatusId;
//  String eventStatusText;
//  int eventTypeId;
//  String eventTypeText;
//  String eventVenue;
//  int expectedLeadsCount;
//
//  EventListModels(
//      {this.actualEventInflCount,
//        this.actualEventVenue,
//        this.count,
//        this.dealerName,
//        this.eventDate,
//        this.eventId,
//        this.eventInflCount,
//        this.eventStatusId,
//        this.eventStatusText,
//        this.eventTypeId,
//        this.eventTypeText,
//        this.eventVenue,
//        this.expectedLeadsCount});
//
//  EventListModels.fromJson(Map<String, dynamic> json) {
//    actualEventInflCount = json['actualEventInflCount'];
//    actualEventVenue = json['actualEventVenue'];
//    count = json['count'];
//    dealerName = json['dealerName'];
//    eventDate = json['eventDate'];
//    eventId = json['eventId'];
//    eventInflCount = json['eventInflCount'];
//    eventStatusId = json['eventStatusId'];
//    eventStatusText = json['eventStatusText'];
//    eventTypeId = json['eventTypeId'];
//    eventTypeText = json['eventTypeText'];
//    eventVenue = json['eventVenue'];
//    expectedLeadsCount = json['expectedLeadsCount'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['actualEventInflCount'] = this.actualEventInflCount;
//    data['actualEventVenue'] = this.actualEventVenue;
//    data['count'] = this.count;
//    data['dealerName'] = this.dealerName;
//    data['eventDate'] = this.eventDate;
//    data['eventId'] = this.eventId;
//    data['eventInflCount'] = this.eventInflCount;
//    data['eventStatusId'] = this.eventStatusId;
//    data['eventStatusText'] = this.eventStatusText;
//    data['eventTypeId'] = this.eventTypeId;
//    data['eventTypeText'] = this.eventTypeText;
//    data['eventVenue'] = this.eventVenue;
//    data['expectedLeadsCount'] = this.expectedLeadsCount;
//    return data;
//  }
//}

//class EventStatusEntities {
//  int eventStatusId;
//  String eventStatusText;
//
//  EventStatusEntities({this.eventStatusId, this.eventStatusText});
//
//  EventStatusEntities.fromJson(Map<String, dynamic> json) {
//    eventStatusId = json['eventStatusId'];
//    eventStatusText = json['eventStatusText'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['eventStatusId'] = this.eventStatusId;
//    data['eventStatusText'] = this.eventStatusText;
//    return data;
//  }
//}