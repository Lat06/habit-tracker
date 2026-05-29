import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/add_habit_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/add', builder: (_, __) => const AddHabitScreen()),
    GoRoute(
      path: '/edit/:id',
      builder: (_, state) =>
          AddHabitScreen(habitId: state.pathParameters['id']),
    ),
    GoRoute(path: '/stats', builder: (_, __) => const StatsScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
