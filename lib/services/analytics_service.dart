import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Aha Moment event
  Future<void> logAhaMomentReached({
    required int previousRevenue,
    required int currentRevenue,
    required int improvementPercent,
  }) async {
    await _analytics.logEvent(
      name: 'aha_moment_reached',
      parameters: {
        'previous_revenue': previousRevenue,
        'current_revenue': currentRevenue,
        'improvement_percent': improvementPercent,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // Daily placement confirmed
  Future<void> logDailyPlacementConfirmed({
    required int revenue,
    required int level,
    required int streak,
    required int sessionDurationSeconds,
  }) async {
    await _analytics.logEvent(
      name: 'daily_placement_confirmed',
      parameters: {
        'revenue': revenue,
        'level': level,
        'streak': streak,
        'session_duration_seconds': sessionDurationSeconds,
      },
    );
  }

  // Streak reached
  Future<void> logStreakReached({required int streakDays}) async {
    await _analytics.logEvent(
      name: 'streak_${streakDays}_reached',
      parameters: {
        'streak_days': streakDays,
      },
    );
  }

  // Paywall viewed
  Future<void> logPaywallViewed({
    required String paymentType,
  }) async {
    await _analytics.logEvent(
      name: 'paywall_viewed',
      parameters: {
        'payment_type': paymentType,
      },
    );
  }

  // Premium purchased
  Future<void> logPremiumPurchased({
    required String productId,
    required double price,
    required String currency,
  }) async {
    await _analytics.logEvent(
      name: 'premium_purchased',
      parameters: {
        'product_id': productId,
        'price': price,
        'currency': currency,
      },
    );
  }

  // Onboarding complete
  Future<void> logOnboardingComplete() async {
    await _analytics.logEvent(
      name: 'onboarding_complete',
    );
  }

  // Level up
  Future<void> logLevelUp({required int newLevel}) async {
    await _analytics.logEvent(
      name: 'level_up',
      parameters: {
        'new_level': newLevel,
      },
    );
  }

  // Stall unlocked
  Future<void> logStallUnlocked({required String stallId}) async {
    await _analytics.logEvent(
      name: 'stall_unlocked',
      parameters: {
        'stall_id': stallId,
      },
    );
  }

  // Set user properties
  Future<void> setUserLevel(int level) async {
    await _analytics.setUserProperty(
      name: 'level',
      value: level.toString(),
    );
  }

  Future<void> setStreakDays(int days) async {
    await _analytics.setUserProperty(
      name: 'streak_days',
      value: days.toString(),
    );
  }

  Future<void> setIsPremium(bool isPremium) async {
    await _analytics.setUserProperty(
      name: 'is_premium',
      value: isPremium.toString(),
    );
  }

  // Screen view tracking
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  // Custom event (generic)
  Future<void> logCustomEvent(
    String eventName, {
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
