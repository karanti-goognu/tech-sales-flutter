class EventListModels {
  late int eventId;
  String? eventDate;
  int? eventTypeId;
  int? eventStatusId;
  String? eventStatusText;
  String? eventVenue;
  String? actualEventVenue;
  int? eventInflCount;
  int? actualEventInflCount;
  int? expectedLeadsCount;
  String? dealerName;
  int? count;
  String? eventTypeText;

  EventListModels(
      {required this.eventId,
        this.eventDate,
        this.eventTypeId,
        this.eventStatusId,
        this.eventStatusText,
        this.eventVenue,
        this.actualEventVenue,
        this.eventInflCount,
        this.actualEventInflCount,
        this.expectedLeadsCount,
        this.dealerName,
        this.count,
        this.eventTypeText});

  EventListModels.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventDate = json['eventDate'];
    eventTypeId = json['eventTypeId'];
    eventStatusId = json['eventStatusId'];
    eventStatusText = json['eventStatusText'];
    eventVenue = json['eventVenue'];
    actualEventVenue = json['actualEventVenue'];
    eventInflCount = json['eventInflCount'];
    actualEventInflCount = json['actualEventInflCount'];
    expectedLeadsCount = json['expectedLeadsCount'];
    dealerName = json['dealerName'];
    count = json['count'];
    eventTypeText = json['eventTypeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventDate'] = this.eventDate;
    data['eventTypeId'] = this.eventTypeId;
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatusText'] = this.eventStatusText;
    data['eventVenue'] = this.eventVenue;
    data['actualEventVenue'] = this.actualEventVenue;
    data['eventInflCount'] = this.eventInflCount;
    data['actualEventInflCount'] = this.actualEventInflCount;
    data['expectedLeadsCount'] = this.expectedLeadsCount;
    data['dealerName'] = this.dealerName;
    data['count'] = this.count;
    data['eventTypeText'] = this.eventTypeText;
    return data;
  }
}