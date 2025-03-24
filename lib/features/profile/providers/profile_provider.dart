import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/profile_service.dart';
import '../../auth/models/user_model.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService();
});

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  return await ref.watch(profileServiceProvider).getUserProfile();
});

class ProfileNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final ProfileService _profileService;

  ProfileNotifier(this._profileService) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final profile = await _profileService.getUserProfile();
      state = AsyncValue.data(profile);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProfile({String? displayName, File? profileImage}) async {
    try {
      await _profileService.updateProfile(
        displayName: displayName,
        profileImage: profileImage,
      );
      _loadProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProfileImage() async {
    try {
      await _profileService.deleteProfileImage();
      _loadProfile();
    } catch (e) {
      rethrow;
    }
  }
}

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<UserModel?>>((ref) {
  final profileService = ref.watch(profileServiceProvider);
  return ProfileNotifier(profileService);
});
