import 'package:flutter_tech_sales/presentation/features/splash/data/models/JourneyDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/LeadStatusModel.dart';

class ValidateOtpModel {
  String respCode;
  String respMsg;
  EmployeeDetails employeeDetails;
  List<UserMenu> userMenu;
  JourneyDetails journeyDetails;
  List<LeadStatusEntity> leadStatusEntity;
  List<LeadStageEntity> leadStageEntity;
  String userSecurityKey;

  ValidateOtpModel(
      {this.respCode,
      this.respMsg,
      this.employeeDetails,
      this.userMenu,
      this.journeyDetails,
      this.leadStatusEntity,
      this.leadStageEntity,
      this.userSecurityKey});

  ValidateOtpModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.leadStatusEntity != null) {
      data['leadStatusEntity'] =
          this.leadStatusEntity.map((v) => v.toJson()).toList();
    }
    if (this.leadStageEntity != null) {
      data['leadStageEntity'] =
          this.leadStageEntity.map((v) => v.toJson()).toList();
    }
    data['user-security-key'] = this.userSecurityKey;
    return data;
  }
}

class EmployeeDetails {
  String referenceId;
  String mobileNumber;
  String employeeName;
  String employeeFirstName;
  int userType;

  EmployeeDetails(
      {this.referenceId,
      this.mobileNumber,
      this.employeeName,
      this.employeeFirstName,
      this.userType});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference-id'];
    mobileNumber = json['mobile-number'];
    employeeName = json['employee-name'];
    employeeFirstName = json['employee-first-name'];
    userType = json['user-type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference-id'] = this.referenceId;
    data['mobile-number'] = this.mobileNumber;
    data['employee-name'] = this.employeeName;
    data['employee-first-name'] = this.employeeFirstName;
    data['user-type'] = this.userType;
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
