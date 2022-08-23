import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';

class SiteFloorResponse {
  String? respCode;
  String? respMsg;
  late List<SiteFloorsEntity> sitesEntity;

  SiteFloorResponse({this.respCode, this.respMsg, required this.sitesEntity});

  SiteFloorResponse.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    respMsg = json['respMsg'];
    if (json.containsKey('sitesEntity'))
      sitesEntity = new List<SiteFloorsEntity>.empty(growable: true);
    json['sitesEntity'].forEach((v) {
      sitesEntity.add(new SiteFloorsEntity.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    data['sitesEntity'] = this.sitesEntity.map((v) => v.toJson()).toList();
    return data;
  }
}
