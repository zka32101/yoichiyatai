import 'package:flutter_test/flutter_test.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/services/placement_calculator.dart';

void main() {
  group('PlacementCalculator', () {
    late Map<String, Stall> stallsMap;

    setUp(() {
      stallsMap = Stall.defaultStalls;
    });

    test('Empty layout returns 0 revenue', () {
      final emptyLayout = {
        0: '', 1: '', 2: '',
        3: '', 4: '', 5: '',
        6: '', 7: '', 8: '',
      };

      final revenue = PlacementCalculator.calculateRevenue(emptyLayout, stallsMap);
      expect(revenue, equals(0));
    });

    test('Single stall returns base revenue', () {
      final layout = {
        0: 'yakiNiku',
        1: '', 2: '',
        3: '', 4: '', 5: '',
        6: '', 7: '', 8: '',
      };

      final revenue = PlacementCalculator.calculateRevenue(layout, stallsMap);
      expect(revenue, equals(1000)); // yakiNiku base revenue
    });

    test('Synergistic stalls increase revenue', () {
      // yakiNiku and veggie have 1.3 synergy
      final layout = {
        0: 'yakiNiku', // position 0
        1: 'veggie',   // position 1 (neighbor of 0)
        2: '', 3: '', 4: '', 5: '', 6: '', 7: '', 8: '',
      };

      final revenue = PlacementCalculator.calculateRevenue(layout, stallsMap);

      // yakiNiku base 1000 * 1.3 (synergy, applied once) = 1300
      // veggie base 800 * 1.3 (synergy, applied once) = 1040
      // Total should be exactly 2340 (not squared to 1.3^2 = 1.69)
      expect(revenue, equals(2340));
      expect(revenue, greaterThan(1800));
    });

    test('Central position has more neighbors', () {
      final layout1 = {
        0: 'yakiNiku', // corner: 3 neighbors max
        1: '', 2: '',
        3: '', 4: '', 5: '',
        6: '', 7: '', 8: '',
      };

      final layout2 = {
        0: '', 1: '', 2: '',
        3: '', 4: 'yakiNiku', // center: 8 neighbors
        5: '', 6: '', 7: '', 8: '',
      };

      // Both have single stall, so same base revenue
      final rev1 = PlacementCalculator.calculateRevenue(layout1, stallsMap);
      final rev2 = PlacementCalculator.calculateRevenue(layout2, stallsMap);
      expect(rev1, equals(rev2)); // Single stall, no synergies
    });

    test('getDetailedCalculation returns correct structure', () {
      final layout = {
        0: 'yakiNiku',
        1: 'veggie',
        2: '', 3: '', 4: '', 5: '', 6: '', 7: '', 8: '',
      };

      final detailed = PlacementCalculator.getDetailedCalculation(layout, stallsMap);

      expect(detailed.containsKey('totalRevenue'), isTrue);
      expect(detailed.containsKey('positions'), isTrue);
      expect(detailed.containsKey('synergies'), isTrue);
      expect(detailed['positions'] is Map, isTrue);
      expect(detailed['synergies'] is List, isTrue);
    });

    test('suggestImprovement provides valid suggestions', () {
      final layout = {
        0: 'yakiNiku',
        1: '', 2: '',
        3: '', 4: '', 5: '',
        6: '', 7: '', 8: '',
      };

      final suggestion =
          PlacementCalculator.suggestImprovement(layout, stallsMap, ['yakiNiku', 'veggie', 'drink']);

      expect(suggestion.containsKey('currentRevenue'), isTrue);
      expect(suggestion.containsKey('maxRevenue'), isTrue);
      expect(suggestion.containsKey('improvementPotential'), isTrue);
      expect(suggestion['maxRevenue'] as int, greaterThan(suggestion['currentRevenue'] as int));
    });

    test('Full layout calculation is non-negative', () {
      final layout = {
        0: 'yakiNiku', 1: 'veggie', 2: 'drink',
        3: 'noodle', 4: 'fruit', 5: 'dessert',
        6: 'yakiNiku', 7: 'veggie', 8: 'drink',
      };

      final revenue = PlacementCalculator.calculateRevenue(layout, stallsMap);
      expect(revenue, greaterThan(0));
    });

    test('calculateRevenue stays consistent with getDetailedCalculation', () {
      final layout = {
        0: 'yakiNiku', 1: 'veggie', 2: 'drink',
        3: 'noodle', 4: 'fruit', 5: 'dessert',
        6: 'yakiNiku', 7: 'veggie', 8: 'drink',
      };

      final revenue = PlacementCalculator.calculateRevenue(layout, stallsMap);
      final detailed = PlacementCalculator.getDetailedCalculation(layout, stallsMap);

      expect(revenue, equals(detailed['totalRevenue']));
    });
  });
}
