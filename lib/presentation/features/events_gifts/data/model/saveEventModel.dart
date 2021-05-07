
class SaveEventFormModel {
  List<EventDealersModelList> eventDealersModelList;
  //List<EventDealerRequestsList> eventDealerRequestsList;
  MwpeventFormRequest mwpeventFormRequest;

  SaveEventFormModel({this.eventDealersModelList, this.mwpeventFormRequest});

  SaveEventFormModel.fromJson(Map<String, dynamic> json) {
    if (json['eventDealersModelList'] != null) {
      eventDealersModelList = new List<EventDealersModelList>();
      json['eventDealersModelList'].forEach((v) {
        eventDealersModelList.add(new EventDealersModelList.fromJson(v));
      });
    }
    mwpeventFormRequest = json['mwpeventFormRequest'] != null
        ? new MwpeventFormRequest.fromJson(json['mwpeventFormRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventDealersModelList != null) {
      data['eventDealersModelList'] =
          this.eventDealersModelList.map((v) => v.toJson()).toList();
    }
    if (this.mwpeventFormRequest != null) {
      data['mwpeventFormRequest'] = this.mwpeventFormRequest.toJson();
    }
    return data;
  }
}

class EventDealersModelList {
  int eventDealerId;
  int eventId;
  String dealerId;
  String dealerName;
  String eventStage;
  String isActive;

  EventDealersModelList(
      {this.eventDealerId,
        this.eventId,
        this.dealerId,
        this.dealerName,
        this.eventStage,
        this.isActive});

  EventDealersModelList.fromJson(Map<String, dynamic> json) {
    eventDealerId = json['eventDealerId'];
    eventId = json['eventId'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
    eventStage = json['eventStage'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventDealerId'] = this.eventDealerId;
    data['eventId'] = this.eventId;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    data['eventStage'] = this.eventStage;
    data['isActive'] = this.isActive;
    return data;
  }
}

class MwpeventFormRequest {
  int dalmiaInflCount;
  String eventComment;
  String eventDate;
  int eventId;
  String eventLocation;
  double eventLocationLat;
  double eventLocationLong;
  int eventStatusId;
  String eventTime;
  int eventTypeId;
  int expectedLeadsCount;
  int giftDistributionCount;
  int nondalmiaInflCount;
  String referenceId;
  String venue;
  String venueAddress;
  int eventCancelReasonId;
  String eventCancelComment;
  String isEventStarted;

  MwpeventFormRequest(
      {this.dalmiaInflCount,
        this.eventComment,
        this.eventDate,
        this.eventId,
        this.eventLocation,
        this.eventLocationLat,
        this.eventLocationLong,
        this.eventStatusId,
        this.eventTime,
        this.eventTypeId,
        this.expectedLeadsCount,
        this.giftDistributionCount,
        this.nondalmiaInflCount,
        this.referenceId,
        this.venue,
        this.venueAddress,
        this.eventCancelReasonId,
        this.eventCancelComment,
        this.isEventStarted
      });

  MwpeventFormRequest.fromJson(Map<String, dynamic> json) {
    dalmiaInflCount = json['dalmiaInflCount'];
    eventComment = json['eventComment'];
    eventDate = json['eventDate'];
    eventId = json['eventId'];
    eventLocation = json['eventLocation'];
    eventLocationLat = json['eventLocationLat'];
    eventLocationLong = json['eventLocationLong'];
    eventStatusId = json['eventStatusId'];
    eventTime = json['eventTime'];
    eventTypeId = json['eventTypeId'];
    expectedLeadsCount = json['expectedLeadsCount'];
    giftDistributionCount = json['giftDistributionCount'];
    nondalmiaInflCount = json['nondalmiaInflCount'];
    referenceId = json['referenceId'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
    eventCancelReasonId = json['eventCancelReasonId'];
    eventCancelComment = json['eventCancelComment'];
    isEventStarted = json['isEventStarted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['eventComment'] = this.eventComment;
    data['eventDate'] = this.eventDate;
    data['eventId'] = this.eventId;
    data['eventLocation'] = this.eventLocation;
    data['eventLocationLat'] = this.eventLocationLat;
    data['eventLocationLong'] = this.eventLocationLong;
    data['eventStatusId'] = this.eventStatusId;
    data['eventTime'] = this.eventTime;
    data['eventTypeId'] = this.eventTypeId;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['giftDistributionCount'] = this.giftDistributionCount;
    data['nondalmiaInflCount'] = this.nondalmiaInflCount;
    data['referenceId'] = this.referenceId;
    data['venue'] = this.venue;
    data['venueAddress'] = this.venueAddress;
    data['eventCancelReasonId'] = this.eventCancelReasonId;
    data['eventCancelComment'] = this.eventCancelComment;
    data['isEventStarted'] = this.isEventStarted;
    return data;
  }
}





