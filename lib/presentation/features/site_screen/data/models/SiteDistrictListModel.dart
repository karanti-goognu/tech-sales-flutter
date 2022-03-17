

class SiteDistrictListModel {
  String? respCode;
  String? respMsg;
  List<DistrictList>? districtList;

  SiteDistrictListModel({this.respCode, this.respMsg, this.districtList});

  SiteDistrictListModel.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json['districtList'] != null) {
      districtList = new List<DistrictList>.empty(growable: true);
      json['districtList'].forEach((v) {
        districtList!.add(new DistrictList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    if (this.districtList != null) {
      data['districtList'] = this.districtList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictList {
  String? name;

  DistrictList({this.name});

  DistrictList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

