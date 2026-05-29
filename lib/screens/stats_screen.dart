import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../l10n/app_localizations.dart';
import '../models/habit.dart';
import '../providers/habits_provider.dart';
import '../utils/date_helpers.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  Habit? _selected;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final habits = ref.watch(habitsProvider);
    if (_selected == null && habits.isNotEmpty) {
      _selected = habits.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.statistics),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: habits.isEmpty
          ? Center(child: Text(l.noHabitsForStats))
          : Column(
              children: [
                _HabitSelector(
                  habits: habits,
                  selected: _selected,
                  onSelected: (h) => setState(() => _selected = h),
                ),
                const SizedBox(height: 8),
                if (_selected != null) ...[
                  _StatsHeader(habit: _selected!),
                  TableCalendar(
                    firstDay:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDay: DateTime.now(),
                    focusedDay: _focusedDay,
                    onPageChanged: (d) => setState(() => _focusedDay = d),
                    calendarFormat: CalendarFormat.month,
                    locale: Localizations.localeOf(context).toString(),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, _) =>
                          _dayCell(day, _selected!),
                      todayBuilder: (context, day, _) =>
                          _dayCell(day, _selected!),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _dayCell(DateTime day, Habit habit) {
    final key = dateKey(day);
    final done = habit.completedDates.contains(key);
    final color = Color(habit.colorValue);
    final isToday = dateKey(day) == dateKey(DateTime.now());

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: done ? color.withValues(alpha: 0.8) : Colors.transparent,
        shape: BoxShape.circle,
        border: isToday && !done
            ? Border.all(color: color, width: 1.5)
            : null,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: done ? Colors.white : null,
            fontWeight: isToday ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}

class _StatsHeader extends StatelessWidget {
  final Habit habit;
  const _StatsHeader({required this.habit});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final streak = calculateStreak(habit.completedDates);
    final total = habit.completedDates.length;
    final color = Color(habit.colorValue);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _StatCard(label: l.streak, value: '$streak 🔥', color: color),
          const SizedBox(width: 12),
          _StatCard(
              label: l.total, value: l.totalDays(total), color: color),
          const SizedBox(width: 12),
          _StatCard(
            label: l.last30Days,
            value: _last30Percent(habit.completedDates),
            color: color,
          ),
        ],
      ),
    );
  }

  String _last30Percent(List<String> dates) {
    int count = 0;
    final now = DateTime.now();
    for (int i = 0; i < 30; i++) {
      if (dates.contains(dateKey(now.subtract(Duration(days: i))))) count++;
    }
    return '${(count / 30 * 100).round()}%';
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}

class _HabitSelector extends StatelessWidget {
  final List<Habit> habits;
  final Habit? selected;
  final ValueChanged<Habit> onSelected;

  const _HabitSelector({
    required this.habits,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: habits.length,
        itemBuilder: (context, i) {
          final h = habits[i];
          final isSelected = h.id == selected?.id;
          return GestureDetector(
            onTap: () => onSelected(h),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color(h.colorValue)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(h.emoji, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    h.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
