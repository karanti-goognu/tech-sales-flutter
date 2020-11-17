import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:http/http.dart';

import 'CommentDetailModel.dart';

class SaveLeadRequestModel {
  SaveLeadRequestModel({
    this.leadSegmane,
    this.siteSubTypeId,
    this.assignedTo,
    this.leadStatusId,
    this.leadStage,
    this.contactName,
    this.contactNumber,
    this.geotagType,
    this.leadLatitude,
    this.leadLongitude,
    this.leadAddress,
    this.leadPincode,
    this.leadStateName,
    this.leadDistrictName,
    this.leadTalukName,
    this.leadSalesPotentialMt,
    this.leadReraNumber,
    this.assignDate,
    this.isStatus,
    this.photos,
    this.comments,
    this.influencerList
  });


  String leadSegmane;
  String siteSubTypeId;
  String assignedTo;
  String leadStatusId;
  String leadStage;
  String contactName;
  String contactNumber;
  String geotagType;
  String  leadLatitude;
  String leadLongitude;
  String leadAddress;
  String leadPincode;
  String leadStateName;
  String  leadDistrictName;
  String  leadTalukName;
  String  leadSalesPotentialMt;
  String  leadReraNumber;
  String  assignDate;
  String isStatus;
  List<MultipartFile> photos;
  List<CommentsDetail> comments;
  List <InfluencerDetail> influencerList;









  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['leadSegmane']=this.leadSegmane;
    data['siteSubTypeId']=this.siteSubTypeId;
    data['assignedTo']=this.assignedTo;
    data['leadStatusId']=this.leadStatusId;
    data['leadStage']=this.leadStage;
    data['contactName']=this.contactName;
    data['contactNumber']=this.contactNumber;
    data['geotagType']=this.geotagType;
    data['leadLatitude']=this.leadLatitude;
    data['leadLongitude']=this.leadLongitude;
    data['leadAddress']=this.leadAddress;
    data['leadPincode']=this.leadPincode;
    data['leadStateName']=this.leadStateName;
    data['leadDistrictName']=this.leadDistrictName;
    data['leadTalukName']=this.leadTalukName;
    data['leadSalesPotentialMt']=this.leadSalesPotentialMt;
    data['leadReraNumber']=this.leadReraNumber;
    data['assignDate']=this.assignDate;
    data['isStatus']=this.isStatus;
    data['photos']=jsonEncode(this.photos);
    data['comments']=this.comments.map((e) => e.toJson()).toList();
    data['influencerList']=this.influencerList.map((e) => e.toJson()).toList();

    return data;
  }

}