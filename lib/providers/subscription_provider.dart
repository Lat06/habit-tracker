import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../config/subscription_config.dart';

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, bool>((ref) {
  return SubscriptionNotifier();
});

class SubscriptionNotifier extends StateNotifier<bool> {
  StreamSubscription<List<PurchaseDetails>>? _sub;

  SubscriptionNotifier() : super(false) {
    _sub = InAppPurchase.instance.purchaseStream.listen(_onPurchases);
    _restoreOnLaunch();
  }

  // Тільки для тестування — симулює покупку без StoreKit
  void debugActivatePremium() => state = true;
  void debugDeactivatePremium() => state = false;

  Future<void> _restoreOnLaunch() async {
    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (_) {}
  }

  void _onPurchases(List<PurchaseDetails> purchases) {
    for (final p in purchases) {
      if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        if (SubscriptionConfig.allProductIds.contains(p.productID)) {
          state = true;
        }
        if (p.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(p);
        }
      } else if (p.status == PurchaseStatus.error) {
        if (p.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(p);
        }
      }
    }
  }

  Future<bool> purchase(ProductDetails product) async {
    final available = await InAppPurchase.instance.isAvailable();
    if (!available) return false;
    final param = PurchaseParam(productDetails: product);
    return InAppPurchase.instance.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restore() async {
    await InAppPurchase.instance.restorePurchases();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
