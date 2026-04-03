import 'package:englens/src/core/constants/app_constants.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_daily_words_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen_viewmodel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart';

class LocalNotificationService {
  // Tạo một instance của plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late SharedPreferences prefs;

  // Hàm khởi tạo
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    // 1. Cài đặt cho Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 2. Cài đặt cho iOS
    final DarwinInitializationSettings darwinSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        );

    // 3. Gộp các cài đặt lại
    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    // 4. Khởi tạo plugin với các cài đặt trên
    // onDidReceiveNotificationResponse sẽ được gọi khi người dùng nhấn vào thông báo
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // 5. Khởi tạo timezone
    tz.initializeTimeZones();
  }

  // ĐÚNG: Định nghĩa hàm là static bên trong class
  @pragma('vm:entry-point')
  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    print('Background notification tapped: ${notificationResponse.payload}');
    Get.offAllNamed(
      TabsScreen.routeName,
      arguments: TabsScreenViewArgs(tabIndex: 0),
    );
    Get.toNamed(LeitnerDailyWordsScreen.routeName);
  }

  // Hàm xin quyền trên các nền tảng
  static Future<void> requestPermissions() async {
    // Xin quyền trên iOS
    var iosRes = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Xin quyền trên Android 13+
    var andrRes = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    if ((iosRes != null && iosRes) || (andrRes != null && andrRes)) {
      prefs.setBool(AppConstants.notificationKey, true);
    } else {
      prefs.setBool(AppConstants.notificationKey, false);
    }
  }

  // Future<bool> checkAndroidPermission() async {
  //   final bool? isEnabled =
  //       await _notificationsPlugin.();
  //   return isEnabled ?? false;
  // }

  // Hàm để hiển thị một thông báo đơn giản
  static Future<void> showSimpleNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'simple_channel_id', // ID của channel
          'Simple Notifications', // Tên của channel
          channelDescription: 'Channel for simple notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: 'simple_payload',
    );
  }

  // Hàm để lên lịch một thông báo
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    Duration? duration, // Lên lịch sau một khoảng thời gian
    required TZDateTime scheduledDate, // Lên lịch tại một thời điểm cụ thể
    required AndroidScheduleMode androidScheduleMode, // Chế độ lên lịch
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'scheduled_channel_id',
          'Scheduled Notifications',
          channelDescription: 'Channel for scheduled notifications',
          importance: Importance.max,
          priority: Priority.high,
        );
    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    // await _notificationsPlugin.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   tz.TZDateTime.now(tz.local).add(duration), // Thời gian hiển thị
    //   notificationDetails,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   androidAllowWhileIdle:
    //       true, // Cho phép hiển thị khi thiết bị ở chế độ nghỉ
    //   payload: 'scheduled_payload',
    // );

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: androidScheduleMode,
      payload: 'scheduled_payload',
    );
  }
}
