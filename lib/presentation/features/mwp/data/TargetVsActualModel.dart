class TargetVsActualModel {
  String respCode;
  String respMsg;
  MwpPlanTargetVsActualModel mwpPlanTargetVsActualModel;

  TargetVsActualModel(
      {this.respCode, this.respMsg, this.mwpPlanTargetVsActualModel});

  TargetVsActualModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    mwpPlanTargetVsActualModel = json['mwpPlanTargetVsActualModel'] != null
        ? new MwpPlanTargetVsActualModel.fromJson(
            json['mwpPlanTargetVsActualModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.mwpPlanTargetVsActualModel != null) {
      data['mwpPlanTargetVsActualModel'] =
          this.mwpPlanTargetVsActualModel.toJson();
    }
    return data;
  }
}

class MwpPlanTargetVsActualModel {
  int siteConversionCountTarget;
  int siteVisitsCountTarget;
  int counterMeetCountTarget;
  int siteConversionCountActual;
  int siteVisitsCountActual;
  int counterMeetCountActual;

  MwpPlanTargetVsActualModel(
      {this.siteConversionCountTarget,
      this.siteVisitsCountTarget,
      this.counterMeetCountTarget,
      this.siteConversionCountActual,
      this.siteVisitsCountActual,
      this.counterMeetCountActual});

  MwpPlanTargetVsActualModel.fromJson(Map<String, dynamic> json) {
    siteConversionCountTarget = json['site_conversion_count_target'];
    siteVisitsCountTarget = json['site_visits_count_target'];
    counterMeetCountTarget = json['counter_meet_count_target'];
    siteConversionCountActual = json['site_conversion_count_actual'];
    siteVisitsCountActual = json['site_visits_count_actual'];
    counterMeetCountActual = json['counter_meet_count_actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site_conversion_count_target'] = this.siteConversionCountTarget;
    data['site_visits_count_target'] = this.siteVisitsCountTarget;
    data['counter_meet_count_target'] = this.counterMeetCountTarget;
    data['site_conversion_count_actual'] = this.siteConversionCountActual;
    data['site_visits_count_actual'] = this.siteVisitsCountActual;
    data['counter_meet_count_actual'] = this.counterMeetCountActual;
    return data;
  }
}
