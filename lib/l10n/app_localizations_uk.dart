// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'Немає звичок';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total виконано';
  }

  @override
  String get addFirstHabit => 'Додайте першу звичку!';

  @override
  String get tapToStart => 'Натисніть + щоб розпочати';

  @override
  String get newHabit => 'Нова звичка';

  @override
  String get editHabit => 'Редагувати';

  @override
  String get save => 'Зберегти';

  @override
  String get tapToChangeIcon => 'Натисніть щоб змінити іконку';

  @override
  String get habitName => 'Назва звички';

  @override
  String get habitNameHint => 'Наприклад: Читання';

  @override
  String get habitNameError => 'Введіть назву';

  @override
  String get color => 'Колір';

  @override
  String get statistics => 'Статистика';

  @override
  String get noHabitsForStats => 'Немає звичок для статистики';

  @override
  String get streak => 'Стрік';

  @override
  String get total => 'Всього';

  @override
  String get last30Days => '30 днів';

  @override
  String totalDays(int count) {
    return '$count днів';
  }

  @override
  String get settings => 'Налаштування';

  @override
  String get notificationsSection => 'Сповіщення';

  @override
  String get dailyReminder => 'Щоденне нагадування';

  @override
  String get dailyReminderSubtitle => 'Нагадувати відмічати звички';

  @override
  String get notificationsPermissionDenied =>
      'Дозвольте сповіщення в Налаштуваннях';

  @override
  String get reminderTime => 'Час нагадування';

  @override
  String get aboutSection => 'Про додаток';

  @override
  String get version => 'Версія';

  @override
  String get appDescription => 'Будуй корисні звички щодня';

  @override
  String get chooseIcon => 'Оберіть іконку';

  @override
  String get notificationTitle => '🌱 Звички';

  @override
  String get notificationBody => 'Час відмічати звички на сьогодні!';

  @override
  String get deleteHabit => 'Видалити звичку';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
