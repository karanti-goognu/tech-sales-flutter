class CommentsDetail {
  CommentsDetail({
    this.commentedBy,
    this.comment,
    this.commentedAt,
  });

  String commentedBy;
  String comment;
  DateTime commentedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.commentedBy;
    data['commentText'] = this.comment;
   // data['commentedAt'] = this.commentedAt.toString();

    return data;
  }
}