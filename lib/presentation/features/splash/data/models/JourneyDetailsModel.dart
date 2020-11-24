class JourneyDetails {
  String journeyDate;
  String journeyStartTime;
  String journeyStartLat;
  String journeyStartLong;
  String journeyEndTime;
  String journeyEndLat;
  String journeyEndLong;
  String employeeId;

  JourneyDetails(
      {this.journeyDate,
      this.journeyStartTime,
      this.journeyStartLat,
      this.journeyStartLong,
      this.journeyEndTime,
      this.journeyEndLat,
      this.journeyEndLong,
      this.employeeId});

  JourneyDetails.fromJson(Map<String, dynamic> json) {
    journeyDate = json['journey-date'];
    journeyStartTime = json['journey-start-time'];
    journeyStartLat = json['journey-start-lat'];
    journeyStartLong = json['journey-start-long'];
    journeyEndTime = json['journey-end-time'];
    journeyEndLat = json['journey-end-lat'];
    journeyEndLong = json['journey-end-long'];
    employeeId = json['employee-id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['journey-date'] = this.journeyDate;
    data['journey-start-time'] = this.journeyStartTime;
    data['journey-start-lat'] = this.journeyStartLat;
    data['journey-start-long'] = this.journeyStartLong;
    data['journey-end-time'] = this.journeyEndTime;
    data['journey-end-lat'] = this.journeyEndLat;
    data['journey-end-long'] = this.journeyEndLong;
    data['employee-id'] = this.employeeId;
    return data;
  }
}
