
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
        this.venueAddress});

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
    return data;
  }
}




// class SaveEventFormModel {
//   String venueAddress;
//   String venue;
//   String referenceId;
//   String nonDalmiaInflCount;
//   int giftDistributionCount;
//   int expectedLeadsCount;
//   int eventTypeId;
//   String eventTime;
//   int eventStatusId;
//   double eventLocationLong;
//   double eventLocationLat;
//   String eventLocation;
//   String eventDate;
//   String eventComment;
//   int dalmiaInflCount;
//   List<EventDealerRequestsList> eventDealerRequestsList;
//
//   SaveEventFormModel(
//       {this.venueAddress,
//       this.venue,
//       this.referenceId,
//       this.nonDalmiaInflCount,
//       this.giftDistributionCount,
//       this.expectedLeadsCount,
//       this.eventTypeId,
//       this.eventTime,
//       this.eventStatusId,
//       this.eventLocationLong,
//       this.eventLocationLat,
//       this.eventLocation,
//       this.eventDate,
//       this.eventComment,
//       this.dalmiaInflCount,
//       this.eventDealerRequestsList});
//
//   SaveEventFormModel.fromJson(Map<String, dynamic> json) {
//     venueAddress = json['venueAddress'];
//     venue = json['venue'];
//     nonDalmiaInflCount = json['nonDalmiaInflCount'];
//     giftDistributionCount = json['giftDistributionCount'];
//     expectedLeadsCount = json['expectedLeadsCount'];
//     eventTypeId = json['eventTypeId'];
//     eventTime = json['eventTime'];
//     eventStatusId = json['eventStatusId'];
//     eventLocationLong = json['eventLocationLong'];
//     eventLocationLat = json['eventLocationLat'];
//     eventLocation = json['eventLocation'];
//     eventDate = json['eventDate'];
//     eventComment = json['eventComment'];
//     dalmiaInflCount = json['dalmiaInflCount'];
//
//     if (json['eventDealerRequestsList'] != null) {
//       eventDealerRequestsList = new List<EventDealerRequestsList>();
//       json['eventDealerRequestsList'].forEach((v) {
//         eventDealerRequestsList.add(new EventDealerRequestsList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['venueAddress'] = this.venueAddress;
//     data['venue'] = this.venue;
//     data['nonDalmiaInflCount'] = this.nonDalmiaInflCount;
//     data['giftDistributionCount'] = this.giftDistributionCount;
//     data['expectedLeadsCount'] = this.expectedLeadsCount;
//     data['eventTypeId'] = this.eventTypeId;
//     data['eventTime'] = this.eventTime;
//     data['eventStatusId'] = this.eventStatusId;
//     data['eventLocationLong'] = this.eventLocationLong;
//     data['eventLocationLat'] = this.eventLocationLat;
//     data['eventLocation'] = this.eventLocation;
//     data['eventDate'] = this.eventDate;
//     data['eventComment'] = this.eventComment;
//     data['dalmiaInflCount'] = this.dalmiaInflCount;
//     if (this.eventDealerRequestsList != null) {
//       data['eventDealerRequestsList'] =
//           this.eventDealerRequestsList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class EventDealerRequestsList {
//   String eventStage;
//   Null eventId;
//   String dealerId;
//   String createdBy;
//
//   EventDealerRequestsList(
//       {this.eventStage, this.eventId, this.dealerId, this.createdBy});
//   EventDealerRequestsList.fromJson(Map<String, dynamic> json) {
//     eventStage = json['eventStage'];
//     eventId = json['eventId'];
//     dealerId = json['dealerId'];
//     createdBy = json['createdBy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['eventStage'] = this.eventStage;
//     data['eventId'] = this.eventId;
//     data['dealerId'] = this.dealerId;
//     data['createdBy'] = this.createdBy;
//     return data;
//   }
//
// }
