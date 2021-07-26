class StateDistrictListModel {
  String respCode;
  String respMsg;
  List<StateDistrictList> stateDistrictList;

  StateDistrictListModel({this.respCode, this.respMsg, this.stateDistrictList});

  StateDistrictListModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['stateDistrictList'] != null) {
      stateDistrictList = new List<StateDistrictList>();
      json['stateDistrictList'].forEach((v) {
        stateDistrictList.add(new StateDistrictList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.stateDistrictList != null) {
      data['stateDistrictList'] =
          this.stateDistrictList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateDistrictList {
  int districtId;
  String districtName;
  int stateId;
  String stateName;

  StateDistrictList(
      {this.districtId, this.districtName, this.stateId, this.stateName});

  StateDistrictList.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    districtName = json['district_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    return data;
  }
}

