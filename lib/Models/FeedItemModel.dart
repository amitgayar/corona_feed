
class FeedItem {

  String url;
  String title;
  String description;
  String postedBy;
  String datePosted;
  List commentsList;

  FeedItem({this.url, this.title, this.description,this.datePosted,this.commentsList});

  FeedItem.fromMap(Map map) :
        url = map['url'] ?? '',
        title = map['title'] ?? '',
        description = map['description'] ?? '',
        postedBy = map['postedBy'] ?? '',
        datePosted = map['datePosted'] ?? '',
        commentsList = map['commentsList'] ?? '';

  toJson() {
    return {
      "url": url,
      "title": title,
      "description": description,
      "postedBy":postedBy,
      "datePosted":datePosted,
      "commentsList":commentsList
    };
  }
}