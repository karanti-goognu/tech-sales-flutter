class StateDistrictListModel {
  Response? response;

  StateDistrictListModel({this.response});

  StateDistrictListModel.fromJson(Map<String, dynamic> json) {
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
  List<StateDistrictList>? stateDistrictList;

  Response({this.respCode, this.respMsg, this.stateDistrictList});

  Response.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['stateDistrictList'] != null) {
      stateDistrictList = new List<StateDistrictList>.empty(growable: true);
      json['stateDistrictList'].forEach((v) {
        stateDistrictList!.add(new StateDistrictList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.stateDistrictList != null) {
      data['stateDistrictList'] =
          this.stateDistrictList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateDistrictList {
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;

  StateDistrictList(
      {this.stateId, this.stateName, this.districtId, this.districtName});

  StateDistrictList.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    return data;
  }
}

