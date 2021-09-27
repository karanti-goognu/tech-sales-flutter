class AddLeadInitialModel {
  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;
  List<DealerList> dealerList;
  List<SubDealerList> subDealerList;
  List<SalesOfficerList> salesOfficerList;
  List<EventList> eventList;

  AddLeadInitialModel(
      {this.siteSubTypeEntity,
      this.influencerCategoryEntity,
      this.influencerTypeEntity,
        this.dealerList,
        this.subDealerList,
        this.salesOfficerList,
        this.eventList});

  AddLeadInitialModel.fromJson(Map<String, dynamic> json) {
    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>();
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>();
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
    if (json['dealerList'] != null) {
      dealerList = new List<DealerList>();
      json['dealerList'].forEach((v) {
        dealerList.add(new DealerList.fromJson(v));
      });
    }
    if (json['subDealerList'] != null) {
      subDealerList = new List<SubDealerList>();
      json['subDealerList'].forEach((v) {
        subDealerList.add(new SubDealerList.fromJson(v));
      });
    }
    if (json['salesOfficerList'] != null) {
      salesOfficerList = new List<SalesOfficerList>();
      json['salesOfficerList'].forEach((v) {
        salesOfficerList.add(new SalesOfficerList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = new List<EventList>();
      json['eventList'].forEach((v) {
        eventList.add(new EventList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siteSubTypeEntity != null) {
      data['siteSubTypeEntity'] =
          this.siteSubTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerTypeEntity != null) {
      data['influencerTypeEntity'] =
          this.influencerTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.dealerList != null) {
      data['dealerList'] = this.dealerList.map((v) => v.toJson()).toList();
    }
    if (this.subDealerList != null) {
      data['subDealerList'] =
          this.subDealerList.map((v) => v.toJson()).toList();
    }
    if (this.salesOfficerList != null) {
      data['salesOfficerList'] =
          this.salesOfficerList.map((v) => v.toJson()).toList();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiteSubTypeEntity {
  int siteSubId;
  String siteSubTypeDesc;

  SiteSubTypeEntity({this.siteSubId, this.siteSubTypeDesc});

  SiteSubTypeEntity.fromJson(Map<String, dynamic> json) {
    siteSubId = json['siteSubId'];
    siteSubTypeDesc = json['siteSubTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteSubId'] = this.siteSubId;
    data['siteSubTypeDesc'] = this.siteSubTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntity {
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryEntity({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
    inflCatId = json['inflCatId'];
    inflCatDesc = json['inflCatDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflCatId'] = this.inflCatId;
    data['inflCatDesc'] = this.inflCatDesc;
    return data;
  }
}

class InfluencerTypeEntity {
  int inflTypeId;
  String inflTypeDesc;

  InfluencerTypeEntity({this.inflTypeId, this.inflTypeDesc});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    return data;
  }
}

class DealerList {
  String dealerId;
  String dealerName;

  DealerList({this.dealerId, this.dealerName});

  DealerList.fromJson(Map<String, dynamic> json) {
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
class SubDealerList {
  String dealerId;
  String dealerName;

  SubDealerList({this.dealerId, this.dealerName});

  SubDealerList.fromJson(Map<String, dynamic> json) {
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

class SalesOfficerList {
  String salesOfficerId;
  String salesOfficerName;

  SalesOfficerList({this.salesOfficerId, this.salesOfficerName});

  SalesOfficerList.fromJson(Map<String, dynamic> json) {
    salesOfficerId = json['salesOfficerId'];
    salesOfficerName = json['salesOfficerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOfficerId'] = this.salesOfficerId;
    data['salesOfficerName'] = this.salesOfficerName;
    return data;
  }
}

class EventList {
  int eventId;
  int tsoId;
  String referenceId;
  int eventTypeId;
  int eventDate;
  String eventTime;
  int dalmiaInflCount;
  int nonDalmiaInflCount;
  int actualDalmiaInflCount;
  int actualNonDalmiaInflCount;
  String isEventStarted;
  String venue;
  String venueAddress;
  String actualVenue;
  String actualVenueAddress;
  int expectedLeadsCount;
  int giftDistributionCount;
  int actualGiftDistributionCount;
  String eventLocation;
  double eventLocationLat;
  double eventLocationLong;
  String actualEventLocation;
  double actualEventLocationLat;
  double actualEventLocationLong;
  String eventComment;
  int eventStatusId;
  String eventStage;
  String eventCreatedBy;
  int eventCreatedOn;
  int eventSubmittedOn;
  String eventApprovedBy;
  String eventApprovedOn;
  String eventRejectedOn;
  String eventRejectedBy;
  String eventCancelledOn;
  int eventCancelReasonId;
  String eventCancelComment;
  int eventCompletedOn;
  String eventCompleteRejectedBy;
  String eventCompleteRejectedOn;
  int eventStartOn;
  int eventEndOn;
  String eventEmailUniqueId;
  double eventStartUserLat;
  double eventStartUserLong;
  double eventEndUserLat;
  double eventEndUserLong;

  EventList(
      {this.eventId,
        this.tsoId,
        this.referenceId,
        this.eventTypeId,
        this.eventDate,
        this.eventTime,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.actualDalmiaInflCount,
        this.actualNonDalmiaInflCount,
        this.isEventStarted,
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

  EventList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    tsoId = json['tsoId'];
    referenceId = json['referenceId'];
    eventTypeId = json['eventTypeId'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    dalmiaInflCount = json['dalmiaInflCount'];
    nonDalmiaInflCount = json['nonDalmiaInflCount'];
    actualDalmiaInflCount = json['actualDalmiaInflCount'];
    actualNonDalmiaInflCount = json['actualNonDalmiaInflCount'];
    isEventStarted = json['isEventStarted'];
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
    data['referenceId'] = this.referenceId;
    data['eventTypeId'] = this.eventTypeId;
    data['eventDate'] = this.eventDate;
    data['eventTime'] = this.eventTime;
    data['dalmiaInflCount'] = this.dalmiaInflCount;
    data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
    data['actualDalmiaInflCount'] = this.actualDalmiaInflCount;
    data['actualNonDalmiaInflCount'] = this.actualNonDalmiaInflCount;
    data['isEventStarted'] = this.isEventStarted;
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
