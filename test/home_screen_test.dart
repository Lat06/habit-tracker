import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/screens/home_screen.dart';

Widget _buildTestApp() {
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/add', builder: (_, __) => const SizedBox()),
    GoRoute(path: '/stats', builder: (_, __) => const SizedBox()),
    GoRoute(path: '/settings', builder: (_, __) => const SizedBox()),
    GoRoute(path: '/edit/:id', builder: (_, __) => const SizedBox()),
  ]);
  return ProviderScope(
    child: MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    Hive.registerAdapter(HabitAdapter());
    await Hive.openBox<Habit>('habits');
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  group('HomeScreen порожній стан', () {
    // Тести перевіряють англійські рядки (локаль тестів — en)
    testWidgets('показує текст порожнього стану', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Add your first habit!'), findsOneWidget);
      expect(find.text('Tap + to get started'), findsOneWidget);
    });

    testWidgets('показує кнопку додавання звички', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('New Habit'), findsOneWidget);
    });

    testWidgets('показує емодзі-рослину', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('🌱'), findsOneWidget);
    });
  });
}
