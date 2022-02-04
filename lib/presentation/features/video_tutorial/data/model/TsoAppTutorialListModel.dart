class TsoAppTutorialListModel{
  int totalCount;
  List<TsoAppTutorial> tsoAppTutorial;
  String respCode;
  String respMsg;

  TsoAppTutorialListModel({
      this.totalCount, this.tsoAppTutorial, this.respCode, this.respMsg});

  TsoAppTutorialListModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total-count'];
    if (json['tsoAppTutorial'] != null) {
      tsoAppTutorial = new List<TsoAppTutorial>.empty(growable: true);
      json['tsoAppTutorial'].forEach((v) {
        tsoAppTutorial.add(new TsoAppTutorial.fromJson(v));
      });
    }
    respCode = json['resp-code'];
    respMsg = json['resp-msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total-count'] = this.totalCount;
    if (this.tsoAppTutorial != null) {
      data['tsoAppTutorial'] =
          this.tsoAppTutorial.map((v) => v.toJson()).toList();
    }
    data['resp-code'] = this.respCode;
    data['resp-msg'] = this.respMsg;
    return data;
  }
}

class TsoAppTutorial{
int id;
String category;
String type;
String description;
String url;
String thumbnailUrl;
int createdOn;
String createdBy;

TsoAppTutorial({this.id, this.category, this.type, this.description,
      this.url, this.thumbnailUrl, this.createdOn, this.createdBy});

TsoAppTutorial.fromJson(Map<String, dynamic> json){
  id = json['id'];
  category= json['category'];
  type = json['type'];
  description = json['description'];
  url = json['url'];
  thumbnailUrl = json['thumbnailUrl'];
  createdOn = json['createdOn'];
  createdBy = json['createdBy'];

}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['category'] = this.category;
  data['type'] = this.type;
  data['description'] = this.description;
  data['url'] = this.url;
  data['thumbnailUrl'] = this.thumbnailUrl;
  data['createdOn'] = this.createdOn;
  data['createdBy'] = this.createdBy;
  return data;
}
}