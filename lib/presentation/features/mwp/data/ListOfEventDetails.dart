class ListOfEventDetails {
  int? id;
  String? eventType;
  String? displayMessage1;
  String? displayMessage2;
  String? meetingType;

  ListOfEventDetails(
      {this.id, this.eventType, this.displayMessage1, this.displayMessage2});

  ListOfEventDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventType = json['event_type'];
    displayMessage1 = json['display_message_1'];
    displayMessage2 = json['display_message_2'];
    meetingType = json['meeting_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_type'] = this.eventType;
    data['display_message_1'] = this.displayMessage1;
    data['display_message_2'] = this.displayMessage2;
    data['meeting_type'] = this.meetingType;
    return data;
  }
}