class EndEventModel {
  List<EventCcommentsList> eventCcommentsList;
  List<EventDealersModelList> eventDealersModelList;
  List<EventInfluencerModelsList> eventInfluencerModelsList;
  MwpEndEventModel mwpEndEventModel;
  String respCode;
  String respMsg;
  bool showUpdateButton;

  EndEventModel(
      {this.eventCcommentsList,
        this.eventDealersModelList,
        this.eventInfluencerModelsList,
        this.mwpEndEventModel,
        this.respCode,
        this.respMsg,
        this.showUpdateButton});

  EndEventModel.fromJson(Map<String, dynamic> json) {
    if (json['eventCcommentsList'] != null) {
      eventCcommentsList = new List<EventCcommentsList>();
      json['eventCcommentsList'].forEach((v) {
        eventCcommentsList.add(new EventCcommentsList.fromJson(v));
      });
    }
    if (json['eventDealersModelList'] != null) {
      eventDealersModelList = new List<EventDealersModelList>();
      json['eventDealersModelList'].forEach((v) {
        eventDealersModelList.add(new EventDealersModelList.fromJson(v));
      });
    }
    if (json['eventInfluencerModelsList'] != null) {
      eventInfluencerModelsList = new List<EventInfluencerModelsList>();
      json['eventInfluencerModelsList'].forEach((v) {
        eventInfluencerModelsList
            .add(new EventInfluencerModelsList.fromJson(v));
      });
    }
    mwpEndEventModel = json['mwpEndEventModel'] != null
        ? new MwpEndEventModel.fromJson(json['mwpEndEventModel'])
        : null;
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    showUpdateButton = json['showUpdateButton'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventCcommentsList != null) {
      data['eventCcommentsList'] =
          this.eventCcommentsList.map((v) => v.toJson()).toList();
    }

    if (this.eventDealersModelList != null) {
      data['eventDealersModelList'] =
          this.eventDealersModelList.map((v) => v.toJson()).toList();
    }

    if (this.eventInfluencerModelsList != null) {
      data['eventInfluencerModelsList'] =
          this.eventInfluencerModelsList.map((v) => v.toJson()).toList();
    }
    if (this.mwpEndEventModel != null) {
      data['mwpEndEventModel'] = this.mwpEndEventModel.toJson();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['showUpdateButton'] = this.showUpdateButton;
    return data;
  }
}

class EventCcommentsList {
  String comments;
  String createdOn;
  String eventDate;
  int eventId;
  String referenceId;

  EventCcommentsList(
      {this.comments,
        this.createdOn,
        this.eventDate,
        this.eventId,
        this.referenceId});

  EventCcommentsList.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    createdOn = json['createdOn'];
    eventDate = json['eventDate'];
    eventId = json['eventId'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['createdOn'] = this.createdOn;
    data['eventDate'] = this.eventDate;
    data['eventId'] = this.eventId;
    data['referenceId'] = this.referenceId;
    return data;
  }
}

class EventDealersModelList {
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

  EventDealersModelList(
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

  EventDealersModelList.fromJson(Map<String, dynamic> json) {
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
  int eventInflId;
  String inflContact;
  int inflId;
  String inflName;
  int inflTypeId;
  String isActive;

  EventInfluencerModelsList(
      {this.eventId,
        this.eventInflId,
        this.inflContact,
        this.inflId,
        this.inflName,
        this.inflTypeId,
        this.isActive});

  EventInfluencerModelsList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventInflId = json['eventInflId'];
    inflContact = json['inflContact'];
    inflId = json['inflId'];
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventInflId'] = this.eventInflId;
    data['inflContact'] = this.inflContact;
    data['inflId'] = this.inflId;
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
    data['isActive'] = this.isActive;
    return data;
  }
}

class MwpEndEventModel {
  int actualDalmiaInflCount;
  String actualEventLocation;
  String actualEventLocationLat;
  String actualEventLocationLong;
  int actualGiftDistributionCount;
  int actualLeadsCount;
  int actualNonDalmiaInflCount;
  int actualTotalParticipantsCount;
  String actualVenue;
  String actualVenueAddress;
  int dalmiaInflCount;
  String eventApprovedBy;
  String eventApprovedOn;
  String eventCancelComment;
  int eventCancelReasonId;
  String eventCancelReasonText;
  String eventCancelledOn;
  String eventComment;
  String eventCompleteRejectedBy;
  String eventCompleteRejectedOn;
  String eventCompletedOn;
  String eventCreatedBy;
  String eventCreatedOn;
  String eventDate;
  String eventEmailUniqueId;
  String eventEndOn;
  String eventEndUserLat;
  String eventEndUserLong;
  int eventId;
  String eventLocation;
  String eventLocationLat;
  String eventLocationLong;
  String eventRejectedBy;
  String eventRejectedOn;
  String eventStage;
  String eventStartOn;
  String eventStartUserLat;
  String eventStartUserLong;
  int eventStatusId;
  String eventStatusText;
  String eventSubmittedOn;
  String eventTime;
  int eventTypeId;
  String eventTypeText;
  int expectedLeadsCount;
  int giftDistributionCount;
  String isEventStarted;
  int nonDalmiaInflCount;
  String referenceId;
  String techOfferName;
  int totalParticipantsCount;
  int tsoId;
  String venue;
  String venueAddress;

  MwpEndEventModel(
      {this.actualDalmiaInflCount,
        this.actualEventLocation,
        this.actualEventLocationLat,
        this.actualEventLocationLong,
        this.actualGiftDistributionCount,
        this.actualLeadsCount,
        this.actualNonDalmiaInflCount,
        this.actualTotalParticipantsCount,
        this.actualVenue,
        this.actualVenueAddress,
        this.dalmiaInflCount,
        this.eventApprovedBy,
        this.eventApprovedOn,
        this.eventCancelComment,
        this.eventCancelReasonId,
        this.eventCancelReasonText,
        this.eventCancelledOn,
        this.eventComment,
        this.eventCompleteRejectedBy,
        this.eventCompleteRejectedOn,
        this.eventCompletedOn,
        this.eventCreatedBy,
        this.eventCreatedOn,
        this.eventDate,
        this.eventEmailUniqueId,
        this.eventEndOn,
        this.eventEndUserLat,
        this.eventEndUserLong,
        this.eventId,
        this.eventLocation,
        this.eventLocationLat,
        this.eventLocationLong,
        this.eventRejectedBy,
        this.eventRejectedOn,
        this.eventStage,
        this.eventStartOn,
        this.eventStartUserLat,
        this.eventStartUserLong,
        this.eventStatusId,
        this.eventStatusText,
        this.eventSubmittedOn,
        this.eventTime,
        this.eventTypeId,
        this.eventTypeText,
        this.expectedLeadsCount,
        this.giftDistributionCount,
        this.isEventStarted,
        this.nonDalmiaInflCount,
        this.referenceId,
        this.techOfferName,
        this.totalParticipantsCount,
        this.tsoId,
        this.venue,
        this.venueAddress});

  MwpEndEventModel.fromJson(Map<String, dynamic> json) {
    actualDalmiaInflCount = json['actualDalmiaInflCount'];
    actualEventLocation = json['actualEventLocation'];
    actualEventLocationLat = json['actualEventLocationLat'];
    actualEventLocationLong = json['actualEventLocationLong'];
    actualGiftDistributionCount = json['actualGiftDistributionCount'];
    actualLeadsCount = json['actualLeadsCount'];
    actualNonDalmiaInflCount = json['actualNonDalmiaInflCount'];
    actualTotalParticipantsCount = json['actualTotalParticipantsCount'];
    actualVenue = json['actualVenue'];
    actualVenueAddress = json['actualVenueAddress'];
    dalmiaInflCount = json['dalmiaInflCount'];
    eventApprovedBy = json['eventApprovedBy'];
    eventApprovedOn = json['eventApprovedOn'];
    eventCancelComment = json['eventCancelComment'];
    eventCancelReasonId = json['eventCancelReasonId'];
    eventCancelReasonText = json['eventCancelReasonText'];
    eventCancelledOn = json['eventCancelledOn'];
    eventComment = json['eventComment'];
    eventCompleteRejectedBy = json['eventCompleteRejectedBy'];
    eventCompleteRejectedOn = json['eventCompleteRejectedOn'];
    eventCompletedOn = json['eventCompletedOn'];
    eventCreatedBy = json['eventCreatedBy'];
    eventCreatedOn = json['eventCreatedOn'];
    eventDate = json['eventDate'];
    eventEmailUniqueId = json['eventEmailUniqueId'];
    eventEndOn = json['eventEndOn'];
    eventEndUserLat = json['eventEndUserLat'];
    eventEndUserLong = json['eventEndUserLong'];
    eventId = json['eventId'];
    eventLocation = json['eventLocation'];
    eventLocationLat = json['eventLocationLat'];
    eventLocationLong = json['eventLocationLong'];
    eventRejectedBy = json['eventRejectedBy'];
    eventRejectedOn = json['eventRejectedOn'];
    eventStage = json['eventStage'];
    eventStartOn = json['eventStartOn'];
    eventStartUserLat = json['eventStartUserLat'];
    eventStartUserLong = json['eventStartUserLong'];
    eventStatusId = json['eventStatusId'];
    eventStatusText = json['eventStatusText'];
    eventSubmittedOn = json['eventSubmittedOn'];
    eventTime = json['eventTime'];
    eventTypeId = json['eventTypeId'];
    eventTypeText = json['eventTypeText'];
    expectedLeadsCount = json['expectedLeadsCount'];
    giftDistributionCount = json['giftDistributionCount'];
    isEventStarted = json['isEventStarted'];
    nonDalmiaInflCount = json['nonDalmiaInflCount'];
    referenceId = json['referenceId'];
    techOfferName = json['techOfferName'];
    totalParticipantsCount = json['totalParticipantsCount'];
    tsoId = json['tsoId'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualDalmiaInflCount'] = this.actualDalmiaInflCount;
    data['actualEventLocation'] = this.actualEventLocation;
    data['actualEventLocationLat'] = this.actualEventLocationLat;
    data['actualEventLocationLong'] = this.actualEventLocationLong;
    data['actualGiftDistributionCount'] = this.actualGiftDistributionCount;
    data['actualLeadsCount'] = this.actualLeadsCount;
    data['actualNonDalmiaInflCount'] = this.actualNonDalmiaInflCount;
    data['actualTotalParticipantsCount'] = this.actualTotalParticipantsCount;
    data['actualVenue'] = this.actualVenue;
    data['actualVenueAddress'] = this.actualVenueAddress;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['eventApprovedBy'] = this.eventApprovedBy;
    data['eventApprovedOn'] = this.eventApprovedOn;
    data['eventCancelComment'] = this.eventCancelComment;
    data['eventCancelReasonId'] = this.eventCancelReasonId;
    data['eventCancelReasonText'] = this.eventCancelReasonText;
    data['eventCancelledOn'] = this.eventCancelledOn;
    data['eventComment'] = this.eventComment;
    data['eventCompleteRejectedBy'] = this.eventCompleteRejectedBy;
    data['eventCompleteRejectedOn'] = this.eventCompleteRejectedOn;
    data['eventCompletedOn'] = this.eventCompletedOn;
    data['eventCreatedBy'] = this.eventCreatedBy;
    data['eventCreatedOn'] = this.eventCreatedOn;
    data['eventDate'] = this.eventDate;
    data['eventEmailUniqueId'] = this.eventEmailUniqueId;
    data['eventEndOn'] = this.eventEndOn;
    data['eventEndUserLat'] = this.eventEndUserLat;
    data['eventEndUserLong'] = this.eventEndUserLong;
    data['eventId'] = this.eventId;
    data['eventLocation'] = this.eventLocation;
    data['eventLocationLat'] = this.eventLocationLat;
    data['eventLocationLong'] = this.eventLocationLong;
    data['eventRejectedBy'] = this.eventRejectedBy;
    data['eventRejectedOn'] = this.eventRejectedOn;
    data['eventStage'] = this.eventStage;
    data['eventStartOn'] = this.eventStartOn;
    data['eventStartUserLat'] = this.eventStartUserLat;
    data['eventStartUserLong'] = this.eventStartUserLong;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatusText'] = this.eventStatusText;
    data['eventSubmittedOn'] = this.eventSubmittedOn;
    data['eventTime'] = this.eventTime;
    data['eventTypeId'] = this.eventTypeId;
    data['eventTypeText'] = this.eventTypeText;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['giftDistributionCount'] = this.giftDistributionCount;
    data['isEventStarted'] = this.isEventStarted;
    data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
    data['referenceId'] = this.referenceId;
    data['techOfferName'] = this.techOfferName;
    data['totalParticipantsCount'] = this.totalParticipantsCount;
    data['tsoId'] = this.tsoId;
    data['venue'] = this.venue;
    data['venueAddress'] = this.venueAddress;
    return data;
  }

}

class EndEventDetailModel{
  String eventComment;
  String eventDate;
  double eventEndLat;
  double eventEndLong;
  int eventId;
  String referenceId;

  EndEventDetailModel(this.eventComment, this.eventDate, this.eventEndLat, this.eventEndLong, this.eventId, this.referenceId);

  EndEventDetailModel.fromJson(Map<String, dynamic> json) {
    eventComment = json['eventComment'];
    eventDate = json['eventDate'];
    eventEndLat = json['eventEndLat'];
    eventEndLong = json['eventEndLong'];
    eventId = json['eventId'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventComment'] = this.eventComment;
    data['eventDate'] = this.eventDate;
    data['eventEndLat'] = this.eventEndLat;
    data['eventEndLong'] = this.eventEndLong;
    data['eventId'] = this.eventId;
    data['referenceId'] = this.referenceId;
    return data;
  }


}