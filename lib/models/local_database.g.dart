// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $DailyRecordsTable extends DailyRecords
    with TableInfo<$DailyRecordsTable, DailyRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layoutJsonMeta = const VerificationMeta(
    'layoutJson',
  );
  @override
  late final GeneratedColumn<String> layoutJson = GeneratedColumn<String>(
    'layout_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revenueMeta = const VerificationMeta(
    'revenue',
  );
  @override
  late final GeneratedColumn<int> revenue = GeneratedColumn<int>(
    'revenue',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _missionCompleteMeta = const VerificationMeta(
    'missionComplete',
  );
  @override
  late final GeneratedColumn<bool> missionComplete = GeneratedColumn<bool>(
    'mission_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mission_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    date,
    layoutJson,
    revenue,
    missionComplete,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('layout_json')) {
      context.handle(
        _layoutJsonMeta,
        layoutJson.isAcceptableOrUnknown(data['layout_json']!, _layoutJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_layoutJsonMeta);
    }
    if (data.containsKey('revenue')) {
      context.handle(
        _revenueMeta,
        revenue.isAcceptableOrUnknown(data['revenue']!, _revenueMeta),
      );
    } else if (isInserting) {
      context.missing(_revenueMeta);
    }
    if (data.containsKey('mission_complete')) {
      context.handle(
        _missionCompleteMeta,
        missionComplete.isAcceptableOrUnknown(
          data['mission_complete']!,
          _missionCompleteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid, date};
  @override
  DailyRecordEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRecordEntry(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      layoutJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout_json'],
      )!,
      revenue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revenue'],
      )!,
      missionComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mission_complete'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyRecordsTable createAlias(String alias) {
    return $DailyRecordsTable(attachedDatabase, alias);
  }
}

class DailyRecordEntry extends DataClass
    implements Insertable<DailyRecordEntry> {
  final String uid;
  final String date;
  final String layoutJson;
  final int revenue;
  final bool missionComplete;
  final DateTime createdAt;
  const DailyRecordEntry({
    required this.uid,
    required this.date,
    required this.layoutJson,
    required this.revenue,
    required this.missionComplete,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['date'] = Variable<String>(date);
    map['layout_json'] = Variable<String>(layoutJson);
    map['revenue'] = Variable<int>(revenue);
    map['mission_complete'] = Variable<bool>(missionComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyRecordsCompanion(
      uid: Value(uid),
      date: Value(date),
      layoutJson: Value(layoutJson),
      revenue: Value(revenue),
      missionComplete: Value(missionComplete),
      createdAt: Value(createdAt),
    );
  }

  factory DailyRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRecordEntry(
      uid: serializer.fromJson<String>(json['uid']),
      date: serializer.fromJson<String>(json['date']),
      layoutJson: serializer.fromJson<String>(json['layoutJson']),
      revenue: serializer.fromJson<int>(json['revenue']),
      missionComplete: serializer.fromJson<bool>(json['missionComplete']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'date': serializer.toJson<String>(date),
      'layoutJson': serializer.toJson<String>(layoutJson),
      'revenue': serializer.toJson<int>(revenue),
      'missionComplete': serializer.toJson<bool>(missionComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyRecordEntry copyWith({
    String? uid,
    String? date,
    String? layoutJson,
    int? revenue,
    bool? missionComplete,
    DateTime? createdAt,
  }) => DailyRecordEntry(
    uid: uid ?? this.uid,
    date: date ?? this.date,
    layoutJson: layoutJson ?? this.layoutJson,
    revenue: revenue ?? this.revenue,
    missionComplete: missionComplete ?? this.missionComplete,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyRecordEntry copyWithCompanion(DailyRecordsCompanion data) {
    return DailyRecordEntry(
      uid: data.uid.present ? data.uid.value : this.uid,
      date: data.date.present ? data.date.value : this.date,
      layoutJson: data.layoutJson.present
          ? data.layoutJson.value
          : this.layoutJson,
      revenue: data.revenue.present ? data.revenue.value : this.revenue,
      missionComplete: data.missionComplete.present
          ? data.missionComplete.value
          : this.missionComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecordEntry(')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('layoutJson: $layoutJson, ')
          ..write('revenue: $revenue, ')
          ..write('missionComplete: $missionComplete, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(uid, date, layoutJson, revenue, missionComplete, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRecordEntry &&
          other.uid == this.uid &&
          other.date == this.date &&
          other.layoutJson == this.layoutJson &&
          other.revenue == this.revenue &&
          other.missionComplete == this.missionComplete &&
          other.createdAt == this.createdAt);
}

class DailyRecordsCompanion extends UpdateCompanion<DailyRecordEntry> {
  final Value<String> uid;
  final Value<String> date;
  final Value<String> layoutJson;
  final Value<int> revenue;
  final Value<bool> missionComplete;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DailyRecordsCompanion({
    this.uid = const Value.absent(),
    this.date = const Value.absent(),
    this.layoutJson = const Value.absent(),
    this.revenue = const Value.absent(),
    this.missionComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyRecordsCompanion.insert({
    required String uid,
    required String date,
    required String layoutJson,
    required int revenue,
    this.missionComplete = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       date = Value(date),
       layoutJson = Value(layoutJson),
       revenue = Value(revenue),
       createdAt = Value(createdAt);
  static Insertable<DailyRecordEntry> custom({
    Expression<String>? uid,
    Expression<String>? date,
    Expression<String>? layoutJson,
    Expression<int>? revenue,
    Expression<bool>? missionComplete,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (date != null) 'date': date,
      if (layoutJson != null) 'layout_json': layoutJson,
      if (revenue != null) 'revenue': revenue,
      if (missionComplete != null) 'mission_complete': missionComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyRecordsCompanion copyWith({
    Value<String>? uid,
    Value<String>? date,
    Value<String>? layoutJson,
    Value<int>? revenue,
    Value<bool>? missionComplete,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DailyRecordsCompanion(
      uid: uid ?? this.uid,
      date: date ?? this.date,
      layoutJson: layoutJson ?? this.layoutJson,
      revenue: revenue ?? this.revenue,
      missionComplete: missionComplete ?? this.missionComplete,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (layoutJson.present) {
      map['layout_json'] = Variable<String>(layoutJson.value);
    }
    if (revenue.present) {
      map['revenue'] = Variable<int>(revenue.value);
    }
    if (missionComplete.present) {
      map['mission_complete'] = Variable<bool>(missionComplete.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecordsCompanion(')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('layoutJson: $layoutJson, ')
          ..write('revenue: $revenue, ')
          ..write('missionComplete: $missionComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSettingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _darkModeMeta = const VerificationMeta(
    'darkMode',
  );
  @override
  late final GeneratedColumn<bool> darkMode = GeneratedColumn<bool>(
    'dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dark_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _soundVolumeMeta = const VerificationMeta(
    'soundVolume',
  );
  @override
  late final GeneratedColumn<int> soundVolume = GeneratedColumn<int>(
    'sound_volume',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ja'),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    darkMode,
    notificationsEnabled,
    soundVolume,
    language,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSettingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('dark_mode')) {
      context.handle(
        _darkModeMeta,
        darkMode.isAcceptableOrUnknown(data['dark_mode']!, _darkModeMeta),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sound_volume')) {
      context.handle(
        _soundVolumeMeta,
        soundVolume.isAcceptableOrUnknown(
          data['sound_volume']!,
          _soundVolumeMeta,
        ),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserSettingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingEntry(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      darkMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dark_mode'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      soundVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sound_volume'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSettingEntry extends DataClass
    implements Insertable<UserSettingEntry> {
  final String uid;
  final bool darkMode;
  final bool notificationsEnabled;
  final int soundVolume;
  final String language;
  final DateTime lastUpdated;
  const UserSettingEntry({
    required this.uid,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.soundVolume,
    required this.language,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['dark_mode'] = Variable<bool>(darkMode);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['sound_volume'] = Variable<int>(soundVolume);
    map['language'] = Variable<String>(language);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      uid: Value(uid),
      darkMode: Value(darkMode),
      notificationsEnabled: Value(notificationsEnabled),
      soundVolume: Value(soundVolume),
      language: Value(language),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory UserSettingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingEntry(
      uid: serializer.fromJson<String>(json['uid']),
      darkMode: serializer.fromJson<bool>(json['darkMode']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      soundVolume: serializer.fromJson<int>(json['soundVolume']),
      language: serializer.fromJson<String>(json['language']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'darkMode': serializer.toJson<bool>(darkMode),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'soundVolume': serializer.toJson<int>(soundVolume),
      'language': serializer.toJson<String>(language),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  UserSettingEntry copyWith({
    String? uid,
    bool? darkMode,
    bool? notificationsEnabled,
    int? soundVolume,
    String? language,
    DateTime? lastUpdated,
  }) => UserSettingEntry(
    uid: uid ?? this.uid,
    darkMode: darkMode ?? this.darkMode,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    soundVolume: soundVolume ?? this.soundVolume,
    language: language ?? this.language,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  UserSettingEntry copyWithCompanion(UserSettingsCompanion data) {
    return UserSettingEntry(
      uid: data.uid.present ? data.uid.value : this.uid,
      darkMode: data.darkMode.present ? data.darkMode.value : this.darkMode,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      soundVolume: data.soundVolume.present
          ? data.soundVolume.value
          : this.soundVolume,
      language: data.language.present ? data.language.value : this.language,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingEntry(')
          ..write('uid: $uid, ')
          ..write('darkMode: $darkMode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('soundVolume: $soundVolume, ')
          ..write('language: $language, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    darkMode,
    notificationsEnabled,
    soundVolume,
    language,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingEntry &&
          other.uid == this.uid &&
          other.darkMode == this.darkMode &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.soundVolume == this.soundVolume &&
          other.language == this.language &&
          other.lastUpdated == this.lastUpdated);
}

class UserSettingsCompanion extends UpdateCompanion<UserSettingEntry> {
  final Value<String> uid;
  final Value<bool> darkMode;
  final Value<bool> notificationsEnabled;
  final Value<int> soundVolume;
  final Value<String> language;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.uid = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.soundVolume = const Value.absent(),
    this.language = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required String uid,
    this.darkMode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.soundVolume = const Value.absent(),
    this.language = const Value.absent(),
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       lastUpdated = Value(lastUpdated);
  static Insertable<UserSettingEntry> custom({
    Expression<String>? uid,
    Expression<bool>? darkMode,
    Expression<bool>? notificationsEnabled,
    Expression<int>? soundVolume,
    Expression<String>? language,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (darkMode != null) 'dark_mode': darkMode,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (soundVolume != null) 'sound_volume': soundVolume,
      if (language != null) 'language': language,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith({
    Value<String>? uid,
    Value<bool>? darkMode,
    Value<bool>? notificationsEnabled,
    Value<int>? soundVolume,
    Value<String>? language,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return UserSettingsCompanion(
      uid: uid ?? this.uid,
      darkMode: darkMode ?? this.darkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundVolume: soundVolume ?? this.soundVolume,
      language: language ?? this.language,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (darkMode.present) {
      map['dark_mode'] = Variable<bool>(darkMode.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (soundVolume.present) {
      map['sound_volume'] = Variable<int>(soundVolume.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('uid: $uid, ')
          ..write('darkMode: $darkMode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('soundVolume: $soundVolume, ')
          ..write('language: $language, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $DailyRecordsTable dailyRecords = $DailyRecordsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailyRecords,
    userSettings,
  ];
}

typedef $$DailyRecordsTableCreateCompanionBuilder =
    DailyRecordsCompanion Function({
      required String uid,
      required String date,
      required String layoutJson,
      required int revenue,
      Value<bool> missionComplete,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DailyRecordsTableUpdateCompanionBuilder =
    DailyRecordsCompanion Function({
      Value<String> uid,
      Value<String> date,
      Value<String> layoutJson,
      Value<int> revenue,
      Value<bool> missionComplete,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DailyRecordsTableFilterComposer
    extends Composer<_$LocalDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layoutJson => $composableBuilder(
    column: $table.layoutJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revenue => $composableBuilder(
    column: $table.revenue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get missionComplete => $composableBuilder(
    column: $table.missionComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyRecordsTableOrderingComposer
    extends Composer<_$LocalDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layoutJson => $composableBuilder(
    column: $table.layoutJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revenue => $composableBuilder(
    column: $table.revenue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get missionComplete => $composableBuilder(
    column: $table.missionComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyRecordsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get layoutJson => $composableBuilder(
    column: $table.layoutJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revenue =>
      $composableBuilder(column: $table.revenue, builder: (column) => column);

  GeneratedColumn<bool> get missionComplete => $composableBuilder(
    column: $table.missionComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailyRecordsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $DailyRecordsTable,
          DailyRecordEntry,
          $$DailyRecordsTableFilterComposer,
          $$DailyRecordsTableOrderingComposer,
          $$DailyRecordsTableAnnotationComposer,
          $$DailyRecordsTableCreateCompanionBuilder,
          $$DailyRecordsTableUpdateCompanionBuilder,
          (
            DailyRecordEntry,
            BaseReferences<
              _$LocalDatabase,
              $DailyRecordsTable,
              DailyRecordEntry
            >,
          ),
          DailyRecordEntry,
          PrefetchHooks Function()
        > {
  $$DailyRecordsTableTableManager(_$LocalDatabase db, $DailyRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> layoutJson = const Value.absent(),
                Value<int> revenue = const Value.absent(),
                Value<bool> missionComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyRecordsCompanion(
                uid: uid,
                date: date,
                layoutJson: layoutJson,
                revenue: revenue,
                missionComplete: missionComplete,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                required String date,
                required String layoutJson,
                required int revenue,
                Value<bool> missionComplete = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyRecordsCompanion.insert(
                uid: uid,
                date: date,
                layoutJson: layoutJson,
                revenue: revenue,
                missionComplete: missionComplete,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $DailyRecordsTable,
      DailyRecordEntry,
      $$DailyRecordsTableFilterComposer,
      $$DailyRecordsTableOrderingComposer,
      $$DailyRecordsTableAnnotationComposer,
      $$DailyRecordsTableCreateCompanionBuilder,
      $$DailyRecordsTableUpdateCompanionBuilder,
      (
        DailyRecordEntry,
        BaseReferences<_$LocalDatabase, $DailyRecordsTable, DailyRecordEntry>,
      ),
      DailyRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      required String uid,
      Value<bool> darkMode,
      Value<bool> notificationsEnabled,
      Value<int> soundVolume,
      Value<String> language,
      required DateTime lastUpdated,
      Value<int> rowid,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<String> uid,
      Value<bool> darkMode,
      Value<bool> notificationsEnabled,
      Value<int> soundVolume,
      Value<String> language,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$LocalDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$LocalDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<bool> get darkMode =>
      $composableBuilder(column: $table.darkMode, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $UserSettingsTable,
          UserSettingEntry,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSettingEntry,
            BaseReferences<
              _$LocalDatabase,
              $UserSettingsTable,
              UserSettingEntry
            >,
          ),
          UserSettingEntry,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$LocalDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<bool> darkMode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> soundVolume = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion(
                uid: uid,
                darkMode: darkMode,
                notificationsEnabled: notificationsEnabled,
                soundVolume: soundVolume,
                language: language,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                Value<bool> darkMode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> soundVolume = const Value.absent(),
                Value<String> language = const Value.absent(),
                required DateTime lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                uid: uid,
                darkMode: darkMode,
                notificationsEnabled: notificationsEnabled,
                soundVolume: soundVolume,
                language: language,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $UserSettingsTable,
      UserSettingEntry,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSettingEntry,
        BaseReferences<_$LocalDatabase, $UserSettingsTable, UserSettingEntry>,
      ),
      UserSettingEntry,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$DailyRecordsTableTableManager get dailyRecords =>
      $$DailyRecordsTableTableManager(_db, _db.dailyRecords);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
}
