import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? displayName;
  final int currentLevel;
  final int totalRevenue;
  final List<String> unlockedStalls;
  final bool isPremium;
  final String? lastPlayDate;
  final int streak;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    this.displayName,
    required this.currentLevel,
    required this.totalRevenue,
    required this.unlockedStalls,
    required this.isPremium,
    this.lastPlayDate,
    required this.streak,
    required this.createdAt,
  });

  factory AppUser.fromFirestore(Map<String, dynamic> data, String uid) {
    return AppUser(
      uid: uid,
      displayName: data['displayName'],
      currentLevel: data['currentLevel'] ?? 0,
      totalRevenue: data['totalRevenue'] ?? 0,
      unlockedStalls: List<String>.from(data['unlockedStalls'] ?? []),
      isPremium: data['isPremium'] ?? false,
      lastPlayDate: data['lastPlayDate'],
      streak: data['streak'] ?? 0,
      createdAt: _parseCreatedAt(data['createdAt']),
    );
  }

  // createdAt はサーバー作成時は Timestamp（FieldValue.serverTimestamp()）、
  // toFirestore() 経由のローカル値はISO8601文字列で入ってくるため両対応する
  static DateTime _parseCreatedAt(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    return DateTime.now();
  }

  Map<String, dynamic> toFirestore() {
    return {
      'displayName': displayName,
      'currentLevel': currentLevel,
      'totalRevenue': totalRevenue,
      'unlockedStalls': unlockedStalls,
      'isPremium': isPremium,
      'lastPlayDate': lastPlayDate,
      'streak': streak,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Default new user
  factory AppUser.newUser(String uid) {
    return AppUser(
      uid: uid,
      currentLevel: 0,
      totalRevenue: 0,
      unlockedStalls: ['yakiNiku', 'veggie', 'drink'], // Initial stalls
      isPremium: false,
      streak: 0,
      createdAt: DateTime.now(),
    );
  }

  // Copy with modifications
  AppUser copyWith({
    String? displayName,
    int? currentLevel,
    int? totalRevenue,
    List<String>? unlockedStalls,
    bool? isPremium,
    String? lastPlayDate,
    int? streak,
  }) {
    return AppUser(
      uid: uid,
      displayName: displayName ?? this.displayName,
      currentLevel: currentLevel ?? this.currentLevel,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      unlockedStalls: unlockedStalls ?? this.unlockedStalls,
      isPremium: isPremium ?? this.isPremium,
      lastPlayDate: lastPlayDate ?? this.lastPlayDate,
      streak: streak ?? this.streak,
      createdAt: createdAt,
    );
  }

  // Check if stall is unlocked
  bool isStallUnlocked(String stallId) {
    return unlockedStalls.contains(stallId);
  }

  // Days since creation
  int daysSinceCreation() {
    return DateTime.now().difference(createdAt).inDays;
  }
}
