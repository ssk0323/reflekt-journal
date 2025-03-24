import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final Timestamp? createdAt;
  final String? provider;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.createdAt,
    this.provider,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      createdAt: data['createdAt'],
      provider: data['provider'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'provider': provider,
    };
  }

  UserModel copyWith({
    String? displayName,
    String? photoURL,
  }) {
    return UserModel(
      id: this.id,
      email: this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: this.createdAt,
      provider: this.provider,
    );
  }
}
