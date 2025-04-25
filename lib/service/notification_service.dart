import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remainder/screens/home_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();
  static final behaviorSubjectForNotification = BehaviorSubject<String?>();

  static Future _notificationDetail() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('Remainder', 'Schedule Remainder',
          importance: Importance.max, priority: Priority.max),
    );
  }

  static Future localNotificationInitialization(
      BuildContext context, String uid) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings("clock_alarm");
    final settings = InitializationSettings(android: android);
    await _notificationPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        behaviorSubjectForNotification.add(details as String?);
      },
    );
  }

  static Future showNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime storedDatetime}) async {
    if (storedDatetime.isBefore(DateTime.now())) {
      storedDatetime = storedDatetime.add(Duration(days: 1));
    }

    _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(storedDatetime, tz.local),
      await _notificationDetail(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
