import 'package:flutter/cupertino.dart';

class InfluencerDetail {
  InfluencerDetail({
    this.id,
    this.inflName,
    this.inflContact,
    this.inflTypeId,
    this.inflCatId,
    this.ilpIntrested,
    this.createdOn,
    this.isExpanded,
    this.inflCatValue,
    this.inflTypeValue,
    this.createdBy,
    this.isPrimarybool,
    this.isPrimary,
    this.originalId,
  });

  var id = TextEditingController();
  var inflName = TextEditingController();
  var inflContact = TextEditingController();
  var inflTypeId = TextEditingController();
  var inflTypeValue = TextEditingController();
  var inflCatId = TextEditingController();
  var inflCatValue = TextEditingController();
  var ilpIntrested = TextEditingController();
  var createdOn = TextEditingController();
  String isPrimary;
  String createdBy;
  bool isExpanded;
  bool isPrimarybool;
  int originalId;

  InfluencerDetail.fromJson(Map<String, dynamic> json) {
    this.id.text = json['id'].toString();
    this.inflName.text = json['inflName'].toString();
    this.inflContact.text = json['inflContact'].toString();
    this.inflTypeId.text = json['inflTypeId'].toString();
    this.inflCatId.text = json['inflCatId'].toString();
    this.ilpIntrested.text = json['ilpIntrested'].toString();
    this.createdOn.text = json['createdOn'].toString();
    this.isExpanded = false;
    this.isPrimarybool = json['isPrimary'].toString() == "Y" ? true : false;
    this.isPrimary = json['isPrimary'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['inflId'] = int.parse(this.id.text);
    // data['inflName'] = this.inflName.text;
    // data['inflContact'] = this.inflContact.text;
    // data['inflTypeId'] = this.inflTypeId.text;
    // data['inflCatId'] = this.inflCatId.text;
    // data['ilpIntrested'] = this.ilpIntrested.text;
    // data['createdOn'] = this.createdOn.text.toString();
    data['createdBy'] = this.createdBy;
    data['isDelete'] = 'N';
    data['isPrimary'] = this.isPrimarybool ? "Y" : "N";
    return data;
  }
}
