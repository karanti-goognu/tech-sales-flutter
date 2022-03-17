

class DashboardModel {
  DashBoardViewModal? dashBoardViewModal;
  String? respCode;
  String? respMsg;

  DashboardModel({this.dashBoardViewModal, this.respCode, this.respMsg});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    dashBoardViewModal = json['dashBoardViewModal'] != null
        ? new DashBoardViewModal.fromJson(json['dashBoardViewModal'])
        : null;
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashBoardViewModal != null) {
      data['dashBoardViewModal'] = this.dashBoardViewModal!.toJson();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class DashBoardViewModal {
  String? dspSlabsConverted;
  String? newInfl;
  String? sitesConverted;
  String? volumeConverted;

  DashBoardViewModal(
      {this.dspSlabsConverted,
      this.newInfl,
      this.sitesConverted,
      this.volumeConverted});

  DashBoardViewModal.fromJson(Map<String, dynamic> json) {
    dspSlabsConverted = json['dspSlabsConverted'];
    newInfl = json['newInfl'];
    sitesConverted = json['sitesConverted'];
    volumeConverted = json['volumeConverted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dspSlabsConverted'] = this.dspSlabsConverted;
    data['newInfl'] = this.newInfl;
    data['sitesConverted'] = this.sitesConverted;
    data['volumeConverted'] = this.volumeConverted;
    return data;
  }
}