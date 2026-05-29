String dateKey(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

String todayKey() => dateKey(DateTime.now());

int calculateStreak(List<String> completedDates) {
  if (completedDates.isEmpty) return 0;

  final sorted = completedDates.toList()..sort();
  final today = DateTime.now();
  int streak = 0;

  for (int i = 0; i <= 365; i++) {
    final day = today.subtract(Duration(days: i));
    if (sorted.contains(dateKey(day))) {
      streak++;
    } else {
      break;
    }
  }
  return streak;
}

bool isCompletedToday(List<String> completedDates) =>
    completedDates.contains(todayKey());
