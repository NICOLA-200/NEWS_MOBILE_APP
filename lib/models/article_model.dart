class ArticleModel {
  String? title;
  String? url;
  String? urlToImage;
  String? content;
  String? author;
  String? description;

  ArticleModel(
      {this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage});
}
