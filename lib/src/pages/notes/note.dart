class Note {
  const Note(this.title, this.body, this.date);

  final String title;

  final String body;

  final DateTime date;

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['title'],
      json['body'],
      DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
    };
  }
}
