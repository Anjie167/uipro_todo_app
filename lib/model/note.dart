const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    description,
  ];

  static const String id = '_id';
  static const description = 'description';
  static const category = 'category';
}

class Note {
  final int? id;
  final String description;
  final String category;

  const Note({
    required this.category,
    this.id,
    required this.description,
  });

  Note copy({
    String? category,
    int? id,
    String? description,
  }) =>
      Note(
        category: category ?? this.category,
        id: id ?? this.id,
        description: description ?? this.description,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        description: json[NoteFields.description] as String,
        category: json[NoteFields.category] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.description: description,
        NoteFields.category: category
      };
}
