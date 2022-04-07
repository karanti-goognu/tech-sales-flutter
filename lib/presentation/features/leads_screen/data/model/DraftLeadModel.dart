import 'dart:convert';
import 'package:http/http.dart';

import 'CommentDetailModel.dart';

class SaveLeadRequestDraftModel {
  SaveLeadRequestDraftModel(
      {
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
        this.leadSourceUser,
        this.leadSourcePlatform,
        this.isIhbCommercial,
      });

  String? siteSubTypeId;
  String? assignedTo;
  String? leadStatusId;
  String? leadStage;
  String? contactName;
  String? contactNumber;
  String? geotagType;
  String? leadLatitude;
  String? leadLongitude;
  String? leadAddress;
  String? leadPincode;
  String? leadStateName;
  String? leadDistrictName;
  String? leadTalukName;
  String? leadSalesPotentialMt;
  String? leadReraNumber;
  String? assignDate;
  String? isStatus;
  String? leadBags;
  List<MultipartFile>? photos;
  List<CommentsDetail>? comments;
  List<InfluencerDetailDraft>? influencerList;
  List<ListLeadImageDraft>? listLeadImage;
  String? leadSource;
  String? leadSourceUser;
  String? leadSourcePlatform;
  String? isIhbCommercial;

  SaveLeadRequestDraftModel.fromJson(Map<String, dynamic> json) {
    siteSubTypeId = json['siteSubTypeId'];
    assignedTo = json['assignedTo'];
    leadStatusId = json['leadStatusId'];
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
    leadSourcePlatform = json['leadSourcePlatform'];
    isIhbCommercial = json['isIhbCommercial'];
    // photos = json['photos'];
    if (json['comments'] != null) {
      comments = new List<CommentsDetail>.empty(growable: true);
      json['comments'].forEach((v) {
        comments!.add(new CommentsDetail.fromJson(v));
      });
    }
    if (json['influencerList'] != null) {
      influencerList = new List<InfluencerDetailDraft>.empty(growable: true);
      json['influencerList'].forEach((v) {
        influencerList!.add(new InfluencerDetailDraft.fromJson(v));
      });
    }
    if (json['listLeadImage'] != null) {
      listLeadImage = new List<ListLeadImageDraft>.empty(growable: true);
      json['listLeadImage'].forEach((v) {
        listLeadImage!.add(new ListLeadImageDraft.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //data['leadSegmane']=this.leadSegmane;
    data['siteSubTypeId'] = this.siteSubTypeId;
    data['assignedTo'] = this.assignedTo;
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
    data['comments'] = this.comments!.map((e) => e.toJson()).toList();
    data['influencerList'] =
        this.influencerList!.map((e) => e.toJson()).toList();
    data['listLeadImage'] = this.listLeadImage!.map((e) => e.toJson()).toList();
    data['leadSource'] = this.leadSource;
    data['leadSourceUser'] = this.leadSourceUser;
    data['leadSourcePlatform'] = this.leadSourcePlatform;
    data['isIhbCommercial'] = this.isIhbCommercial;
    return data;
  }
}

class ListLeadImageDraft {
  String? photoPath;

  ListLeadImageDraft({this.photoPath});

  ListLeadImageDraft.fromJson(Map<String, dynamic> json) {
    photoPath = json['photoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoName'] = this.photoPath;
    return data;
  }
}

class InfluencerDetailDraft {
  InfluencerDetailDraft(
      {this.id,
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
      this.isPrimary});

  String? id;

  String? inflName;
  String? inflContact;
  String? inflTypeId;
  String? inflTypeValue;
  String? inflCatId;
  String? inflCatValue;
  String? ilpIntrested;
  String? createdOn;
  String? createdBy;
  bool? isExpanded;
  String? isPrimary;
  bool? isPrimarybool;

  InfluencerDetailDraft.fromJson(Map<String, dynamic> json) {
    this.id = json['inflId'].toString();
    this.inflName = json['inflName'].toString();
    this.inflContact = json['inflContact'].toString();
    this.inflTypeId = json['inflTypeId'].toString();
    this.inflCatId = json['inflCatId'].toString();
    this.inflCatValue = json['inflCatValue'].toString();
    this.inflTypeValue = json['inflTypeValue'].toString();
    this.ilpIntrested = json['ilpIntrested'].toString();
    this.createdOn = json['createdOn'].toString();
    this.isExpanded = false;
    this.isPrimarybool = json['isPrimary'].toString() == "Y" ? true : false;
    this.isPrimary = json['isPrimary'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['inflId'] = this.id;
    data['inflName'] = this.inflName;
    data['inflContact'] = this.inflContact;
    data['inflTypeId'] = this.inflTypeId;
    data['inflCatId'] = this.inflCatId;
    data['inflTypeValue'] = this.inflTypeValue;
    data['inflCatValue'] = this.inflCatValue;
    data['ilpIntrested'] = this.ilpIntrested;
    // data['createdOn'] = this.createdOn.toString();
    //data['createdBy'] = this.createdBy;
    data['isDelete'] = 'N';
    data['isPrimary'] = this.isPrimarybool! ? "Y" : "N";
    data['isPrimarybool'] = this.isPrimarybool;
    return data;
  }
}
