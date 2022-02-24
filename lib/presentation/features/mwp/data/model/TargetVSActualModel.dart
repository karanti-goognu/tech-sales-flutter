class TargetVsActualModel {
  String? respMsg;
  int? siteConversionCountTarget;
  int? siteVisitsCountTarget;
  int? counterMeetCountTarget;
  int? siteConversionCountActual;
  int? siteVisitsCountActual;
  int? counterMeetCountActual;

  TargetVsActualModel(
      {this.respMsg,
      this.siteConversionCountTarget,
      this.siteVisitsCountTarget,
      this.counterMeetCountTarget,
      this.siteConversionCountActual,
      this.siteVisitsCountActual,
      this.counterMeetCountActual});

  TargetVsActualModel.fromJson(Map<String, dynamic> json) {
    respMsg = json['resp-msg'];
    siteConversionCountTarget = json['site_conversion_count_target'];
    siteVisitsCountTarget = json['site_visits_count_target'];
    counterMeetCountTarget = json['counter_meet_count_target'];
    siteConversionCountActual = json['site_conversion_count_actual'];
    siteVisitsCountActual = json['site_visits_count_actual'];
    counterMeetCountActual = json['counter_meet_count_actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp-msg'] = this.respMsg;
    data['site_conversion_count_target'] = this.siteConversionCountTarget;
    data['site_visits_count_target'] = this.siteVisitsCountTarget;
    data['counter_meet_count_target'] = this.counterMeetCountTarget;
    data['site_conversion_count_actual'] = this.siteConversionCountActual;
    data['site_visits_count_actual'] = this.siteVisitsCountActual;
    data['counter_meet_count_actual'] = this.counterMeetCountActual;
    return data;
  }
}
