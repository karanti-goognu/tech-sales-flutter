class RequestorDetailsModel {
  List<SrComplaintRequesterList>? srComplaintRequesterList;
  String? respCode;
  String? respMsg;

  RequestorDetailsModel(
      {this.srComplaintRequesterList, this.respCode, this.respMsg});

  RequestorDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['srComplaintRequesterList'] != null) {
      srComplaintRequesterList = new List<SrComplaintRequesterList>.empty(growable: true);
      json['srComplaintRequesterList'].forEach((v) {
        srComplaintRequesterList!.add(new SrComplaintRequesterList.fromJson(v));
      });
    }
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.srComplaintRequesterList != null) {
      data['srComplaintRequesterList'] =
          this.srComplaintRequesterList!.map((v) => v.toJson()).toList();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class SrComplaintRequesterList {
  String? requesterCode;
  String? requesterName;

  SrComplaintRequesterList({this.requesterCode, this.requesterName});

  SrComplaintRequesterList.fromJson(Map<String, dynamic> json) {
    requesterCode = json['requesterCode'];
    requesterName = json['requesterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requesterCode'] = this.requesterCode;
    data['requesterName'] = this.requesterName;
    return data;
  }
}
