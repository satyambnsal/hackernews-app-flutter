class Article {
  final int id;
  final String title;
  final String url;
  const Article({required this.id, required this.title, required this.url});
}

List<Article> articles = [
  Article(
      title: "My YC app: Dropbox - Throw away your USB drive 1",
      id: 8863,
      url: "http://www.getdropbox.com/u/2/screencast.html"),
  Article(
      title: "My YC app: Dropbox - Throw away your USB drive 2",
      id: 8864,
      url: "http://www.getdropbox.com/u/2/screencast.html"),
  Article(
      title: "My YC app: Dropbox - Throw away your USB drive 3",
      id: 8865,
      url: "http://www.getdropbox.com/u/2/screencast.html"),
];
