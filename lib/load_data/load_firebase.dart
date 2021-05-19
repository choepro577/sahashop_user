import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

import 'notification/alert_notification.dart';

class LoadFirebase {
  static void initFirebase() async {
    await Firebase.initializeApp();
    FCMMess().handleFirebaseMess();
  }
}

class FCMMess {
  static final FCMMess _singleton = FCMMess._internal();
  FCMMess._internal();

  factory FCMMess() {
    return _singleton;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void removeID() async {
    await _firebaseMessaging.deleteInstanceID();
  }

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {


    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }

    return null;
  }

  void handleFirebaseMess() async {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(
            sound: true,
            badge: true,
            alert: true
        )
    );
    await _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print("Push Messaging token: $token");
      FCMToken().setToken(token);

      if (UserInfo().getToken() != null) {
        RepositoryManager.deviceTokenRepository.updateDeviceTokenUser(token);
      }
    });
    await _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessageFCM: $message");
        SahaNotificationAlert.alertNotification(message);
        var map = Platform.isAndroid ? message["data"] : message;

        try {
          print(map);
        } catch (err) {
          print(err);
        }
      },
      onBackgroundMessage:
          Platform.isIOS ? onBackgroundMessage : onBackgroundMessage,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        if (Platform.isIOS) {
          message = _modifyNotificationJson(message);
        }
        //performActionOnNotification(message);
        print("onResume: $message");
      },
    );
    await _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    await _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    await _firebaseMessaging.subscribeToTopic("matchscore");
  }
}

// void _performActionOnNotification(Map<String, dynamic> message) {
//   NotificationsBloc.instance.newNotification(message);
// }

Map _modifyNotificationJson(Map<String, dynamic> message) {
  message['data'] = Map.from(message ?? {});
  message['notification'] = message['aps']['alert'];
  return message;
}

class FCMToken {
  static final FCMToken _singleton = new FCMToken._internal();

  String _token;

  String get token => _token;

  factory FCMToken() {
    return _singleton;
  }

  FCMToken._internal();

  void setToken(String code) {
    _token = code;
  }

  String getToken() {
    return _token;
  }
}
