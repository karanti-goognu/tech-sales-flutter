class StartEventModel {
  int eventID;
  String eventStartOn;
  double eventStartUserLat;
  double eventStartUserLong;
  String isEventStarted;
  String referenceID;

  StartEventModel(
      {this.eventID,
        this.eventStartOn,
        this.eventStartUserLat,
        this.eventStartUserLong,
        this.isEventStarted,
        this.referenceID});

  StartEventModel.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    eventStartOn = json['eventStartOn'];
    eventStartUserLat = json['eventStartUserLat'];
    eventStartUserLong = json['eventStartUserLong'];
    isEventStarted = json['isEventStarted'];
    referenceID = json['referenceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventID;
    data['eventStartOn'] = this.eventStartOn;
    data['eventStartUserLat'] = this.eventStartUserLat;
    data['eventStartUserLong'] = this.eventStartUserLong;
    data['isEventStarted'] = this.isEventStarted;
    data['referenceID'] = this.referenceID;
    return data;
  }
}