class DailyRecord {
  final String date; // YYYY-MM-DD format
  final Map<int, String> layout; // position (0-8) -> stallId
  final int revenue;
  final bool missionComplete;
  final DateTime? createdAt;

  DailyRecord({
    required this.date,
    required this.layout,
    required this.revenue,
    required this.missionComplete,
    this.createdAt,
  });

  factory DailyRecord.fromFirestore(Map<String, dynamic> data) {
    return DailyRecord(
      date: data['date'] ?? '',
      layout: Map<int, String>.from(
        Map.from(data['layout'] ?? {}).cast<String, String>()
            .map((key, value) => MapEntry(int.parse(key), value))
      ),
      revenue: data['revenue'] ?? 0,
      missionComplete: data['missionComplete'] ?? false,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'layout': layout.map((key, value) => MapEntry(key.toString(), value)),
      'revenue': revenue,
      'missionComplete': missionComplete,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Empty layout for new records
  static Map<int, String> emptyLayout() {
    return {
      0: '', 1: '', 2: '',
      3: '', 4: '', 5: '',
      6: '', 7: '', 8: '',
    };
  }

  // Copy with modifications
  DailyRecord copyWith({
    String? date,
    Map<int, String>? layout,
    int? revenue,
    bool? missionComplete,
    DateTime? createdAt,
  }) {
    return DailyRecord(
      date: date ?? this.date,
      layout: layout ?? this.layout,
      revenue: revenue ?? this.revenue,
      missionComplete: missionComplete ?? this.missionComplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Validate layout - all 9 cells must be filled
  bool isLayoutComplete() {
    return layout.values.where((v) => v.isEmpty).isEmpty;
  }

  // Get stalls in layout
  List<String> getUsedStalls() {
    return layout.values.where((v) => v.isNotEmpty).toList();
  }
}
