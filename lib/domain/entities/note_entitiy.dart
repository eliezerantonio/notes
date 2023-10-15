class NoteEntity {
  late String? id;
  late String? title;
  late String? description;
  late DateTime? date;

  NoteEntity({
    this.title,
    this.description,
    this.date,
    this.id,
  });
}
