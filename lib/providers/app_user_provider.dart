import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoichiyatai/models/user.dart';
import 'package:yoichiyatai/services/firestore_service.dart';
import 'user_provider.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// Firestoreに保存されたAppUserレコード。未作成なら新規作成して返す
final appUserProvider = FutureProvider<AppUser?>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;

  final firestoreService = ref.watch(firestoreServiceProvider);
  final existing = await firestoreService.getUser(user.uid);

  if (existing != null) {
    return AppUser.fromFirestore(existing, user.uid);
  }

  final newUser = AppUser.newUser(user.uid);
  await firestoreService.createUser(user.uid, newUser.toFirestore());
  return newUser;
});

class AppUserActions {
  final FirestoreService _firestoreService;
  final String uid;

  AppUserActions(this._firestoreService, this.uid);

  Future<void> updateAfterPlacement({
    required int revenue,
    required bool isNewDay,
  }) async {
    final existing = await _firestoreService.getUser(uid);
    if (existing == null) return;

    final currentUser = AppUser.fromFirestore(existing, uid);
    final newTotalRevenue = currentUser.totalRevenue + revenue;
    final newStreak = isNewDay ? currentUser.streak + 1 : currentUser.streak;

    await _firestoreService.updateUser(uid, {
      'totalRevenue': newTotalRevenue,
      'streak': newStreak,
      'lastPlayDate': DateTime.now().toIso8601String().split('T').first,
    });
  }

  Future<void> unlockStall(String stallId) async {
    final existing = await _firestoreService.getUser(uid);
    if (existing == null) return;

    final currentUser = AppUser.fromFirestore(existing, uid);
    if (currentUser.isStallUnlocked(stallId)) return;

    await _firestoreService.updateUser(uid, {
      'unlockedStalls': [...currentUser.unlockedStalls, stallId],
    });
  }
}

final appUserActionsProvider = Provider<AppUserActions?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);

  return userAsync.when(
    data: (user) =>
        user == null ? null : AppUserActions(firestoreService, user.uid),
    loading: () => null,
    error: (_, __) => null,
  );
});
