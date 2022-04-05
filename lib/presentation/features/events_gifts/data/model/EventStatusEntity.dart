class EventStatusEntities {
  int? eventStatusId;
  String? eventStatusText;

  EventStatusEntities({this.eventStatusId, this.eventStatusText});

  EventStatusEntities.fromJson(Map<String, dynamic> json) {
    eventStatusId = json['eventStatusId'];
    eventStatusText = json['eventStatusText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventStatusId'] = this.eventStatusId;
    data['eventStatusText'] = this.eventStatusText;
    return data;
  }
}
