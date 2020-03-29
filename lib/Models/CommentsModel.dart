class Comments {
  String comment;
  String commentBy;
  String dateTimeStamp;

  Comments({this.comment, this.commentBy, this.dateTimeStamp});

  Comments.fromMap(Map snapshot) :
        comment =  snapshot['comment'] ?? '',
        commentBy = snapshot['commentBy'] ?? '',
        dateTimeStamp = snapshot['dateTimeStamp'] ?? '';

  toJson() {
    return {
      "comment": comment,
      "commentBy": commentBy,
      "dateTimeStamp": dateTimeStamp,
    };
  }
  
}