import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirebaseResponse {
  String title;
  String description;
  int? color;
  Timestamp createdAt;

  NoteFirebaseResponse({
    required this.title,
    required this.description,
    this.color,
    required this.createdAt,
  });

  NoteFirebaseResponse copyWith({
    String? title,
    String? description,
    int? color,
    Timestamp? createdAt,
  }) {
    return NoteFirebaseResponse(
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'color': color,
      'createdAt': Timestamp.now(),
    };
  }

  factory NoteFirebaseResponse.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return NoteFirebaseResponse(
      title: map['title'] as String,
      description: map['description'] as String,
      color: map['color'] != null ? map['color'] as int : null,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  @override
  String toString() {
    return 'NoteFirebaseResponse(title: $title, description: $description, color: $color, createdAt: $createdAt)';
  }
}
