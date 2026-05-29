// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'Keine Gewohnheiten';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total erledigt';
  }

  @override
  String get addFirstHabit => 'Füge deine erste Gewohnheit hinzu!';

  @override
  String get tapToStart => 'Tippe auf + um zu starten';

  @override
  String get newHabit => 'Neue Gewohnheit';

  @override
  String get editHabit => 'Bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get tapToChangeIcon => 'Tippe um das Symbol zu ändern';

  @override
  String get habitName => 'Name der Gewohnheit';

  @override
  String get habitNameHint => 'Z.B. Lesen';

  @override
  String get habitNameError => 'Bitte Namen eingeben';

  @override
  String get color => 'Farbe';

  @override
  String get statistics => 'Statistiken';

  @override
  String get noHabitsForStats => 'Keine Gewohnheiten für Statistiken';

  @override
  String get streak => 'Serie';

  @override
  String get total => 'Gesamt';

  @override
  String get last30Days => '30 Tage';

  @override
  String totalDays(int count) {
    return '$count Tage';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get notificationsSection => 'Benachrichtigungen';

  @override
  String get dailyReminder => 'Tägliche Erinnerung';

  @override
  String get dailyReminderSubtitle =>
      'Erinnerung zum Verfolgen von Gewohnheiten';

  @override
  String get notificationsPermissionDenied =>
      'Benachrichtigungen in Einstellungen erlauben';

  @override
  String get reminderTime => 'Erinnerungszeit';

  @override
  String get aboutSection => 'Über die App';

  @override
  String get version => 'Version';

  @override
  String get appDescription => 'Baue jeden Tag gute Gewohnheiten auf';

  @override
  String get chooseIcon => 'Symbol wählen';

  @override
  String get notificationTitle => '🌱 Gewohnheiten';

  @override
  String get notificationBody =>
      'Zeit, deine Gewohnheiten für heute zu verfolgen!';

  @override
  String get deleteHabit => 'Gewohnheit löschen';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
