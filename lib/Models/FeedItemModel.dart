
class FeedItem {

  String url;
  String title;
  String description;
  String postedBy;
  String datePosted;
  List commentsList;

  FeedItem({this.url, this.title, this.description,this.datePosted,this.commentsList});

  FeedItem.fromMap(Map snapshot) :
        url = snapshot['url'] ?? '',
        title = snapshot['title'] ?? '',
        description = snapshot['description'] ?? '',
        postedBy = snapshot['postedBy'] ?? '',
        datePosted = snapshot['datePosted'] ?? '',
        commentsList = snapshot['commentsList'] ?? '';

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