import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/timezone.dart' as tz;
import '../l10n/app_localizations.dart';

final _notifications = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  await _notifications.initialize(
    const InitializationSettings(android: androidSettings, iOS: iosSettings),
  );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _remindersEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);

  Future<void> _toggleReminders(bool value) async {
    final l = AppLocalizations.of(context)!;
    if (value) {
      final ios = _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final granted = await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
      if (!granted && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.notificationsPermissionDenied)),
        );
        return;
      }
      await _scheduleReminder(_reminderTime);
    } else {
      await _notifications.cancelAll();
    }
    setState(() => _remindersEnabled = value);
  }

  Future<void> _scheduleReminder(TimeOfDay time) async {
    final l = AppLocalizations.of(context)!;
    await _notifications.cancelAll();
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    await _notifications.zonedSchedule(
      0,
      l.notificationTitle,
      l.notificationBody,
      scheduled,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily reminder',
          importance: Importance.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null) {
      setState(() => _reminderTime = picked);
      if (_remindersEnabled) await _scheduleReminder(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settings),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        children: [
          _SectionHeader(l.notificationsSection),
          SwitchListTile(
            title: Text(l.dailyReminder),
            subtitle: Text(l.dailyReminderSubtitle),
            value: _remindersEnabled,
            onChanged: _toggleReminders,
          ),
          if (_remindersEnabled)
            ListTile(
              title: Text(l.reminderTime),
              trailing: Text(
                _reminderTime.format(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: _pickTime,
            ),
          _SectionHeader(l.aboutSection),
          ListTile(
            title: Text(l.version),
            trailing:
                const Text('1.0.0', style: TextStyle(color: Colors.grey)),
          ),
          ListTile(
            title: Text(l.appTitle),
            subtitle: Text(l.appDescription),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
