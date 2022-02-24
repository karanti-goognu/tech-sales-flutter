class ReportSharingModel {
  String? shareWith;

  ReportSharingModel({this.shareWith});

  ReportSharingModel.fromJson(Map<String, dynamic> json) {
    shareWith = json['shareWith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shareWith'] = this.shareWith;
    return data;
  }
}