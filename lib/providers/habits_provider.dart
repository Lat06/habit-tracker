import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/habit.dart';
import '../utils/date_helpers.dart';

const _boxName = 'habits';
const _uuid = Uuid();

final habitsProvider =
    StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  return HabitsNotifier();
});

class HabitsNotifier extends StateNotifier<List<Habit>> {
  HabitsNotifier() : super([]) {
    _load();
  }

  Box<Habit> get _box => Hive.box<Habit>(_boxName);

  void _load() {
    state = _box.values.toList();
  }

  void addHabit({
    required String name,
    required String emoji,
    required int colorValue,
  }) {
    final habit = Habit(
      id: _uuid.v4(),
      name: name,
      emoji: emoji,
      colorValue: colorValue,
    );
    _box.add(habit);
    state = _box.values.toList();
  }

  void deleteHabit(String id) {
    final index = _box.values.toList().indexWhere((h) => h.id == id);
    if (index != -1) {
      _box.deleteAt(index);
      state = _box.values.toList();
    }
  }

  void editHabit(
    String id, {
    required String name,
    required String emoji,
    required int colorValue,
  }) {
    final habit = _box.values.firstWhere((h) => h.id == id);
    habit.name = name;
    habit.emoji = emoji;
    habit.colorValue = colorValue;
    habit.save();
    state = _box.values.toList();
  }

  void toggleToday(String id) {
    final habit = _box.values.firstWhere((h) => h.id == id);
    final key = todayKey();
    if (habit.completedDates.contains(key)) {
      habit.completedDates.remove(key);
    } else {
      habit.completedDates.add(key);
    }
    habit.save();
    state = _box.values.toList();
  }
}
