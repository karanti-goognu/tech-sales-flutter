class InfluencerRequestModel {
  String baseCity;
  String createBy;
  String dealership;
  int districtId;
  String districtName;
  String email;
  String fatherName;
  String giftAddress;
  String giftAddressDistrict;
  String giftAddressPincode;
  String giftAddressState;
  String ilpRegFlag;
  String inflAddress;
  int inflCategoryId;
  String inflContactNumber;
  String inflDob;
  int inflEnrollmentSourceId;
  String inflJoiningDate;
  String inflName;
  String inflQualification;
  int inflTypeId;
  String isActive;
  String loyaltyLinkage;
  int monthlyPotentialVolumeMT;
  String pinCode;
  int siteAssignedCount;
  int stateId;
  String stateName;
  String taluka;

  InfluencerRequestModel(
      {this.baseCity,
        this.createBy,
        this.dealership,
        this.districtId,
        this.districtName,
        this.email,
        this.fatherName,
        this.giftAddress,
        this.giftAddressDistrict,
        this.giftAddressPincode,
        this.giftAddressState,
        this.ilpRegFlag,
        this.inflAddress,
        this.inflCategoryId,
        this.inflContactNumber,
        this.inflDob,
        this.inflEnrollmentSourceId,
        this.inflJoiningDate,
        this.inflName,
        this.inflQualification,
        this.inflTypeId,
        this.isActive,
        this.loyaltyLinkage,
        this.monthlyPotentialVolumeMT,
        this.pinCode,
        this.siteAssignedCount,
        this.stateId,
        this.stateName,
        this.taluka});

  InfluencerRequestModel.fromJson(Map<String, dynamic> json) {
    baseCity = json['baseCity'];
    createBy = json['createBy'];
    dealership = json['dealership'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    email = json['email'];
    fatherName = json['fatherName'];
    giftAddress = json['giftAddress'];
    giftAddressDistrict = json['giftAddressDistrict'];
    giftAddressPincode = json['giftAddressPincode'];
    giftAddressState = json['giftAddressState'];
    ilpRegFlag = json['ilpRegFlag'];
    inflAddress = json['inflAddress'];
    inflCategoryId = json['inflCategoryId'];
    inflContactNumber = json['inflContactNumber'];
    inflDob = json['inflDob'];
    inflEnrollmentSourceId = json['inflEnrollmentSourceId'];
    inflJoiningDate = json['inflJoiningDate'];
    inflName = json['inflName'];
    inflQualification = json['inflQualification'];
    inflTypeId = json['inflTypeId'];
    isActive = json['isActive'];
    loyaltyLinkage = json['loyaltyLinkage'];
    monthlyPotentialVolumeMT = json['monthlyPotentialVolumeMT'];
    pinCode = json['pinCode'];
    siteAssignedCount = json['siteAssignedCount'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    taluka = json['taluka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseCity'] = this.baseCity;
    data['createBy'] = this.createBy;
    data['dealership'] = this.dealership;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    data['email'] = this.email;
    data['fatherName'] = this.fatherName;
    data['giftAddress'] = this.giftAddress;
    data['giftAddressDistrict'] = this.giftAddressDistrict;
    data['giftAddressPincode'] = this.giftAddressPincode;
    data['giftAddressState'] = this.giftAddressState;
    data['ilpRegFlag'] = this.ilpRegFlag;
    data['inflAddress'] = this.inflAddress;
    data['inflCategoryId'] = this.inflCategoryId;
    data['inflContactNumber'] = this.inflContactNumber;
    data['inflDob'] = this.inflDob;
    data['inflEnrollmentSourceId'] = this.inflEnrollmentSourceId;
    data['inflJoiningDate'] = this.inflJoiningDate;
    data['inflName'] = this.inflName;
    data['inflQualification'] = this.inflQualification;
    data['inflTypeId'] = this.inflTypeId;
    data['isActive'] = this.isActive;
    data['loyaltyLinkage'] = this.loyaltyLinkage;
    data['monthlyPotentialVolumeMT'] = this.monthlyPotentialVolumeMT;
    data['pinCode'] = this.pinCode;
    data['siteAssignedCount'] = this.siteAssignedCount;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['taluka'] = this.taluka;
    return data;
  }
}

