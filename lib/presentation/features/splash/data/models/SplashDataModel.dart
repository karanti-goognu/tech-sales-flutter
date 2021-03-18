import 'package:flutter_tech_sales/presentation/features/splash/data/models/JourneyDetailsModel.dart';

class SplashDataModel {
  List<SrComplainResolutionEntity> srComplainResolutionEntity;
  List<SrComplaintTypeEntity> srComplaintTypeEntity;
  List<SrctRequestEntity> srctRequestEntity;
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadStageEntity> leadStageEntity;
  List<SiteStageEntity> siteStageEntity;
  List<SiteStatusEntity> siteStatusEntity;
  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<SiteOpportuityStatus> siteOpportunityStatusRepository;
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<String> severity;
  Null userSecurityKey;
  Null respCode;
  Null respMsg;
  EmployeeDetails employeeDetails;
  List<ReportingTsoListModel> reportingTsoListModel;
  List<UserMenu> userMenu;
  JourneyDetails journeyDetails;

  SplashDataModel(
      {this.leadStatusEntity,
      this.leadStageEntity,
      this.siteStageEntity,
      this.siteStatusEntity,
      this.siteSubTypeEntity,
      this.siteOpportunityStatusRepository,
      this.siteProbabilityWinningEntity,
      this.srComplainResolutionEntity,
      this.srComplaintTypeEntity,
      this.srctRequestEntity,
      this.influencerCategoryEntity,
      this.severity,
      this.reportingTsoListModel,
      this.userSecurityKey,
      this.respCode,
      this.respMsg,
      this.employeeDetails,
      this.userMenu,
      this.journeyDetails});

  SplashDataModel.fromJson(Map<String, dynamic> json) {
    if (json['leadStatusEntity'] != null) {
      leadStatusEntity = new List<LeadStatusEntity>();
      json['leadStatusEntity'].forEach((v) {
        leadStatusEntity.add(new LeadStatusEntity.fromJson(v));
      });
    }
    if (json['leadStageEntity'] != null) {
      leadStageEntity = new List<LeadStageEntity>();
      json['leadStageEntity'].forEach((v) {
        leadStageEntity.add(new LeadStageEntity.fromJson(v));
      });
    }

    if (json['siteOpportunityStatusEntity'] != null) {
      siteOpportunityStatusRepository = new List<SiteOpportuityStatus>();
      json['siteOpportunityStatusEntity'].forEach((v) {
        siteOpportunityStatusRepository
            .add(new SiteOpportuityStatus.fromJson(v));
      });
    }

    if (json['siteProbabilityWinningEntity'] != null) {
      siteProbabilityWinningEntity = new List<SiteProbabilityWinningEntity>();
      json['siteProbabilityWinningEntity'].forEach((v) {
        siteProbabilityWinningEntity
            .add(new SiteProbabilityWinningEntity.fromJson(v));
      });
    }
    if (json['siteStageEntity'] != null) {
      siteStageEntity = new List<SiteStageEntity>();
      json['siteStageEntity'].forEach((v) {
        siteStageEntity.add(new SiteStageEntity.fromJson(v));
      });
    }
    if (json['siteStatusEntity'] != null) {
      siteStatusEntity = new List<SiteStatusEntity>();
      json['siteStatusEntity'].forEach((v) {
        siteStatusEntity.add(new SiteStatusEntity.fromJson(v));
      });
    }
    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>();
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }
    if (json['srComplainResolutionEntity'] != null) {
      srComplainResolutionEntity = new List<SrComplainResolutionEntity>();
      json['srComplainResolutionEntity'].forEach((v) {
        srComplainResolutionEntity
            .add(new SrComplainResolutionEntity.fromJson(v));
      });
    }
    if (json['srComplaintTypeEntity'] != null) {
      srComplaintTypeEntity = new List<SrComplaintTypeEntity>();
      json['srComplaintTypeEntity'].forEach((v) {
        srComplaintTypeEntity.add(new SrComplaintTypeEntity.fromJson(v));
      });
    }
    if (json['srctRequestEntity'] != null) {
      srctRequestEntity = new List<SrctRequestEntity>();
      json['srctRequestEntity'].forEach((v) {
        srctRequestEntity.add(new SrctRequestEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['reportingTsoListModel'] != null) {
      reportingTsoListModel = new List<ReportingTsoListModel>();
      json['reportingTsoListModel'].forEach((v) {
        reportingTsoListModel.add(new ReportingTsoListModel.fromJson(v));
      });
    }
    severity = json['severity'].cast<String>();
    userSecurityKey = json['user-security-key'];
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
    employeeDetails = json['employee-details'] != null
        ? new EmployeeDetails.fromJson(json['employee-details'])
        : null;
    if (json['user-menu'] != null) {
      userMenu = new List<UserMenu>();
      json['user-menu'].forEach((v) {
        userMenu.add(new UserMenu.fromJson(v));
      });
    }
    journeyDetails = json['journey-details'] != null
        ? new JourneyDetails.fromJson(json['journey-details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteStageEntity != null) {
      data['siteStageEntity'] =
          this.siteStageEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteStatusEntity != null) {
      data['siteStatusEntity'] =
          this.siteStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.siteSubTypeEntity != null) {
      data['siteSubTypeEntity'] =
          this.siteSubTypeEntity.map((v) => v.toJson()).toList();
    }

    if (this.siteOpportunityStatusRepository != null) {
      data['siteOpportunityStatusEntity'] =
          this.siteOpportunityStatusRepository.map((v) => v.toJson()).toList();
    }
    if (this.siteProbabilityWinningEntity != null) {
      data['siteProbabilityWinningEntity'] =
          this.siteProbabilityWinningEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.srComplainResolutionEntity != null) {
      data['srComplainResolutionEntity'] =
          this.srComplainResolutionEntity.map((v) => v.toJson()).toList();
    }
    if (this.srComplaintTypeEntity != null) {
      data['srComplaintTypeEntity'] =
          this.srComplaintTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.srctRequestEntity != null) {
      data['srctRequestEntity'] =
          this.srctRequestEntity.map((v) => v.toJson()).toList();
    }
    if (this.reportingTsoListModel != null) {
      data['reportingTsoListModel'] =
          this.reportingTsoListModel.map((v) => v.toJson()).toList();
    }
    data['user-security-key'] = this.userSecurityKey;
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    data['severity'] = this.severity;

    if (this.employeeDetails != null) {
      data['employee-details'] = this.employeeDetails.toJson();
    }
    if (this.userMenu != null) {
      data['user-menu'] = this.userMenu.map((v) => v.toJson()).toList();
    }
    if (this.journeyDetails != null) {
      data['journey-details'] = this.journeyDetails.toJson();
    }
    return data;
  }
}

class LeadStatusEntity {
  int id;
  String leadStatusDesc;

  LeadStatusEntity({this.id, this.leadStatusDesc});

  LeadStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStatusDesc = json['leadStatusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStatusDesc'] = this.leadStatusDesc;
    return data;
  }
}

class LeadStageEntity {
  int id;
  String leadStageDesc;

  LeadStageEntity({this.id, this.leadStageDesc});

  LeadStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadStageDesc = json['leadStageDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadStageDesc'] = this.leadStageDesc;
    return data;
  }
}

class SiteStageEntity {
  int id;
  String siteStageDesc;

  SiteStageEntity({this.id, this.siteStageDesc});

  SiteStageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteStageDesc = json['siteStageDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteStageDesc'] = this.siteStageDesc;
    return data;
  }
}

class SiteStatusEntity {
  int id;
  String siteStatusDesc;

  SiteStatusEntity({this.id, this.siteStatusDesc});

  SiteStatusEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteStatusDesc = json['siteStatusDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteStatusDesc'] = this.siteStatusDesc;
    return data;
  }
}

class SiteSubTypeEntity {
  int siteSubId;
  String siteSubTypeDesc;

  SiteSubTypeEntity({this.siteSubId, this.siteSubTypeDesc});

  SiteSubTypeEntity.fromJson(Map<String, dynamic> json) {
    siteSubId = json['siteSubId'];
    siteSubTypeDesc = json['siteSubTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteSubId'] = this.siteSubId;
    data['siteSubTypeDesc'] = this.siteSubTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntity {
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryEntity({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
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

class EmployeeDetails {
  String referenceId;
  String mobileNumber;
  String employeeFirstName;
  String employeeName;

  String employeeDesignation;
  String employeeReportingManagerId;
  int employeeUserRoleId;
  String employeeBaseLocation;
  String employeeWorkLocation;

  EmployeeDetails(
      {this.referenceId,
      this.mobileNumber,
      this.employeeFirstName,
      this.employeeName,
      this.employeeDesignation,
      this.employeeReportingManagerId,
      this.employeeUserRoleId,
      this.employeeBaseLocation,
      this.employeeWorkLocation});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference-id'];
    mobileNumber = json['mobile-number'];
    employeeFirstName = json['employee-first-name'];
    employeeName = json['employee-name'];
    employeeDesignation = json['employee-designation'];
    employeeReportingManagerId = json['employee-reporting_manager_id'];
    employeeUserRoleId = json['employee-user_role_id'];
    employeeBaseLocation = json['employee-base_location'];
    employeeWorkLocation = json['employee-work_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference-id'] = this.referenceId;
    data['mobile-number'] = this.mobileNumber;
    data['employee-first-name'] = this.employeeFirstName;
    data['employee-name'] = this.employeeName;
    data['employee-designation'] = this.employeeDesignation;
    data['employee-reporting_manager_id'] = this.employeeReportingManagerId;
    data['employee-user_role_id'] = this.employeeUserRoleId;
    data['employee-base_location'] = this.employeeBaseLocation;
    data['employee-work_location'] = this.employeeWorkLocation;
    return data;
  }
}

class UserMenu {
  int menuId;
  String menuText;

  UserMenu({this.menuId, this.menuText});

  UserMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['menu-id'];
    menuText = json['menu-text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu-id'] = this.menuId;
    data['menu-text'] = this.menuText;
    return data;
  }
}

class SiteOpportuityStatus {
  int id;
  String opportunityStatus;

  SiteOpportuityStatus({this.id, this.opportunityStatus});

  SiteOpportuityStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opportunityStatus = json['opportunityStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['opportunityStatus'] = this.opportunityStatus;
    return data;
  }
}

class SiteProbabilityWinningEntity {
  int id;
  String siteProbabilityStatus;

  SiteProbabilityWinningEntity({this.id, this.siteProbabilityStatus});

  SiteProbabilityWinningEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteProbabilityStatus = json['siteProbabilityStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteProbabilityStatus'] = this.siteProbabilityStatus;
    return data;
  }
}

class SrComplainResolutionEntity {
  int id;
  String resolutionText;

  SrComplainResolutionEntity({this.id, this.resolutionText});

  SrComplainResolutionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resolutionText = json['resolutionText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resolutionText'] = this.resolutionText;
    return data;
  }
}

class SrComplaintTypeEntity {
  int id;
  int requestId;
  String serviceRequestTypeText;
  String complaintSeverity;

  SrComplaintTypeEntity(
      {this.id,
      this.requestId,
      this.serviceRequestTypeText,
      this.complaintSeverity});

  SrComplaintTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    serviceRequestTypeText = json['serviceRequestTypeText'];
    complaintSeverity = json['complaintSeverity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['service_request_type_text'] = this.serviceRequestTypeText;
    data['complaint_severity'] = this.complaintSeverity;
    return data;
  }
}

class SrctRequestEntity {
  int id;
  String requestText;

  SrctRequestEntity({this.id, this.requestText});

  SrctRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestText = json['requestText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestText'] = this.requestText;
    return data;
  }
}

class ReportingTsoListModel {
  String tsoId;
  String tsoName;

  ReportingTsoListModel({this.tsoId, this.tsoName});

  ReportingTsoListModel.fromJson(Map<String, dynamic> json) {
    tsoId = json['tsoId'];
    tsoName = json['tsoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tsoId'] = this.tsoId;
    data['tsoName'] = this.tsoName;
    return data;
  }
}
