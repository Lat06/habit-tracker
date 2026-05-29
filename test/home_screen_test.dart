import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  return ProviderScope(child: MaterialApp.router(routerConfig: router));
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
    testWidgets('показує "Додайте першу звичку!" коли список порожній',
        (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Додайте першу звичку!'), findsOneWidget);
      expect(find.text('Натисніть + щоб розпочати'), findsOneWidget);
    });

    testWidgets('показує кнопку "Нова звичка"', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Нова звичка'), findsOneWidget);
    });

    testWidgets('показує емодзі-рослину', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('🌱'), findsOneWidget);
    });
  });
}
