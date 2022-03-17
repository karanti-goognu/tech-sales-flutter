

class CommentsDetail {
  CommentsDetail({
    this.createdBy,
    this.commentText,
    this.commentedAt,
    this.creatorName,
  });

  String? createdBy;
  String? commentText;
  String? commentedAt;
  String? creatorName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['commentText'] = this.commentText;
    // data['commentedAt'] = this.commentedAt.toString();
    data['creatorName'] = this.creatorName;

    return data;
  }

  CommentsDetail.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    commentText = json['commentText'];
    creatorName = json['creatorName'];
  }
}
