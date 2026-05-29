// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'Brak nawyków';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total ukończono';
  }

  @override
  String get addFirstHabit => 'Dodaj swój pierwszy nawyk!';

  @override
  String get tapToStart => 'Dotknij +, aby zacząć';

  @override
  String get newHabit => 'Nowy nawyk';

  @override
  String get editHabit => 'Edytuj';

  @override
  String get save => 'Zapisz';

  @override
  String get tapToChangeIcon => 'Dotknij, aby zmienić ikonę';

  @override
  String get habitName => 'Nazwa nawyku';

  @override
  String get habitNameHint => 'Np. Czytanie';

  @override
  String get habitNameError => 'Wprowadź nazwę';

  @override
  String get color => 'Kolor';

  @override
  String get statistics => 'Statystyki';

  @override
  String get noHabitsForStats => 'Brak nawyków do wyświetlenia statystyk';

  @override
  String get streak => 'Seria';

  @override
  String get total => 'Łącznie';

  @override
  String get last30Days => '30 dni';

  @override
  String totalDays(int count) {
    return '$count dni';
  }

  @override
  String get settings => 'Ustawienia';

  @override
  String get notificationsSection => 'Powiadomienia';

  @override
  String get dailyReminder => 'Codzienne przypomnienie';

  @override
  String get dailyReminderSubtitle => 'Przypominaj o śledzeniu nawyków';

  @override
  String get notificationsPermissionDenied =>
      'Zezwól na powiadomienia w Ustawieniach';

  @override
  String get reminderTime => 'Czas przypomnienia';

  @override
  String get aboutSection => 'O aplikacji';

  @override
  String get version => 'Wersja';

  @override
  String get appDescription => 'Buduj dobre nawyki każdego dnia';

  @override
  String get chooseIcon => 'Wybierz ikonę';

  @override
  String get notificationTitle => '🌱 Nawyki';

  @override
  String get notificationBody => 'Czas śledzić swoje nawyki na dziś!';

  @override
  String get deleteHabit => 'Usuń nawyk';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
