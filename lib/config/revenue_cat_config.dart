class RevenueCatConfig {
  // Отримай ключ на app.revenuecat.com → Projects → Your App → API Keys
  static const apiKey = 'YOUR_REVENUECAT_API_KEY';

  // Назва entitlement в RevenueCat (має збігатися з тим що ти створив)
  static const entitlementId = 'premium';

  // Максимум звичок для безкоштовних користувачів
  static const freeHabitLimit = 3;
}
