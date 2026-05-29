import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../config/revenue_cat_config.dart';

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, bool>((ref) {
  return SubscriptionNotifier();
});

class SubscriptionNotifier extends StateNotifier<bool> {
  SubscriptionNotifier() : super(false) {
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    try {
      final info = await Purchases.getCustomerInfo();
      state = _isPremium(info);
    } catch (_) {
      state = false;
    }
  }

  bool _isPremium(CustomerInfo info) =>
      info.entitlements.all[RevenueCatConfig.entitlementId]?.isActive ?? false;

  Future<bool> purchase(Package package) async {
    try {
      final info = await Purchases.purchasePackage(package);
      state = _isPremium(info);
      return state;
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) return false;
      rethrow;
    }
  }

  Future<bool> restore() async {
    try {
      final info = await Purchases.restorePurchases();
      state = _isPremium(info);
      return state;
    } catch (_) {
      return false;
    }
  }

  Future<void> refresh() => _checkStatus();
}
