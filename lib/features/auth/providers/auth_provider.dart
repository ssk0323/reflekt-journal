import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(authServiceProvider).currentUser;
  if (user == null) return null;

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  } catch (e) {
    return null;
  }
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;
  final FirebaseFirestore _firestore;

  AuthNotifier(this._authService, this._firestore)
      : super(const AsyncValue.data(null));

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signUpWithEmail(email, password);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithEmail(email, password);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithApple();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      await _authService.sendPasswordResetEmail(email);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  final firestore = FirebaseFirestore.instance;
  return AuthNotifier(authService, firestore);
});
