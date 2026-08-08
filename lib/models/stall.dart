class Stall {
  final String id;
  final String name;
  final String description;
  final int baseRevenue;
  final String category;
  final int unlockedAtLevel;
  final Map<String, double> synergies;

  Stall({
    required this.id,
    required this.name,
    required this.description,
    required this.baseRevenue,
    required this.category,
    required this.unlockedAtLevel,
    required this.synergies,
  });

  factory Stall.fromFirestore(Map<String, dynamic> data, String id) {
    return Stall(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      baseRevenue: data['baseRevenue'] ?? 0,
      category: data['category'] ?? '',
      unlockedAtLevel: data['unlockedAtLevel'] ?? 0,
      synergies: Map<String, double>.from(data['synergies'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'baseRevenue': baseRevenue,
      'category': category,
      'unlockedAtLevel': unlockedAtLevel,
      'synergies': synergies,
    };
  }

  // Sample stalls for reference
  static final Map<String, Stall> defaultStalls = {
    'yakiNiku': Stall(
      id: 'yakiNiku',
      name: '焼肉',
      description: '焼肉屋台',
      baseRevenue: 1000,
      category: 'meat',
      unlockedAtLevel: 0,
      synergies: {'veggie': 1.3, 'fruit': 1.1},
    ),
    'veggie': Stall(
      id: 'veggie',
      name: '野菜',
      description: '野菜屋台',
      baseRevenue: 800,
      category: 'vegetable',
      unlockedAtLevel: 0,
      synergies: {'yakiNiku': 1.3, 'fruit': 1.2},
    ),
    'dessert': Stall(
      id: 'dessert',
      name: 'デザート',
      description: 'デザート屋台',
      baseRevenue: 600,
      category: 'sweet',
      unlockedAtLevel: 2,
      synergies: {'drink': 1.2, 'fruit': 1.1},
    ),
    'fruit': Stall(
      id: 'fruit',
      name: '果物',
      description: '果物屋台',
      baseRevenue: 700,
      category: 'fruit',
      unlockedAtLevel: 1,
      synergies: {'veggie': 1.2, 'dessert': 1.1},
    ),
    'noodle': Stall(
      id: 'noodle',
      name: '麺類',
      description: '麺類屋台',
      baseRevenue: 900,
      category: 'noodle',
      unlockedAtLevel: 1,
      synergies: {'yakiNiku': 1.1, 'drink': 1.2},
    ),
    'drink': Stall(
      id: 'drink',
      name: '飲料',
      description: '飲料屋台',
      baseRevenue: 500,
      category: 'drink',
      unlockedAtLevel: 0,
      synergies: {'noodle': 1.2, 'dessert': 1.2},
    ),
  };
}
