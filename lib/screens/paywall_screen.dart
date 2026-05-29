import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../config/subscription_config.dart';
import '../providers/subscription_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  List<ProductDetails> _products = [];
  ProductDetails? _selected;
  bool _loading = true;
  bool _purchasing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final available = await InAppPurchase.instance.isAvailable();
      if (!available) {
        setState(() {
          _loading = false;
          _errorMessage = 'App Store недоступний на цьому пристрої';
        });
        return;
      }
      final response = await InAppPurchase.instance
          .queryProductDetails(SubscriptionConfig.allProductIds);

      if (response.error != null) {
        setState(() {
          _loading = false;
          _errorMessage = response.error!.message;
        });
        return;
      }

      final products = response.productDetails
        ..sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

      setState(() {
        _products = products;
        _selected = products.firstWhere(
          (p) => p.id == SubscriptionConfig.productAnnual,
          orElse: () => products.first,
        );
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _purchase() async {
    if (_selected == null) return;
    setState(() => _purchasing = true);
    try {
      await ref.read(subscriptionProvider.notifier).purchase(_selected!);
    } catch (e) {
      if (mounted) {
        setState(() => _purchasing = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      return;
    }
    if (mounted) setState(() => _purchasing = false);
  }

  Future<void> _restore() async {
    setState(() => _purchasing = true);
    await ref.read(subscriptionProvider.notifier).restore();
    if (mounted) setState(() => _purchasing = false);
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(subscriptionProvider);
    if (isPremium) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));
    }

    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scheme.primary, scheme.tertiary],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => context.go('/'),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🌱',
                                style: TextStyle(fontSize: 40)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Habit Tracker Premium',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Розблокуй всі можливості',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Column(
                            children: [
                              _FeatureRow(
                                emoji: '♾️',
                                title: 'Необмежені звички',
                                subtitle: 'Безкоштовно — до 3 звичок',
                              ),
                              SizedBox(height: 16),
                              _FeatureRow(
                                emoji: '📊',
                                title: 'Детальна аналітика',
                                subtitle: 'Графіки та тенденції за весь час',
                              ),
                              SizedBox(height: 16),
                              _FeatureRow(
                                emoji: '🔔',
                                title: 'Розумні нагадування',
                                subtitle: 'Персональний час для кожної звички',
                              ),
                              SizedBox(height: 16),
                              _FeatureRow(
                                emoji: '🎨',
                                title: 'Без реклами',
                                subtitle: 'Чистий інтерфейс без відволікань',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (_loading)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(),
                          )
                        else if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'Не вдалося завантажити пропозиції.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.red.shade400),
                                ),
                                const SizedBox(height: 20),
                                // Debug кнопка — тільки для тестування UI
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.bug_report, size: 16),
                                  label: const Text('🧪 Тест: Активувати Premium'),
                                  onPressed: () {
                                    ref
                                        .read(subscriptionProvider.notifier)
                                        .debugActivatePremium();
                                    context.go('/');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey.shade600,
                                    side: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: _products.map((product) {
                                final isAnnual = product.id ==
                                    SubscriptionConfig.productAnnual;
                                final isSelected =
                                    _selected?.id == product.id;
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 12),
                                  child: _PriceCard(
                                    product: product,
                                    isSelected: isSelected,
                                    badge: isAnnual ? 'Вигідніше' : null,
                                    onTap: () =>
                                        setState(() => _selected = product),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: FilledButton(
                                onPressed: _purchasing ? null : _purchase,
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: _purchasing
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'Перейти на Premium',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _purchasing ? null : _restore,
                              child: const Text('Відновити покупки'),
                            ),
                            const Text('·',
                                style: TextStyle(color: Colors.grey)),
                            TextButton(
                              onPressed: () => context.go('/'),
                              child: Text(
                                'Залишитись безкоштовно',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Підписка поновлюється автоматично. Скасувати в App Store.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _FeatureRow({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade500)),
            ],
          ),
        ),
        Icon(Icons.check_circle_rounded,
            color: Theme.of(context).colorScheme.primary, size: 22),
      ],
    );
  }
}

class _PriceCard extends StatelessWidget {
  final ProductDetails product;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;

  const _PriceCard({
    required this.product,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAnnual = product.id == SubscriptionConfig.productAnnual;
    final period = isAnnual ? 'на рік' : 'на місяць';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? scheme.primaryContainer
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? scheme.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? scheme.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? scheme.primary
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isAnnual ? 'Річна підписка' : 'Місячна підписка',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${product.price} $period',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
