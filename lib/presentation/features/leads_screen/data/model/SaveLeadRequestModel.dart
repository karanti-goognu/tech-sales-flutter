import 'dart:convert';

import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:http/http.dart';

import 'CommentDetailModel.dart';

class SaveLeadRequestModel {
  SaveLeadRequestModel(
      {
      //this.leadSegmane,
        this.eventId,
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
      this.influencerList,
      this.listLeadImage,
      this.leadBags,
      this.leadSource,
      this.leadSourceUser});

  // String leadSegmane;
  int eventId;
  String siteSubTypeId;
  String assignedTo;
  String leadStatusId;
  String leadStage;
  String contactName;
  String contactNumber;
  String geotagType;
  String leadLatitude;
  String leadLongitude;
  String leadAddress;
  String leadPincode;
  String leadStateName;
  String leadDistrictName;
  String leadTalukName;
  String leadSalesPotentialMt;
  String leadReraNumber;
  String assignDate;
  String isStatus;
  String leadBags;
  List<MultipartFile> photos;
  List<CommentsDetail> comments;
  List<InfluencerDetail> influencerList;
  List<ListLeadImage> listLeadImage;

  String leadSource;
  String leadSourceUser;

  SaveLeadRequestModel.fromJson(Map<String, dynamic> json) {
    siteSubTypeId = json['siteSubTypeId'];
    assignedTo = json['assignedTo'];
    leadStatusId = json['leadStatusId'];
    eventId = json['eventId'];
    leadStage = json['leadStage'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    geotagType = json['geotagType'];
    leadLatitude = json['leadLatitude'];
    leadLongitude = json['leadLongitude'];
    leadAddress = json['leadAddress'];
    leadPincode = json['leadPincode'];
    leadStateName = json['leadStateName'];
    leadDistrictName = json['leadDistrictName'];
    leadTalukName = json['leadTalukName'];
    leadSalesPotentialMt = json['leadSalesPotentialMt'];
    leadReraNumber = json['leadReraNumber'];
    assignDate = json['assignDate'];
    isStatus = json['isStatus'];
    leadBags = json['leadBags'];


    leadSource = json['leadSource'];
    leadSourceUser = json['leadSourceUser'];

    // photos = json['photos'];
    if (json['comments'] != null) {
      comments = new List<CommentsDetail>();
      json['comments'].forEach((v) {
        comments.add(new CommentsDetail.fromJson(v));
      });
    }
    if (json['influencerList'] != null) {
      influencerList = new List<InfluencerDetail>();
      json['influencerList'].forEach((v) {
        influencerList.add(new InfluencerDetail.fromJson(v));
      });
    }
    if (json['listLeadImage'] != null) {
      listLeadImage = new List<ListLeadImage>();
      json['listLeadImage'].forEach((v) {
        listLeadImage.add(new ListLeadImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //data['leadSegmane']=this.leadSegmane;
    data['siteSubTypeId'] = this.siteSubTypeId;
    data['assignedTo'] = this.assignedTo;
    data['eventId'] = this.eventId;
    data['leadStatusId'] = this.leadStatusId;
    data['leadStage'] = this.leadStage;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['geotagType'] = this.geotagType;
    data['leadLatitude'] = this.leadLatitude;
    data['leadLongitude'] = this.leadLongitude;
    data['leadAddress'] = this.leadAddress;
    data['leadPincode'] = this.leadPincode;
    data['leadStateName'] = this.leadStateName;
    data['leadDistrictName'] = this.leadDistrictName;
    data['leadTalukName'] = this.leadTalukName;
    data['leadSalesPotentialMt'] = this.leadSalesPotentialMt;
    data['leadReraNumber'] = this.leadReraNumber;
    data['assignDate'] = this.assignDate;
    data['isStatus'] = this.isStatus;
    data['photos'] = jsonEncode(this.photos);
    data['comments'] = this.comments.map((e) => e.toJson()).toList();
    data['influencerList'] =
        this.influencerList.map((e) => e.toJson()).toList();
    data['listLeadImage'] = this.listLeadImage.map((e) => e.toJson()).toList();

    data['leadSource'] = this.leadSource;
    data['leadSourceUser'] = this.leadSourceUser;

    return data;
  }
}

class ListLeadImage {
  String photoName;

  ListLeadImage({this.photoName});

  ListLeadImage.fromJson(Map<String, dynamic> json) {
    photoName = json['photoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoName'] = this.photoName;
    return data;
  }
}
