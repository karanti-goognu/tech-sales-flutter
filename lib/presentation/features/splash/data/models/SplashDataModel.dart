class SplashDataModel {
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadStageEntity> leadStageEntity;
  Null userSecurityKey;
  Null respCode;
  Null respMsg;
  EmployeeDetails employeeDetails;
  List<UserMenu> userMenu;
  JourneyDetails journeyDetails;

  SplashDataModel(
      {this.leadStatusEntity,
        this.leadStageEntity,
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
    data['user-security-key'] = this.userSecurityKey;
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
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

class EmployeeDetails {
  String referenceId;
  String mobileNumber;
  String employeeFirstName;
  String employeeName;

  EmployeeDetails(
      {this.referenceId,
        this.mobileNumber,
        this.employeeFirstName,
        this.employeeName});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference-id'];
    mobileNumber = json['mobile-number'];
    employeeFirstName = json['employee-first-name'];
    employeeName = json['employee-name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference-id'] = this.referenceId;
    data['mobile-number'] = this.mobileNumber;
    data['employee-first-name'] = this.employeeFirstName;
    data['employee-name'] = this.employeeName;
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

class JourneyDetails {
  Null journeyDate;
  Null journeyStartTime;
  Null journeyStartLat;
  Null journeyStartLong;
  Null journeyEndTime;
  Null journeyEndLat;
  Null journeyEndLong;
  Null employeeId;

  JourneyDetails(
      {this.journeyDate,
        this.journeyStartTime,
        this.journeyStartLat,
        this.journeyStartLong,
        this.journeyEndTime,
        this.journeyEndLat,
        this.journeyEndLong,
        this.employeeId});

  JourneyDetails.fromJson(Map<String, dynamic> json) {
    journeyDate = json['journey-date'];
    journeyStartTime = json['journey-start-time'];
    journeyStartLat = json['journey-start-lat'];
    journeyStartLong = json['journey-start-long'];
    journeyEndTime = json['journey-end-time'];
    journeyEndLat = json['journey-end-lat'];
    journeyEndLong = json['journey-end-long'];
    employeeId = json['employee-id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['journey-date'] = this.journeyDate;
    data['journey-start-time'] = this.journeyStartTime;
    data['journey-start-lat'] = this.journeyStartLat;
    data['journey-start-long'] = this.journeyStartLong;
    data['journey-end-time'] = this.journeyEndTime;
    data['journey-end-lat'] = this.journeyEndLat;
    data['journey-end-long'] = this.journeyEndLong;
    data['employee-id'] = this.employeeId;
    return data;
  }
}