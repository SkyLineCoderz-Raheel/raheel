import 'package:battery/battery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BatteryAlarmScreen(),
    );
  }
}

class BatteryAlarmScreen extends StatefulWidget {
  @override
  _BatteryAlarmScreenState createState() => _BatteryAlarmScreenState();
}

class _BatteryAlarmScreenState extends State<BatteryAlarmScreen> {
  final Battery _battery = Battery();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _startBatteryListener();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, iOS: null, macOS: null);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    // Handle notification click
  }

  void _startBatteryListener() {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      _checkBatteryLevel();
    });
  }

  void _checkBatteryLevel() async {
    final batteryLevel = await _battery.batteryLevel;

    // Specify your desired battery percentage
    final alarmPercentage = 20;

    if (batteryLevel <= alarmPercentage) {
      _showNotification();
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'battery_alarm_channel',
      'Battery Alarm',
      'Notifies when the battery level is low',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Low Battery',
      'Your battery level is low. Please charge your device.',
      platformChannelSpecifics,
      payload: 'battery_alarm',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Alarm'),
      ),
      body: Center(
        child: Text('Listening for battery changes...'),
      ),
    );
  }
}
