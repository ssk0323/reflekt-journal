import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String emotion; // happy, sad, neutral, angry
  final bool hasImage;
  final String? imageUrl;
  final Map<String, String>? questionAnswers;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DiaryEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.emotion,
    this.hasImage = false,
    this.imageUrl,
    this.questionAnswers,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory DiaryEntry.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DiaryEntry(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      emotion: data['emotion'] ?? 'neutral',
      hasImage: data['hasImage'] ?? false,
      imageUrl: data['imageUrl'],
      questionAnswers: data['questionAnswers'] != null
          ? Map<String, String>.from(data['questionAnswers'])
          : null,
      userId: data['userId'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': Timestamp.fromDate(date),
      'emotion': emotion,
      'hasImage': hasImage,
      'imageUrl': imageUrl,
      'questionAnswers': questionAnswers,
      'userId': userId,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  DiaryEntry copyWith({
    String? title,
    String? content,
    DateTime? date,
    String? emotion,
    bool? hasImage,
    String? imageUrl,
    Map<String, String>? questionAnswers,
  }) {
    return DiaryEntry(
      id: this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      emotion: emotion ?? this.emotion,
      hasImage: hasImage ?? this.hasImage,
      imageUrl: imageUrl ?? this.imageUrl,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      userId: this.userId,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
