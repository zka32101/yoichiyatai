import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/models/daily_record.dart';

class PlacementCalculator {
  // 3×3 Grid positions and neighbors
  // 0 1 2
  // 3 4 5
  // 6 7 8

  static const List<List<int>> neighbors = [
    [1, 3, 4],        // 0: right, down, down-right
    [0, 2, 3, 4, 5],  // 1: left, right, down-left, down, down-right
    [1, 4, 5],        // 2: left, down-left, down
    [0, 1, 4, 6, 7],  // 3: up, up-right, right, down, down-right
    [0, 1, 2, 3, 5, 6, 7, 8], // 4: all 8 neighbors
    [1, 2, 4, 7, 8],  // 5: up-left, up, left, down-left, down
    [3, 4, 7],        // 6: up, up-right, right
    [3, 4, 5, 6, 8],  // 7: up-left, up, up-right, left, right
    [4, 5, 7],        // 8: up-left, up, left
  ];

  /// Calculate total revenue for a given layout
  ///
  /// getDetailedCalculation() に委譲する。以前は独自ループでシナジーを
  /// 双方向（stall→neighbor と neighbor→stall）にチェックしていたため、
  /// 対称な neighbors テーブル上で同じペアが2回走査され、同一シナジーが
  /// 二重（自乗）適用されるバグがあった。単一方向チェックの
  /// getDetailedCalculation に一本化することで整合性を保証する。
  static int calculateRevenue(
    Map<int, String> layout,
    Map<String, Stall> stallsMap,
  ) {
    return getDetailedCalculation(layout, stallsMap)['totalRevenue'] as int;
  }

  /// Get detailed synergy information
  static Map<String, dynamic> getDetailedCalculation(
    Map<int, String> layout,
    Map<String, Stall> stallsMap,
  ) {
    final Map<int, Map<String, dynamic>> positionDetails = {};
    final List<Map<String, dynamic>> synergies = [];

    // Calculate each position's revenue
    for (int pos = 0; pos < 9; pos++) {
      final stallId = layout[pos];
      if (stallId == null || stallId.isEmpty) {
        positionDetails[pos] = {
          'stallId': null,
          'baseRevenue': 0,
          'multiplier': 1.0,
          'totalRevenue': 0,
        };
        continue;
      }

      final stall = stallsMap[stallId];
      if (stall == null) continue;

      double multiplier = 1.0;

      // Check neighbors for synergies
      for (int neighborPos in neighbors[pos]) {
        final neighborStallId = layout[neighborPos];
        if (neighborStallId == null || neighborStallId.isEmpty) continue;

        final neighborStall = stallsMap[neighborStallId];
        if (neighborStall == null) continue;

        // Check synergy from neighbor to this position
        if (neighborStall.synergies.containsKey(stallId)) {
          final bonus = neighborStall.synergies[stallId]!;
          multiplier *= bonus;
          synergies.add({
            'from': neighborStallId,
            'to': stallId,
            'fromPos': neighborPos,
            'toPos': pos,
            'bonus': bonus,
          });
        }
      }

      final positionRevenue =
          (stall.baseRevenue * multiplier).toInt();

      positionDetails[pos] = {
        'stallId': stallId,
        'stallName': stall.name,
        'baseRevenue': stall.baseRevenue,
        'multiplier': multiplier,
        'totalRevenue': positionRevenue,
      };
    }

    // Calculate total
    int totalRevenue = 0;
    for (final detail in positionDetails.values) {
      totalRevenue += detail['totalRevenue'] as int;
    }

    return {
      'totalRevenue': totalRevenue,
      'positions': positionDetails,
      'synergies': synergies,
    };
  }

  /// Calculate minimum revenue (all empty)
  static int getMinRevenue() => 0;

  /// Calculate theoretical maximum revenue (best layout)
  static int getMaximumRevenue(
    Map<String, Stall> stallsMap, {
    List<String>? availableStalls,
  }) {
    // Simple estimate: use top 9 stalls by base revenue
    final stalls = availableStalls == null
        ? stallsMap.values.toList()
        : stallsMap.entries
            .where((e) => availableStalls.contains(e.key))
            .map((e) => e.value)
            .toList();

    stalls.sort((a, b) => b.baseRevenue.compareTo(a.baseRevenue));
    final topStalls = stalls.take(9).toList();

    // Simplified: sum of top stalls with average multiplier
    int total = topStalls.fold<int>(0, (sum, s) => sum + s.baseRevenue);
    return (total * 1.2).toInt(); // Rough estimate with synergies
  }

  /// Suggest improvements for current layout
  static Map<String, dynamic> suggestImprovement(
    Map<int, String> layout,
    Map<String, Stall> stallsMap,
    List<String> availableStalls,
  ) {
    final currentRevenue = calculateRevenue(layout, stallsMap);
    final maxRevenue = getMaximumRevenue(stallsMap, availableStalls: availableStalls);

    // Find positions with lowest synergies
    final details = getDetailedCalculation(layout, stallsMap);
    final positions = details['positions'] as Map<int, Map<String, dynamic>>;

    final lowSynergyPositions = positions.entries
        .where((e) => (e.value['multiplier'] as double) < 1.2)
        .toList();
    lowSynergyPositions.sort((a, b) =>
        (a.value['multiplier'] as double)
            .compareTo(b.value['multiplier'] as double));

    return {
      'currentRevenue': currentRevenue,
      'maxRevenue': maxRevenue,
      'improvementPotential': maxRevenue - currentRevenue,
      'improvementPercent': ((maxRevenue - currentRevenue) / currentRevenue * 100).toInt(),
      'lowSynergyPositions': lowSynergyPositions.take(3).map((e) => {
        'position': e.key,
        'currentStall': e.value['stallId'],
        'currentMultiplier': e.value['multiplier'],
      }).toList(),
    };
  }
}
