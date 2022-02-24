class SiteAreaModel {
  SiteAreaDetailsModel? siteAreaDetailsModel;
  String? respCode;
  String? respMsg;

  SiteAreaModel({this.siteAreaDetailsModel, this.respCode, this.respMsg});

  SiteAreaModel.fromJson(Map<String, dynamic> json) {
    siteAreaDetailsModel = json['siteAreaDetailsModel'] != null
        ? new SiteAreaDetailsModel.fromJson(json['siteAreaDetailsModel'])
        : null;
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siteAreaDetailsModel != null) {
      data['siteAreaDetailsModel'] = this.siteAreaDetailsModel!.toJson();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class SiteAreaDetailsModel {
  String? siteState;
  String? siteDistrict;
  String? siteTaluk;
  String? sitePincode;

  SiteAreaDetailsModel(
      {this.siteState, this.siteDistrict, this.siteTaluk, this.sitePincode});

  SiteAreaDetailsModel.fromJson(Map<String, dynamic> json) {
    siteState = json['siteState'];
    siteDistrict = json['siteDistrict'];
    siteTaluk = json['siteTaluk'];
    sitePincode = json['sitePincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteState'] = this.siteState;
    data['siteDistrict'] = this.siteDistrict;
    data['siteTaluk'] = this.siteTaluk;
    data['sitePincode'] = this.sitePincode;
    return data;
  }
}