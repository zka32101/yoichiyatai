import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatConfig {
  // API Key - use environment variable or secret management
  static const String _apiKey =
      'TODO_REVENUCAT_API_KEY'; // Replace with actual API key

  static Future<void> initialize() async {
    await Purchases.configure(
      PurchasesConfiguration(_apiKey),
    );
  }

  // Get current offerings
  static Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
      return null;
    }
  }

  // Check if user is premium
  static Future<bool> isUserPremium() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.active.containsKey('premium');
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
      return false;
    }
  }

  // Purchase premium subscription
  static Future<bool> purchasePremium(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return await isUserPremium();
    } on PurchasesException catch (e) {
      print('Purchase error: ${e.message}');
      return false;
    }
  }

  // Get customer info
  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
      return null;
    }
  }

  // Restore purchases
  static Future<bool> restorePurchases() async {
    try {
      await Purchases.restorePurchases();
      return await isUserPremium();
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
      return false;
    }
  }

  // Set user ID for tracking
  static Future<void> setUserId(String userId) async {
    try {
      await Purchases.logIn(userId);
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      await Purchases.logOut();
    } on PurchasesException catch (e) {
      print('RevenueCat error: ${e.message}');
    }
  }
}
