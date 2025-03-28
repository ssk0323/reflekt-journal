import 'package:cloud_firestore/cloud_firestore.dart';

class Insight {
  final String id;
  final String title;
  final String content;
  final String? type; // trend, improvement, suggestion
  final DateTime? createdAt;

  Insight({
    required this.id,
    required this.title,
    required this.content,
    this.type,
    this.createdAt,
  });

  factory Insight.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Insight(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      type: data['type'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'type': type,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }
}
