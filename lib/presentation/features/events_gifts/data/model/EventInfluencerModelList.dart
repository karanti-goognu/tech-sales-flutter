class EventInfluencerModelList {
  int? eventId;
  int? eventInflId;
  String? inflContact;
  int? inflId;
  String? inflName;
  int? inflTypeId;
  String? isActive;

  EventInfluencerModelList(
      {this.eventId,
        this.eventInflId,
        this.inflContact,
        this.inflId,
        this.inflName,
        this.inflTypeId,
        this.isActive});

  EventInfluencerModelList.fromJson(Map<String, dynamic> json) {
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
