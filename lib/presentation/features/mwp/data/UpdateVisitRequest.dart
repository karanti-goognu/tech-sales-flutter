import 'package:flutter_tech_sales/presentation/features/mwp/data/MwpVisitModel.dart';

class UpdateVisitRequest {
  MwpVisitModelUpdate mwpVisitModel;

  UpdateVisitRequest({this.mwpVisitModel});

  UpdateVisitRequest.fromJson(Map<String, dynamic> json) {
    mwpVisitModel = json['mwpVisitModel'] != null
        ? new MwpVisitModelUpdate.fromJson(json['mwpVisitModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mwpVisitModel != null) {
      data['mwpVisitModel'] = this.mwpVisitModel.toJson();
    }
    return data;
  }
}