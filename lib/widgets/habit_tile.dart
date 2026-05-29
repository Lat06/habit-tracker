import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/habit.dart';
import '../providers/habits_provider.dart';
import '../utils/date_helpers.dart';
import 'streak_badge.dart';

class HabitTile extends ConsumerWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = isCompletedToday(habit.completedDates);
    final streak = calculateStreak(habit.completedDates);
    final color = Color(habit.colorValue);

    return Dismissible(
      key: Key(habit.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red.shade400,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) =>
          ref.read(habitsProvider.notifier).deleteHabit(habit.id),
      child: GestureDetector(
        onLongPress: () => context.go('/edit/${habit.id}'),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: done ? 0 : 2,
          color:
              done ? color.withValues(alpha: 0.15) : Theme.of(context).cardColor,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child:
                    Text(habit.emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            title: Text(
              habit.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: done ? TextDecoration.lineThrough : null,
                color: done ? Colors.grey : null,
              ),
            ),
            subtitle: streak > 0 ? StreakBadge(streak: streak) : null,
            trailing: GestureDetector(
              onTap: () =>
                  ref.read(habitsProvider.notifier).toggleToday(habit.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done ? color : Colors.transparent,
                  border: Border.all(
                    color: done ? color : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: done
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
