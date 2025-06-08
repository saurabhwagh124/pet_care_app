import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/model/notification_dto_model.dart';
import 'package:pet_care_app/network/api_endpoints.dart';
import 'package:pet_care_app/utils/user_data.dart';

class NotificationService extends GetxService {
  UserData userData = UserData();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log("notifications: ${message.notification!.title.toString()}");
    if (message.notification != null) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: message.notification?.title,
        body: message.notification?.body,
        notificationLayout: NotificationLayout.BigPicture,
        displayOnBackground: true,
        // displayOnForeground: true
      ));
    }
  }

  Future<String> getToken() async {
    return await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
  }

  Future<void> getFcmtoken() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        log('FCM Token: $token');
        userData.write('fcmToken', token);
        sendTokenTOBackend(token);
      } else {
        log("User Denied Notification Permission");
      }
    }
    checkTokenRefresh();
  }

  void checkTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      log('FCM Token: $token');
      if (token != userData.read("fcmToken")) {
        userData.write('fcmToken', token);
        sendTokenTOBackend(token);
      }
    });
  }

  Future<void> sendTokenTOBackend(String fcmToken) async {
    String token = await getToken();
    String email = FirebaseAuth.instance.currentUser?.email ?? "";
    final headers = {
      "Authorization": "Bearer $token",
      "Content_Type": "application/json"
    };
    final uri = ApiEndpoints.postFcmTokenUrl.replaceAll("{EMAIL}", email);
    final url = uri.replaceAll("{TOKEN}", fcmToken);
    log(url);
    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        log("ERROR WHILE POSTING FCM TOKEN");
      }
    } catch (e) {
      throw Exception("error in send token to backend $e");
    }
  }

  Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/ic_launcher',
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription:
                  'Notification channel for basic notifications',
              defaultColor: const Color.fromARGB(255, 242, 175, 88),
              ledColor: Colors.deepOrange,
              importance: NotificationImportance.Max,
              playSound: true,
              onlyAlertOnce: true,
              channelShowBadge: true,
              enableVibration: true,
              groupKey: 'group_basic',
              vibrationPattern: lowVibrationPattern)
        ],
        debug: false);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                channelKey: 'basic_channel',
                title: message.notification?.title,
                body: message.notification?.body));
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> addNotificationToAll(NotificationDtoModel payload) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final response = await http.post(
          Uri.parse(ApiEndpoints.postNotificationToAll),
          headers: headers,
          body: jsonEncode(payload.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Notification Sent", "Notification sent to all users",
            backgroundColor: Colors.lightGreenAccent);
      } else {
        throw Exception("Add notification to all else error ");
      }
    } catch (e) {
      throw Exception("Add notification to all errror: $e");
    }
  }
}
