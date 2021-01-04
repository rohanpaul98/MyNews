class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urltoImage;
  String content;
  DateTime publishedAt;

  ArticleModel(
      {this.author,
      this.title,
      this.url,
      this.description,
      this.content,
      this.urltoImage,
      this.publishedAt});
}
