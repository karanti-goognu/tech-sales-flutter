class SaveEventFormModel {
  String venueAddress;
  String venue;
  String referenceId;
  int nonDalmiaInflCount;
  int giftDistributionCount;
  int expectedLeadsCount;
  int eventTypeId;
  String eventTime;
  int eventStatusId;
  double eventLocationLong;
  double eventLocationLat;
  String eventLocation;
  String eventDate;
  String eventComment;
  int dalmiaInflCount;
  List<EventDealerRequestsList> eventDealerRequestsList;

  SaveEventFormModel(
      {this.venueAddress,
      this.venue,
      this.referenceId,
      this.nonDalmiaInflCount,
      this.giftDistributionCount,
      this.expectedLeadsCount,
      this.eventTypeId,
      this.eventTime,
      this.eventStatusId,
      this.eventLocationLong,
      this.eventLocationLat,
      this.eventLocation,
      this.eventDate,
      this.eventComment,
      this.dalmiaInflCount,
      this.eventDealerRequestsList});

  SaveEventFormModel.fromJson(Map<String, dynamic> json) {
    venueAddress = json['venueAddress'];
    venue = json['venue'];
    nonDalmiaInflCount = json['nonDalmiaInflCount'];
    giftDistributionCount = json['giftDistributionCount'];
    expectedLeadsCount = json['expectedLeadsCount'];
    eventTypeId = json['eventTypeId'];
    eventTime = json['eventTime'];
    eventStatusId = json['eventStatusId'];
    eventLocationLong = json['eventLocationLong'];
    eventLocationLat = json['eventLocationLat'];
    eventLocation = json['eventLocation'];
    eventDate = json['eventDate'];
    eventComment = json['eventComment'];
    dalmiaInflCount = json['dalmiaInflCount'];

    if (json['eventDealerRequestsList'] != null) {
      eventDealerRequestsList = new List<EventDealerRequestsList>();
      json['eventDealerRequestsList'].forEach((v) {
        eventDealerRequestsList.add(new EventDealerRequestsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venueAddress'] = this.venueAddress;
    data['venue'] = this.venue;
    data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
    data['giftDistributionCount'] = this.giftDistributionCount;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTime'] = this.eventTime;
    data['eventStatusId'] = this.eventStatusId;
    data['eventLocationLong'] = this.eventLocationLong;
    data['eventLocationLat'] = this.eventLocationLat;
    data['eventLocation'] = this.eventLocation;
    data['eventDate'] = this.eventDate;
    data['eventComment'] = this.eventComment;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    if (this.eventDealerRequestsList != null) {
      data['eventDealerRequestsList'] =
          this.eventDealerRequestsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventDealerRequestsList {
  String eventStage;
  Null eventId;
  String dealerId;
  String createdBy;

  EventDealerRequestsList(
      {this.eventStage, this.eventId, this.dealerId, this.createdBy});
  EventDealerRequestsList.fromJson(Map<String, dynamic> json) {
    eventStage = json['eventStage'];
    eventId = json['eventId'];
    dealerId = json['dealerId'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventStage'] = this.eventStage;
    data['eventId'] = this.eventId;
    data['dealerId'] = this.dealerId;
    data['createdBy'] = this.createdBy;
    return data;
  }

}
