import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {},
    );

    tz.initializeTimeZones();
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max, priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification({int id = 0, String? title, String? body, String? payload, required DateTime scheduledDate}) async {
    return notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local) ,
      await notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
