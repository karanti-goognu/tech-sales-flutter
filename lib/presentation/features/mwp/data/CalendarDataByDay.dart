

import 'package:flutter_tech_sales/presentation/features/mwp/data/ListOfEventDetails.dart';

class CalendarDataByDay {
  String? respCode;
  String? respMsg;
  List<ListOfEventDetails>? listOfEventDetails;

  CalendarDataByDay({this.respCode, this.respMsg, this.listOfEventDetails});

  CalendarDataByDay.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];

    if (!json.containsKey('listOfEventDetails'))
      listOfEventDetails = new List<ListOfEventDetails>.empty(growable: true);

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
    if (this.listOfEventDetails != null) {
      data['listOfEventDetails'] =
          this.listOfEventDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}