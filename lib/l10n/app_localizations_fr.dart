// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'Aucune habitude';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total complétées';
  }

  @override
  String get addFirstHabit => 'Ajoutez votre première habitude !';

  @override
  String get tapToStart => 'Appuyez sur + pour commencer';

  @override
  String get newHabit => 'Nouvelle habitude';

  @override
  String get editHabit => 'Modifier';

  @override
  String get save => 'Enregistrer';

  @override
  String get tapToChangeIcon => 'Appuyez pour changer l\'icône';

  @override
  String get habitName => 'Nom de l\'habitude';

  @override
  String get habitNameHint => 'Ex. Lecture';

  @override
  String get habitNameError => 'Entrez un nom';

  @override
  String get color => 'Couleur';

  @override
  String get statistics => 'Statistiques';

  @override
  String get noHabitsForStats => 'Aucune habitude à afficher';

  @override
  String get streak => 'Série';

  @override
  String get total => 'Total';

  @override
  String get last30Days => '30 jours';

  @override
  String totalDays(int count) {
    return '$count jours';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get dailyReminder => 'Rappel quotidien';

  @override
  String get dailyReminderSubtitle => 'Rappeler de suivre les habitudes';

  @override
  String get notificationsPermissionDenied =>
      'Autoriser les notifications dans les Paramètres';

  @override
  String get reminderTime => 'Heure du rappel';

  @override
  String get aboutSection => 'À propos';

  @override
  String get version => 'Version';

  @override
  String get appDescription => 'Construisez de bonnes habitudes chaque jour';

  @override
  String get chooseIcon => 'Choisir une icône';

  @override
  String get notificationTitle => '🌱 Habitudes';

  @override
  String get notificationBody =>
      'Il est temps de suivre vos habitudes aujourd\'hui !';

  @override
  String get deleteHabit => 'Supprimer l\'habitude';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
