import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yoichiyatai/models/user.dart';

void main() {
  group('AppUser.fromFirestore', () {
    test('parses createdAt when it is a Firestore Timestamp', () {
      final now = DateTime.now();
      final data = {
        'currentLevel': 1,
        'totalRevenue': 5000,
        'unlockedStalls': ['yakiNiku'],
        'isPremium': false,
        'streak': 2,
        'createdAt': Timestamp.fromDate(now),
      };

      final user = AppUser.fromFirestore(data, 'uid123');

      expect(user.createdAt.millisecondsSinceEpoch,
          equals(now.millisecondsSinceEpoch));
    });

    test('parses createdAt when it is an ISO8601 string', () {
      final now = DateTime.now();
      final data = {
        'currentLevel': 1,
        'totalRevenue': 5000,
        'unlockedStalls': ['yakiNiku'],
        'isPremium': false,
        'streak': 2,
        'createdAt': now.toIso8601String(),
      };

      final user = AppUser.fromFirestore(data, 'uid123');

      expect(user.createdAt.toIso8601String(), equals(now.toIso8601String()));
    });

    test('falls back to now() when createdAt is missing', () {
      final data = {
        'currentLevel': 0,
        'totalRevenue': 0,
        'unlockedStalls': <String>[],
        'isPremium': false,
        'streak': 0,
      };

      expect(() => AppUser.fromFirestore(data, 'uid123'), returnsNormally);
    });

    test('round-trips through createUser-style write (Timestamp overriding a String)', () {
      // firestore_service.createUser() spreads AppUser.toFirestore() (String createdAt)
      // then overrides createdAt with FieldValue.serverTimestamp(), which resolves to a
      // Timestamp on read. This simulates that resulting document shape.
      final data = {
        ...AppUser.newUser('uid123').toFirestore(),
        'createdAt': Timestamp.fromDate(DateTime.now()),
      };

      expect(() => AppUser.fromFirestore(data, 'uid123'), returnsNormally);
    });
  });
}
