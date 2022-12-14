class InfluencerDetailDataModel {
  Response response;

  InfluencerDetailDataModel({this.response});

  InfluencerDetailDataModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  String respCode;
  String respMsg;
  InfluencerDetails influencerDetails;
  List<InfluencerTypeEntitiesList> influencerTypeEntitiesList;
  List<InfluencerCategoryEntitiesList> influencerCategoryEntitiesList;
  List<InfluencerSourceList> influencerSourceList;
  List<SiteBrandList> siteBrandList;

  Response(
      {this.respCode,
        this.respMsg,
        this.influencerDetails,
        this.influencerTypeEntitiesList,
        this.influencerCategoryEntitiesList,
        this.influencerSourceList,
        this.siteBrandList});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    influencerDetails = json['influencerDetails'] != null
        ? new InfluencerDetails.fromJson(json['influencerDetails'])
        : null;
    if (json['influencerTypeEntitiesList'] != null) {
      influencerTypeEntitiesList = new List<InfluencerTypeEntitiesList>.empty(growable: true);
      json['influencerTypeEntitiesList'].forEach((v) {
        influencerTypeEntitiesList
            .add(new InfluencerTypeEntitiesList.fromJson(v));
      });
    }
    if (json['influencerCategoryEntitiesList'] != null) {
      influencerCategoryEntitiesList =
      new List<InfluencerCategoryEntitiesList>.empty(growable: true);
      json['influencerCategoryEntitiesList'].forEach((v) {
        influencerCategoryEntitiesList
            .add(new InfluencerCategoryEntitiesList.fromJson(v));
      });
    }
    if (json['influencerSourceList'] != null) {
      influencerSourceList = new List<InfluencerSourceList>.empty(growable: true);
      json['influencerSourceList'].forEach((v) {
        influencerSourceList.add(new InfluencerSourceList.fromJson(v));
      });
    }

    if (json['siteBrandList'] != null) {
      siteBrandList = new List<SiteBrandList>.empty(growable: true);
      json['siteBrandList'].forEach((v) {
        siteBrandList.add(new SiteBrandList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.influencerDetails != null) {
      data['influencerDetails'] = this.influencerDetails.toJson();
    }
    if (this.influencerTypeEntitiesList != null) {
      data['influencerTypeEntitiesList'] =
          this.influencerTypeEntitiesList.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntitiesList != null) {
      data['influencerCategoryEntitiesList'] =
          this.influencerCategoryEntitiesList.map((v) => v.toJson()).toList();
    }
    if (this.influencerSourceList != null) {
      data['influencerSourceList'] =
          this.influencerSourceList.map((v) => v.toJson()).toList();
    }

    if (this.siteBrandList != null) {
      data['siteBrandList'] =
          this.siteBrandList.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class InfluencerDetails {
  int id;
  String inflContactNumber;
  String inflName;
  int inflTypeId;
  String isActive;
  int monthlyPotentialBags;
  int monthlyPotentialVolumeMT;
  String pinCode;
  String taluka;
  int inflCategoryId;
  String loyaltyLinkage;
  String fatherName;
  String dealership;
  String createBy;
  String inflAddress;
  String inflJoiningDate;
  String inflDob;
  int siteAssignedCount;
  int stateId;
  String stateName;
  int districtId;
  String districtName;
  String inflQualification;
  String giftAddress;
  String giftAddressPincode;
  String giftAddressDistrict;
  String giftAddressState;
  int inflEnrollmentSourceId;
  String baseCity;
  String email;
  String ilpregFlag;

  String designation;
  String departmentName;
  int preferredBrandId;
  String dateOfMarriageAnniversary;
  String firmName;
  String primaryCounterName;

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
        this.primaryCounterName});

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
    return data;
  }
}

class InfluencerTypeEntitiesList {
  int inflTypeId;
  String inflTypeDesc;
  String infRegFlag;

  InfluencerTypeEntitiesList(
      {this.inflTypeId, this.inflTypeDesc, this.infRegFlag});

  InfluencerTypeEntitiesList.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
    infRegFlag = json['infRegFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    data['infRegFlag'] = this.infRegFlag;
    return data;
  }
}

class InfluencerCategoryEntitiesList {
  int inflCatId;
  String inflCatDesc;

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

class InfluencerSourceList {
  int inflSourceId;
  String inflSourceText;

  InfluencerSourceList({this.inflSourceId, this.inflSourceText});

  InfluencerSourceList.fromJson(Map<String, dynamic> json) {
    inflSourceId = json['inflSourceId'];
    inflSourceText = json['inflSourceText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflSourceId'] = this.inflSourceId;
    data['inflSourceText'] = this.inflSourceText;
    return data;
  }
}

class SiteBrandList {
  int id;
  String brandName;
  String productName;
  String isPrimary;

  SiteBrandList({this.id, this.brandName,this.productName,this.isPrimary});

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

