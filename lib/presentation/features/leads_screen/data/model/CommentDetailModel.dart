class CommentsDetail {
  CommentsDetail({
    this.commentedBy,
    this.commentText,
    this.commentedAt,
    this.creatorName,
  });

  String commentedBy;
  String commentText;
  DateTime commentedAt;
  String creatorName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.commentedBy;
    data['commentText'] = this.commentText;
   // data['commentedAt'] = this.commentedAt.toString();
    data['creatorName'] = this.creatorName;

    return data;
  }
}