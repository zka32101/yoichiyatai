import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(uid).set(
            {
              ...userData,
              'createdAt': FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );
    } catch (e) {
      throw 'ユーザー作成に失敗しました: $e';
    }
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      throw 'ユーザー取得に失敗しました: $e';
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .update({'updatedAt': FieldValue.serverTimestamp(), ...data});
    } catch (e) {
      throw 'ユーザー更新に失敗しました: $e';
    }
  }

  // Daily Record operations
  Future<void> saveDailyRecord(
    String uid,
    String date,
    Map<String, dynamic> recordData,
  ) async {
    try {
      await _firestore
          .collection('dailyRecords')
          .doc(uid)
          .collection('records')
          .doc(date)
          .set(recordData);
    } catch (e) {
      throw '日記録保存に失敗しました: $e';
    }
  }

  Future<Map<String, dynamic>?> getDailyRecord(String uid, String date) async {
    try {
      final doc = await _firestore
          .collection('dailyRecords')
          .doc(uid)
          .collection('records')
          .doc(date)
          .get();
      return doc.data();
    } catch (e) {
      throw '日記録取得に失敗しました: $e';
    }
  }

  Stream<Map<String, dynamic>?> streamDailyRecord(
    String uid,
    String date,
  ) {
    return _firestore
        .collection('dailyRecords')
        .doc(uid)
        .collection('records')
        .doc(date)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  // Stall operations
  Future<Map<String, dynamic>?> getStall(String stallId) async {
    try {
      final doc = await _firestore.collection('stalls').doc(stallId).get();
      return doc.data();
    } catch (e) {
      throw '屋台取得に失敗しました: $e';
    }
  }

  Future<List<Map<String, dynamic>>> getAllStalls() async {
    try {
      final snapshot = await _firestore.collection('stalls').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw '屋台リスト取得に失敗しました: $e';
    }
  }

  Stream<List<Map<String, dynamic>>> streamAllStalls() {
    return _firestore
        .collection('stalls')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  // Leaderboard operations
  Future<List<Map<String, dynamic>>> getLeaderboard({
    String week = 'current',
    int limit = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('leaderboard')
          .doc(week)
          .collection('ranks')
          .orderBy('rank')
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw 'ランキング取得に失敗しました: $e';
    }
  }

  Stream<List<Map<String, dynamic>>> streamLeaderboard({
    String week = 'current',
    int limit = 10,
  }) {
    return _firestore
        .collection('leaderboard')
        .doc(week)
        .collection('ranks')
        .orderBy('rank')
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Batch operations
  Future<void> batchWrite(
    List<(CollectionReference, String, Map<String, dynamic>)> writes,
  ) async {
    try {
      final batch = _firestore.batch();
      for (final (collection, docId, data) in writes) {
        batch.set(collection.doc(docId), data);
      }
      await batch.commit();
    } catch (e) {
      throw 'バッチ書き込みに失敗しました: $e';
    }
  }

  // Generic delete
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw 'ドキュメント削除に失敗しました: $e';
    }
  }
}
