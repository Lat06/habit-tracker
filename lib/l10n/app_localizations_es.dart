// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Habit Tracker';

  @override
  String get noHabits => 'Sin hábitos';

  @override
  String habitsCompleted(int done, int total) {
    return '$done / $total completados';
  }

  @override
  String get addFirstHabit => '¡Añade tu primer hábito!';

  @override
  String get tapToStart => 'Toca + para empezar';

  @override
  String get newHabit => 'Nuevo hábito';

  @override
  String get editHabit => 'Editar';

  @override
  String get save => 'Guardar';

  @override
  String get tapToChangeIcon => 'Toca para cambiar el icono';

  @override
  String get habitName => 'Nombre del hábito';

  @override
  String get habitNameHint => 'Ej. Lectura';

  @override
  String get habitNameError => 'Introduce un nombre';

  @override
  String get color => 'Color';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get noHabitsForStats => 'No hay hábitos para mostrar estadísticas';

  @override
  String get streak => 'Racha';

  @override
  String get total => 'Total';

  @override
  String get last30Days => '30 días';

  @override
  String totalDays(int count) {
    return '$count días';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get notificationsSection => 'Notificaciones';

  @override
  String get dailyReminder => 'Recordatorio diario';

  @override
  String get dailyReminderSubtitle => 'Recordar registrar hábitos';

  @override
  String get notificationsPermissionDenied =>
      'Permitir notificaciones en Ajustes';

  @override
  String get reminderTime => 'Hora del recordatorio';

  @override
  String get aboutSection => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get appDescription => 'Construye buenos hábitos cada día';

  @override
  String get chooseIcon => 'Elegir icono';

  @override
  String get notificationTitle => '🌱 Hábitos';

  @override
  String get notificationBody => '¡Es hora de registrar tus hábitos de hoy!';

  @override
  String get deleteHabit => 'Eliminar hábito';

  @override
  String percentComplete(int percent) {
    return '$percent%';
  }
}
