class Note {
  const Note(this.id, this.name, this.detail, this.date);

  final int id;

  final String name;

  final String detail;

  final int date;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'date': date,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'] as int,
      json['name'] as String,
      json['detail'] as String,
      json['date'] as int,
    );
  }
}
