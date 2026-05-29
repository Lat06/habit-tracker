// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'No habits';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total completed';
  }

  @override
  String get addFirstHabit => 'Add your first habit!';

  @override
  String get tapToStart => 'Tap + to get started';

  @override
  String get newHabit => 'New Habit';

  @override
  String get editHabit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get tapToChangeIcon => 'Tap to change icon';

  @override
  String get habitName => 'Habit name';

  @override
  String get habitNameHint => 'E.g. Reading';

  @override
  String get habitNameError => 'Enter a name';

  @override
  String get color => 'Color';

  @override
  String get statistics => 'Statistics';

  @override
  String get noHabitsForStats => 'No habits to display statistics';

  @override
  String get streak => 'Streak';

  @override
  String get total => 'Total';

  @override
  String get last30Days => '30 days';

  @override
  String totalDays(int count) {
    return '$count days';
  }

  @override
  String get settings => 'Settings';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get dailyReminder => 'Daily reminder';

  @override
  String get dailyReminderSubtitle => 'Remind to track habits';

  @override
  String get notificationsPermissionDenied => 'Allow notifications in Settings';

  @override
  String get reminderTime => 'Reminder time';

  @override
  String get aboutSection => 'About';

  @override
  String get version => 'Version';

  @override
  String get appDescription => 'Build good habits every day';

  @override
  String get chooseIcon => 'Choose an icon';

  @override
  String get notificationTitle => '🌱 Habits';

  @override
  String get notificationBody => 'Time to track your habits today!';

  @override
  String get deleteHabit => 'Delete habit';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
