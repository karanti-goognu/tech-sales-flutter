class ValidateOtpModel {
  String respCode;
  String respMsg;
  String userSecurityKey;
  EmployeeDetails employeeDetails;
  List<UserMenu> userMenu;
  JourneyDetails journeyDetails;

  ValidateOtpModel(
      {this.userSecurityKey,
      this.respCode,
      this.respMsg,
      this.employeeDetails,
      this.userMenu,
      this.journeyDetails});

  ValidateOtpModel.fromJson(Map<String, dynamic> json) {
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

class EmployeeDetails {
  String referenceId;
  String mobileNumber;
  String employeeName;
  String employeeFirstName;

  EmployeeDetails(
      {this.referenceId,
      this.mobileNumber,
      this.employeeName,
      this.employeeFirstName});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference-id'];
    mobileNumber = json['mobile-number'];
    employeeName = json['employee-name'];
    employeeFirstName = json['employee-first-name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference-id'] = this.referenceId;
    data['mobile-number'] = this.mobileNumber;
    data['employee-name'] = this.employeeName;
    data['employee-first-name'] = this.employeeFirstName;
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
  String journeyDate;
  String journeyStartTime;
  double journeyStartLat;
  double journeyStartLong;
  String journeyEndTime;
  double journeyEndLat;
  double journeyEndLong;
  String employeeId;

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
