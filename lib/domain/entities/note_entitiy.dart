class NoteEntity {
  String title;
  String description;
  int? color;
  DateTime? date;

  NoteEntity({
    required this.title,
    required this.description,
    this.date,
    this.color,
  });
}
