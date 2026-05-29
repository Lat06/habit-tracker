import 'package:hive_flutter/hive_flutter.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String emoji;

  @HiveField(3)
  late int colorValue;

  @HiveField(4)
  late List<String> completedDates;

  Habit({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorValue,
    List<String>? completedDates,
  }) : completedDates = completedDates ?? [];
}
