import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeEntitiesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerSourceListModel.dart';

class InfluencerDetailDataModel {
  Response? response;

  InfluencerDetailDataModel({this.response});

  InfluencerDetailDataModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? respCode;
  String? respMsg;
  InfluencerDetails? influencerDetails;
  List<InfluencerTypeEntitiesList>? influencerTypeEntitiesList;
  List<InfluencerCategoryEntitiesList>? influencerCategoryEntitiesList;
  List<InfluencerSourceList>? influencerSourceList;
  List<SiteBrandList>? siteBrandList;
  InfluencerModel? influencerModel;
  String? visitStatus;

  Response(
      {this.respCode,
      this.respMsg,
      this.influencerDetails,
      this.influencerTypeEntitiesList,
      this.influencerCategoryEntitiesList,
      this.influencerSourceList,
      this.siteBrandList,
      this.influencerModel,
      this.visitStatus});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    visitStatus = json['visitStatus'];

    if (!json.containsKey('influencerDetails')) influencerDetails = null;
    influencerDetails = json['influencerDetails'] != null
        ? new InfluencerDetails.fromJson(json['influencerDetails'])
        : null;

    if (!json.containsKey('influencerModel')) influencerModel = null;
    influencerModel = json['influencerModel'] != null
        ? new InfluencerModel.fromJson(json['influencerModel'])
        : null;

    if (!json.containsKey('influencerTypeEntitiesList'))
      influencerTypeEntitiesList =
          new List<InfluencerTypeEntitiesList>.empty(growable: true);

    if (json['influencerTypeEntitiesList'] != null) {
      influencerTypeEntitiesList =
          new List<InfluencerTypeEntitiesList>.empty(growable: true);
      json['influencerTypeEntitiesList'].forEach((v) {
        influencerTypeEntitiesList!
            .add(new InfluencerTypeEntitiesList.fromJson(v));
      });
    }

    if (!json.containsKey('influencerCategoryEntitiesList'))
      influencerCategoryEntitiesList =  new List<InfluencerCategoryEntitiesList>.empty(growable: true);

    if (json['influencerCategoryEntitiesList'] != null) {
      influencerCategoryEntitiesList =
          new List<InfluencerCategoryEntitiesList>.empty(growable: true);
      json['influencerCategoryEntitiesList'].forEach((v) {
        influencerCategoryEntitiesList!
            .add(new InfluencerCategoryEntitiesList.fromJson(v));
      });
    }

    if (!json.containsKey('influencerSourceList'))
      influencerSourceList =
          new List<InfluencerSourceList>.empty(growable: true);

    if (json['influencerSourceList'] != null) {
      influencerSourceList =
          new List<InfluencerSourceList>.empty(growable: true);
      json['influencerSourceList'].forEach((v) {
        influencerSourceList!.add(new InfluencerSourceList.fromJson(v));
      });
    }

    if (!json.containsKey('siteBrandList'))
      siteBrandList = new List<SiteBrandList>.empty(growable: true);

    if (json['siteBrandList'] != null) {
      siteBrandList = new List<SiteBrandList>.empty(growable: true);
      json['siteBrandList'].forEach((v) {
        siteBrandList!.add(new SiteBrandList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerDetails != null) {
      data['influencerDetails'] = this.influencerDetails!.toJson();
    }
    if (this.influencerTypeEntitiesList != null) {
      data['influencerTypeEntitiesList'] =
          this.influencerTypeEntitiesList!.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntitiesList != null) {
      data['influencerCategoryEntitiesList'] =
          this.influencerCategoryEntitiesList!.map((v) => v.toJson()).toList();
    }
    if (this.influencerSourceList != null) {
      data['influencerSourceList'] =
          this.influencerSourceList!.map((v) => v.toJson()).toList();
    }

    if (this.siteBrandList != null) {
      data['siteBrandList'] =
          this.siteBrandList!.map((v) => v.toJson()).toList();
    }

    if (this.influencerModel != null) {
      data['influencerModel'] = this.influencerModel!.toJson();
    }
    data['visitStatus'] = this.visitStatus;

    return data;
  }
}

class InfluencerDetails {
  int? id;
  String? inflContactNumber;
  String? inflName;
  int? inflTypeId;
  String? isActive;
  int? monthlyPotentialBags;
  int? monthlyPotentialVolumeMT;
  String? pinCode;
  String? taluka;
  int? inflCategoryId;
  String? loyaltyLinkage;
  String? fatherName;
  String? dealership;
  String? createBy;
  String? inflAddress;
  String? inflJoiningDate;
  String? inflDob;
  int? siteAssignedCount;
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  String? inflQualification;
  String? giftAddress;
  String? giftAddressPincode;
  String? giftAddressDistrict;
  String? giftAddressState;
  int? inflEnrollmentSourceId;
  String? baseCity;
  String? email;
  String? ilpregFlag;
  String? designation;
  String? departmentName;
  int? preferredBrandId;
  String? dateOfMarriageAnniversary;
  String? firmName;
  String? primaryCounterName;
  int? totalSites;
  int? dalmiaSites;
  int? totalBags;
  int? dalmiaBags;
  String? nextVisitDate;

  InfluencerDetails(
      {this.id,
      this.inflContactNumber,
      this.inflName,
      this.inflTypeId,
      this.isActive,
      this.monthlyPotentialBags,
      this.monthlyPotentialVolumeMT,
      this.pinCode,
      this.taluka,
      this.inflCategoryId,
      this.loyaltyLinkage,
      this.fatherName,
      this.dealership,
      this.createBy,
      this.inflAddress,
      this.inflJoiningDate,
      this.inflDob,
      this.siteAssignedCount,
      this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.inflQualification,
      this.giftAddress,
      this.giftAddressPincode,
      this.giftAddressDistrict,
      this.giftAddressState,
      this.inflEnrollmentSourceId,
      this.baseCity,
      this.email,
      this.ilpregFlag,
      this.designation,
      this.departmentName,
      this.preferredBrandId,
      this.dateOfMarriageAnniversary,
      this.firmName,
      this.primaryCounterName,
      this.dalmiaBags,
      this.totalBags,
      this.dalmiaSites,
      this.totalSites,
      this.nextVisitDate});

  InfluencerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inflContactNumber = json['inflContactNumber'];
    inflName = json['inflName'];
    inflTypeId = json['inflTypeId'];
    isActive = json['isActive'];
    monthlyPotentialBags = json['monthlyPotentialBags'];
    monthlyPotentialVolumeMT = json['monthlyPotentialVolumeMT'];
    pinCode = json['pinCode'];
    taluka = json['taluka'];
    inflCategoryId = json['inflCategoryId'];
    loyaltyLinkage = json['loyaltyLinkage'];
    fatherName = json['fatherName'];
    dealership = json['dealership'];
    createBy = json['createBy'];
    inflAddress = json['inflAddress'];
    inflJoiningDate = json['inflJoiningDate'];
    inflDob = json['inflDob'];
    siteAssignedCount = json['siteAssignedCount'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    inflQualification = json['inflQualification'];
    giftAddress = json['giftAddress'];
    giftAddressPincode = json['giftAddressPincode'];
    giftAddressDistrict = json['giftAddressDistrict'];
    giftAddressState = json['giftAddressState'];
    inflEnrollmentSourceId = json['inflEnrollmentSourceId'];
    baseCity = json['baseCity'];
    email = json['email'];
    ilpregFlag = json['ilpregFlag'];
    designation = json['designation'];
    departmentName = json['departmentName'];
    preferredBrandId = json['preferredBrandId'];
    dateOfMarriageAnniversary = json['dateOfMarriageAnniversary'];
    firmName = json['firmName'];
    primaryCounterName = json['primaryCounterName'];
    dalmiaBags = json['dalmiaBags'];
    totalBags = json['totalBags'];
    dalmiaSites = json['dalmiaSites'];
    totalSites = json['totalSites'];
    nextVisitDate = json['nextVisitDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inflContactNumber'] = this.inflContactNumber;
    data['inflName'] = this.inflName;
    data['inflTypeId'] = this.inflTypeId;
    data['isActive'] = this.isActive;
    data['monthlyPotentialBags'] = this.monthlyPotentialBags;
    data['monthlyPotentialVolumeMT'] = this.monthlyPotentialVolumeMT;
    data['pinCode'] = this.pinCode;
    data['taluka'] = this.taluka;
    data['inflCategoryId'] = this.inflCategoryId;
    data['loyaltyLinkage'] = this.loyaltyLinkage;
    data['fatherName'] = this.fatherName;
    data['dealership'] = this.dealership;
    data['createBy'] = this.createBy;
    data['inflAddress'] = this.inflAddress;
    data['inflJoiningDate'] = this.inflJoiningDate;
    data['inflDob'] = this.inflDob;
    data['siteAssignedCount'] = this.siteAssignedCount;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    data['inflQualification'] = this.inflQualification;
    data['giftAddress'] = this.giftAddress;
    data['giftAddressPincode'] = this.giftAddressPincode;
    data['giftAddressDistrict'] = this.giftAddressDistrict;
    data['giftAddressState'] = this.giftAddressState;
    data['inflEnrollmentSourceId'] = this.inflEnrollmentSourceId;
    data['baseCity'] = this.baseCity;
    data['email'] = this.email;
    data['ilpregFlag'] = this.ilpregFlag;
    data['designation'] = this.designation;
    data['departmentName'] = this.departmentName;
    data['preferredBrandId'] = this.preferredBrandId;
    data['dateOfMarriageAnniversary'] = this.dateOfMarriageAnniversary;
    data['firmName'] = this.firmName;
    data['primaryCounterName'] = this.primaryCounterName;
    data['dalmiaBags'] = dalmiaBags;
    data['totalBags'] = totalBags;
    data['dalmiaSites'] = dalmiaSites;
    data['totalSites'] = totalSites;
    data['nextVisitDate'] = nextVisitDate;
    return data;
  }
}

class InfluencerCategoryEntitiesList {
  int? inflCatId;
  String? inflCatDesc;

  InfluencerCategoryEntitiesList({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntitiesList.fromJson(Map<String, dynamic> json) {
    inflCatId = json['inflCatId'];
    inflCatDesc = json['inflCatDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflCatId'] = this.inflCatId;
    data['inflCatDesc'] = this.inflCatDesc;
    return data;
  }
}

class SiteBrandList {
  int? id;
  String? brandName;
  String? productName;
  String? isPrimary;

  SiteBrandList({this.id, this.brandName, this.productName, this.isPrimary});

  SiteBrandList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    productName = json['productName'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    data['productName'] = this.productName;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class InfluencerModel {
  String? ilpMember;
  int? sitesCount;
  int? monthlyPotential;
  int? monthlyLifting;
  String? primaryCounterName;
  String? ilpRegFlag;
  int? inflId;
  String? inflName;
  String? inflContact;
  int? inflTypeId;
  String? influencerTypeText;
  int? inflCatId;
  String? influencerCategoryText;

  InfluencerModel(
      {required this.ilpMember,
      required this.sitesCount,
      required this.monthlyPotential,
      required this.monthlyLifting,
      required this.primaryCounterName,
      required this.ilpRegFlag,
      required this.inflId,
      required this.inflName,
      required this.inflContact,
      required this.inflTypeId,
      required this.influencerTypeText,
      required this.inflCatId,
      required this.influencerCategoryText});

  InfluencerModel.fromJson(Map<String, dynamic> json) {
    ilpMember = json['ilpMember'];
    sitesCount = json['sitesCount'];
    monthlyPotential = json['monthlyPotential'];
    monthlyLifting = json['monthlyLifting'];
    primaryCounterName = json['primaryCounterName'];
    ilpRegFlag = json['ilp_reg_flag'];
    inflId = json['infl_id'];
    inflName = json['infl_name'];
    inflContact = json['infl_contact'];
    inflTypeId = json['infl_type_id'];
    influencerTypeText = json['influencer_type_text'];
    inflCatId = json['infl_cat_id'];
    influencerCategoryText = json['influencer_category_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilpMember'] = this.ilpMember;
    data['sitesCount'] = this.sitesCount;
    data['monthlyPotential'] = this.monthlyPotential;
    data['monthlyLifting'] = this.monthlyLifting;
    data['primaryCounterName'] = this.primaryCounterName;
    data['ilp_reg_flag'] = this.ilpRegFlag;
    data['infl_id'] = this.inflId;
    data['infl_name'] = this.inflName;
    data['infl_contact'] = this.inflContact;
    data['infl_type_id'] = this.inflTypeId;
    data['influencer_type_text'] = this.influencerTypeText;
    data['infl_cat_id'] = this.inflCatId;
    data['influencer_category_text'] = this.influencerCategoryText;
    return data;
  }
}
