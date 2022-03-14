class DetailEventModel {
  String respCode;
  String respMsg;
  MwpEventModel mwpEventModel;
  List<EventDealersModelList> eventDealersModelList;
  List<Null> eventInfluencerModelsList;
  List<CancelReasonList> cancelReasonList;
  List<DealersModels> dealersModels;

  DetailEventModel(
      {this.respCode,
        this.respMsg,
        this.mwpEventModel,
        this.eventDealersModelList,
        this.eventInfluencerModelsList,
        this.cancelReasonList,
        this.dealersModels});

  DetailEventModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    mwpEventModel = json['mwpEventModel'] != null
        ? new MwpEventModel.fromJson(json['mwpEventModel'])
        : null;
    if (json['eventDealersModelList'] != null) {
      eventDealersModelList = new List<EventDealersModelList>.empty(growable: true);
      json['eventDealersModelList'].forEach((v) {
        eventDealersModelList.add(new EventDealersModelList.fromJson(v));
      });
    }
    if (json['eventInfluencerModelsList'] != null) {
      // eventInfluencerModelsList = new List<Null>();
      // json['eventInfluencerModelsList'].forEach((v) {
      //   eventInfluencerModelsList.add(new Null.fromJson(v));
      // });
    }
    if (json['cancelReasonList'] != null) {
      cancelReasonList = new List<CancelReasonList>.empty(growable: true);
      json['cancelReasonList'].forEach((v) {
        cancelReasonList.add(new CancelReasonList.fromJson(v));
      });
    }
    if (json['dealersModels'] != null) {
      dealersModels = new List<DealersModels>.empty(growable: true);
      json['dealersModels'].forEach((v) {
        dealersModels.add(new DealersModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.mwpEventModel != null) {
      data['mwpEventModel'] = this.mwpEventModel.toJson();
    }
    if (this.eventDealersModelList != null) {
      data['eventDealersModelList'] =
          this.eventDealersModelList.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerModelsList != null) {
      // data['eventInfluencerModelsList'] =
      //     this.eventInfluencerModelsList.map((v) => v.toJson()).toList();
    }
    if (this.cancelReasonList != null) {
      data['cancelReasonList'] =
          this.cancelReasonList.map((v) => v.toJson()).toList();
    }
    if (this.dealersModels != null) {
      data['dealersModels'] =
          this.dealersModels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MwpEventModel {
  int eventId;
  int tsoId;
  String techOfferName;
  String referenceId;
  int eventTypeId;
  String eventTypeText;
  String eventDate;
  String eventTime;
  int dalmiaInflCount;
  int nonDalmiaInflCount;
  int actualDalmiaInflCount;
  int actualNonDalmiaInflCount;
  String venue;
  String venueAddress;
  String actualVenue;
  String actualVenueAddress;
  int expectedLeadsCount;
  int giftDistributionCount;
  int actualGiftDistributionCount;
  String eventLocation;
  String eventLocationLat;
  String eventLocationLong;
  String actualEventLocation;
  String actualEventLocationLat;
  String actualEventLocationLong;
  String eventComment;
  int eventStatusId;
  String eventStatusText;
  String eventStage;
  String eventCreatedBy;
  String eventCreatedOn;
  String eventSubmittedOn;
  String eventApprovedBy;
  String eventApprovedOn;
  String eventRejectedOn;
  String eventRejectedBy;
  String eventCancelledOn;
  int eventCancelReasonId;
  String eventCancelReasonText;
  String eventCancelComment;
  String eventCompletedOn;
  String eventCompleteRejectedBy;
  String eventCompleteRejectedOn;
  String eventStartOn;
  String eventEndOn;
  String eventEmailUniqueId;
  String eventStartUserLat;
  String eventStartUserLong;
  String eventEndUserLat;
  String eventEndUserLong;
  String isEventStarted;
  MwpEventModel(
      {this.eventId,
        this.tsoId,
        this.techOfferName,
        this.referenceId,
        this.eventTypeId,
        this.eventTypeText,
        this.eventDate,
        this.eventTime,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.actualDalmiaInflCount,
        this.actualNonDalmiaInflCount,
        this.venue,
        this.venueAddress,
        this.actualVenue,
        this.actualVenueAddress,
        this.expectedLeadsCount,
        this.giftDistributionCount,
        this.actualGiftDistributionCount,
        this.eventLocation,
        this.eventLocationLat,
        this.eventLocationLong,
        this.actualEventLocation,
        this.actualEventLocationLat,
        this.actualEventLocationLong,
        this.eventComment,
        this.eventStatusId,
        this.eventStatusText,
        this.eventStage,
        this.eventCreatedBy,
        this.eventCreatedOn,
        this.eventSubmittedOn,
        this.eventApprovedBy,
        this.eventApprovedOn,
        this.eventRejectedOn,
        this.eventRejectedBy,
        this.eventCancelledOn,
        this.eventCancelReasonId,
        this.eventCancelReasonText,
        this.eventCancelComment,
        this.eventCompletedOn,
        this.eventCompleteRejectedBy,
        this.eventCompleteRejectedOn,
        this.eventStartOn,
        this.eventEndOn,
        this.eventEmailUniqueId,
        this.eventStartUserLat,
        this.eventStartUserLong,
        this.eventEndUserLat,
        this.eventEndUserLong,
        this.isEventStarted,
      });

  MwpEventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    tsoId = json['tsoId'];
    techOfferName = json['techOfferName'];
    referenceId = json['referenceId'];
    eventTypeId = json['eventTypeId'];
    eventTypeText = json['eventTypeText'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    dalmiaInflCount = json['dalmiaInflCount'];
    nonDalmiaInflCount = json['non_dalmiaInflCount'];
    actualDalmiaInflCount = json['actualDalmiaInflCount'];
    actualNonDalmiaInflCount = json['actualNonDalmiaInflCount'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
    actualVenue = json['actualVenue'];
    actualVenueAddress = json['actualVenueAddress'];
    expectedLeadsCount = json['expectedLeadsCount'];
    giftDistributionCount = json['giftDistributionCount'];
    actualGiftDistributionCount = json['actualGiftDistributionCount'];
    eventLocation = json['eventLocation'];
    eventLocationLat = json['eventLocationLat'];
    eventLocationLong = json['eventLocationLong'];
    actualEventLocation = json['actualEventLocation'];
    actualEventLocationLat = json['actualEventLocationLat'];
    actualEventLocationLong = json['actualEventLocationLong'];
    eventComment = json['eventComment'];
    eventStatusId = json['eventStatusId'];
    eventStatusText = json['eventStatusText'];
    eventStage = json['eventStage'];
    eventCreatedBy = json['eventCreatedBy'];
    eventCreatedOn = json['eventCreatedOn'];
    eventSubmittedOn = json['eventSubmittedOn'];
    eventApprovedBy = json['eventApprovedBy'];
    eventApprovedOn = json['eventApprovedOn'];
    eventRejectedOn = json['eventRejectedOn'];
    eventRejectedBy = json['eventRejectedBy'];
    eventCancelledOn = json['eventCancelledOn'];
    eventCancelReasonId = json['eventCancelReasonId'];
    eventCancelReasonText = json['eventCancelReasonText'];
    eventCancelComment = json['eventCancelComment'];
    eventCompletedOn = json['eventCompletedOn'];
    eventCompleteRejectedBy = json['eventCompleteRejectedBy'];
    eventCompleteRejectedOn = json['eventCompleteRejectedOn'];
    eventStartOn = json['eventStartOn'];
    eventEndOn = json['eventEndOn'];
    eventEmailUniqueId = json['eventEmailUniqueId'];
    eventStartUserLat = json['eventStartUserLat'];
    eventStartUserLong = json['eventStartUserLong'];
    eventEndUserLat = json['eventEndUserLat'];
    eventEndUserLong = json['eventEndUserLong'];
    isEventStarted = json['isEventStarted'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['tsoId'] = this.tsoId;
    data['techOfferName'] = this.techOfferName;
    data['referenceId'] = this.referenceId;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeText'] = this.eventTypeText;
    data['eventDate'] = this.eventDate;
    data['eventTime'] = this.eventTime;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['non_dalmiaInflCount'] = this.nonDalmiaInflCount;
    data['actualDalmiaInflCount'] = this.actualDalmiaInflCount;
    data['actualNonDalmiaInflCount'] = this.actualNonDalmiaInflCount;
    data['venue'] = this.venue;
    data['venueAddress'] = this.venueAddress;
    data['actualVenue'] = this.actualVenue;
    data['actualVenueAddress'] = this.actualVenueAddress;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['giftDistributionCount'] = this.giftDistributionCount;
    data['actualGiftDistributionCount'] = this.actualGiftDistributionCount;
    data['eventLocation'] = this.eventLocation;
    data['eventLocationLat'] = this.eventLocationLat;
    data['eventLocationLong'] = this.eventLocationLong;
    data['actualEventLocation'] = this.actualEventLocation;
    data['actualEventLocationLat'] = this.actualEventLocationLat;
    data['actualEventLocationLong'] = this.actualEventLocationLong;
    data['eventComment'] = this.eventComment;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatusText'] = this.eventStatusText;
    data['eventStage'] = this.eventStage;
    data['eventCreatedBy'] = this.eventCreatedBy;
    data['eventCreatedOn'] = this.eventCreatedOn;
    data['eventSubmittedOn'] = this.eventSubmittedOn;
    data['eventApprovedBy'] = this.eventApprovedBy;
    data['eventApprovedOn'] = this.eventApprovedOn;
    data['eventRejectedOn'] = this.eventRejectedOn;
    data['eventRejectedBy'] = this.eventRejectedBy;
    data['eventCancelledOn'] = this.eventCancelledOn;
    data['eventCancelReasonId'] = this.eventCancelReasonId;
    data['eventCancelReasonText'] = this.eventCancelReasonText;
    data['eventCancelComment'] = this.eventCancelComment;
    data['eventCompletedOn'] = this.eventCompletedOn;
    data['eventCompleteRejectedBy'] = this.eventCompleteRejectedBy;
    data['eventCompleteRejectedOn'] = this.eventCompleteRejectedOn;
    data['eventStartOn'] = this.eventStartOn;
    data['eventEndOn'] = this.eventEndOn;
    data['eventEmailUniqueId'] = this.eventEmailUniqueId;
    data['eventStartUserLat'] = this.eventStartUserLat;
    data['eventStartUserLong'] = this.eventStartUserLong;
    data['eventEndUserLat'] = this.eventEndUserLat;
    data['eventEndUserLong'] = this.eventEndUserLong;
    data['isEventStarted'] = this.isEventStarted;
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

class CancelReasonList {
  int eventCancelReasonId;
  String eventCancelReason;

  CancelReasonList({this.eventCancelReasonId, this.eventCancelReason});

  CancelReasonList.fromJson(Map<String, dynamic> json) {
    eventCancelReasonId = json['eventCancelReasonId'];
    eventCancelReason = json['eventCancelReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventCancelReasonId'] = this.eventCancelReasonId;
    data['eventCancelReason'] = this.eventCancelReason;
    return data;
  }
}

class DealersModels {
  String dealerId;
  String dealerName;

  DealersModels({this.dealerId, this.dealerName});

  DealersModels.fromJson(Map<String, dynamic> json) {
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

