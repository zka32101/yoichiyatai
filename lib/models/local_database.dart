import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

@DataClassName('DailyRecordEntry')
class DailyRecords extends Table {
  TextColumn get uid => text()();
  TextColumn get date => text()(); // YYYY-MM-DD
  TextColumn get layoutJson => text()(); // JSON serialized layout
  IntColumn get revenue => integer()();
  BoolColumn get missionComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {uid, date};
}

@DataClassName('UserSettingEntry')
class UserSettings extends Table {
  TextColumn get uid => text().primaryKey()();
  BoolColumn get darkMode => boolean().withDefault(const Constant(false))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get soundVolume => integer().withDefault(const Constant(100))();
  TextColumn get language => text().withDefault(const Constant('ja'))();
  DateTimeColumn get lastUpdated => dateTime()();
}

@DriftDatabase(tables: [DailyRecords, UserSettings])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Daily Records
  Future<List<DailyRecordEntry>> getDailyRecords(String uid) async {
    return (select(dailyRecords)..where((tbl) => tbl.uid.equals(uid)))
        .get();
  }

  Future<DailyRecordEntry?> getDailyRecord(String uid, String date) async {
    return (select(dailyRecords)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.date.equals(date)))
        .getSingleOrNull();
  }

  Future<void> insertDailyRecord(DailyRecordEntry record) async {
    return into(dailyRecords).insert(
      record,
      onConflict: DoUpdate((_) => record),
    );
  }

  Future<void> deleteDailyRecord(String uid, String date) async {
    return (delete(dailyRecords)
          ..where((tbl) => tbl.uid.equals(uid) & tbl.date.equals(date)))
        .go();
  }

  // User Settings
  Future<UserSettingEntry?> getUserSettings(String uid) async {
    return (select(userSettings)..where((tbl) => tbl.uid.equals(uid)))
        .getSingleOrNull();
  }

  Future<void> insertUserSettings(UserSettingEntry setting) async {
    return into(userSettings).insert(
      setting,
      onConflict: DoUpdate((_) => setting),
    );
  }

  Future<void> updateUserSettings(String uid, Map<String, dynamic> updates) async {
    final setting = await getUserSettings(uid);
    if (setting == null) return;

    final updated = setting.copyWith(
      darkMode: updates['darkMode'] ?? setting.darkMode,
      notificationsEnabled: updates['notificationsEnabled'] ?? setting.notificationsEnabled,
      soundVolume: updates['soundVolume'] ?? setting.soundVolume,
      language: updates['language'] ?? setting.language,
      lastUpdated: DateTime.now(),
    );

    return (update(userSettings)..where((tbl) => tbl.uid.equals(uid)))
        .write(updated);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/yoichiyatai.db');
    return NativeDatabase(file);
  });
}
