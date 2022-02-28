class Book {
  final String bookName;
  final String bookPath;

  Book(this.bookName, this.bookPath);

  Book.fromJson(Map<String, dynamic> json)
      : bookName = json['bookName'],
        bookPath = json['bookPath'];

  Map<String, dynamic> toJson() => {
        'bookName': bookName,
        'bookPath': bookPath,
      };
}
