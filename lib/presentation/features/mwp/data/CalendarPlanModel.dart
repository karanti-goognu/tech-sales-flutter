class CalendarPlanModel {
  String respCode;
  String respMsg;
  List<String> listOfEventDates;
  List<ListOfEventDetails> listOfEventDetails;

  CalendarPlanModel(
      {this.respCode,
        this.respMsg,
        this.listOfEventDates,
        this.listOfEventDetails});

  CalendarPlanModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    listOfEventDates = json['listOfEventDates'].cast<String>();
    if (json['listOfEventDetails'] != null) {
      listOfEventDetails = new List<ListOfEventDetails>();
      json['listOfEventDetails'].forEach((v) {
        listOfEventDetails.add(new ListOfEventDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['listOfEventDates'] = this.listOfEventDates;
    if (this.listOfEventDetails != null) {
      data['listOfEventDetails'] =
          this.listOfEventDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListOfEventDetails {
  int id;
  String eventType;
  String displayMessage1;
  String displayMessage2;

  ListOfEventDetails(
      {this.id, this.eventType, this.displayMessage1, this.displayMessage2});

  ListOfEventDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventType = json['event_type'];
    displayMessage1 = json['display_message_1'];
    displayMessage2 = json['display_message_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_type'] = this.eventType;
    data['display_message_1'] = this.displayMessage1;
    data['display_message_2'] = this.displayMessage2;
    return data;
  }
}