import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:steemit/presentation/page/post/post_page.dart';

final NotificationService notificationService = NotificationService();

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> setup() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> getToken() async {
    final token = await _messaging.getToken();
    return token;
  }

  void initInfo(BuildContext context) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const aInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const init = InitializationSettings(android: aInit);
    flutterLocalNotificationsPlugin.initialize(init,
        onDidReceiveNotificationResponse: (notification) {
      if (notification.payload != null && notification.payload!.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostPage(
                      postId: notification.payload.toString(),
                    )));
      } else {}
    });

    FirebaseMessaging.onMessage.listen((message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails("steemit", "steemit",
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails,
          payload: message.data["body"]);
    });
  }

  Future<void> sendPushMessage(
      String? token, String body, String postId) async {
    try {
      final http.Response response =
          await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: <String, String>{
                "Content-Type": "application/json",
                "Authorization":
                    "key=AAAATh4i5nI:APA91bF7ciE9W7fHdJbaBDN_BXP3it4TzcnYsc0dJou161ZkC2nZFCHts5ghOEXEKtCgRyL-UR492AVJdzXbTqJZznasTGub0O4yylaxspAGPUV3W4cMPz58_3DYkd0x3hkVJUSz3K5J",
              },
              body: jsonEncode(<String, dynamic>{
                'priority': 'high',
                'data': <String, dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'status': 'done',
                  'body': postId,
                  'title': postId,
                },
                'notification': <String, dynamic>{
                  'body': body,
                  'title': "Thông báo",
                  'android_channel_id': 'steemit',
                },
                'to': token,
              }));
    } catch (e) {}
  }
}
