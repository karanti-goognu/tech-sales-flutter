class DetailEventModel {
  List<DealersModelList> dealersModelList;
  List<EventInfluencerModelsList> eventInfluencerModelsList;
  MwpEventModel mwpEventModel;
  String respCode;
  String respMsg;

  DetailEventModel(
      {this.dealersModelList,
        this.eventInfluencerModelsList,
        this.mwpEventModel,
        this.respCode,
        this.respMsg});

  DetailEventModel.fromJson(Map<String, dynamic> json) {
    if (json['dealersModelList'] != null) {
      dealersModelList = new List<DealersModelList>();
      json['dealersModelList'].forEach((v) {
        dealersModelList.add(new DealersModelList.fromJson(v));
      });
    }
    if (json['eventInfluencerModelsList'] != null) {
      eventInfluencerModelsList = new List<EventInfluencerModelsList>();
      json['eventInfluencerModelsList'].forEach((v) {
        eventInfluencerModelsList
            .add(new EventInfluencerModelsList.fromJson(v));
      });
    }
    mwpEventModel = json['mwpEventModel'] != null
        ? new MwpEventModel.fromJson(json['mwpEventModel'])
        : null;
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dealersModelList != null) {
      data['dealersModelList'] =
          this.dealersModelList.map((v) => v.toJson()).toList();
    }
    if (this.eventInfluencerModelsList != null) {
      data['eventInfluencerModelsList'] =
          this.eventInfluencerModelsList.map((v) => v.toJson()).toList();
    }
    if (this.mwpEventModel != null) {
      data['mwpEventModel'] = this.mwpEventModel.toJson();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

class DealersModelList {
  String createdBy;
  String createdOn;
  String dealerId;
  String dealerName;
  int eventDealerId;
  int eventId;
  String eventStage;
  String isActive;
  String modifiedBy;
  String modifiedOn;

  DealersModelList(
      {this.createdBy,
        this.createdOn,
        this.dealerId,
        this.dealerName,
        this.eventDealerId,
        this.eventId,
        this.eventStage,
        this.isActive,
        this.modifiedBy,
        this.modifiedOn});

  DealersModelList.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
    eventDealerId = json['eventDealerId'];
    eventId = json['eventId'];
    eventStage = json['eventStage'];
    isActive = json['isActive'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    data['eventDealerId'] = this.eventDealerId;
    data['eventId'] = this.eventId;
    data['eventStage'] = this.eventStage;
    data['isActive'] = this.isActive;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}

class EventInfluencerModelsList {
  int eventId;
  String inflContact;
  int inflId;
  String inflName;
  int inflTypeId;

  EventInfluencerModelsList(
      {this.eventId,
        this.inflContact,
        this.inflId,
        this.inflName,
        this.inflTypeId});

  EventInfluencerModelsList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    inflContact = json['inflContact'];
    inflId = json['inflId'];
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['inflContact'] = this.inflContact;
    data['inflId'] = this.inflId;
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
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
        this.eventEndUserLong});

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
    return data;
  }
}

