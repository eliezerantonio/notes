import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirebaseResponse {
  String? id;
  String title;
  String description;
  Timestamp? createdAt;

  NoteFirebaseResponse({
    required this.title,
    required this.description,
    this.createdAt,
    this.id,
  });

  NoteFirebaseResponse copyWith({
    String? title,
    String? description,
    String? id,
    Timestamp? createdAt,
  }) {
    return NoteFirebaseResponse(
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
    };
  }

  factory NoteFirebaseResponse.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return NoteFirebaseResponse(
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as Timestamp,
      id: doc.id,
    );
  }

  @override
  String toString() {
    return 'NoteFirebaseResponse(title: $title, description: $description, createdAt: $createdAt)';
  }
}
