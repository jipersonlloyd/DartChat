class Information{

  int id;
  String bookName;
  String genre;
  String authorsName;
  String borrowersName;

  Information({
    required this.id,
    required this.bookName,
    required this.genre,
    required this.authorsName,
    required this.borrowersName
  });

  static Information getInformationDataFromServer(var json){
    Information information = Information(
    id: json['id'],
    bookName: json['bookName'],
    genre: json['genre'],
    authorsName: json['authorsName'],
    borrowersName: json['borrowersName'],);
    return information;
  }
}