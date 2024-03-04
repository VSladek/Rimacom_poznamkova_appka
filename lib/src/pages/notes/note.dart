class Note {
  const Note(this.id, this.name, this.detail, this.date);

  final int id;

  final String name;

  final String detail;

  final DateTime date;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'date': date.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'] as int,
      json['name'] as String,
      json['detail'] as String,
      DateTime.parse(json['date'] as String),
    );
  }
}
