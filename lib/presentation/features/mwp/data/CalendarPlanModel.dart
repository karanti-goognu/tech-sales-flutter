

import 'package:flutter_tech_sales/presentation/features/mwp/data/ListOfEventDetails.dart';

class CalendarPlanModel {
  String? respCode;
  String? respMsg;
  List<String>? listOfEventDates;
  List<ListOfEventDetails>? listOfEventDetails;

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
      listOfEventDetails = new List<ListOfEventDetails>.empty(growable: true);
      json['listOfEventDetails'].forEach((v) {
        listOfEventDetails!.add(new ListOfEventDetails.fromJson(v));
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
          this.listOfEventDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}