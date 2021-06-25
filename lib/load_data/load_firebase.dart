import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

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

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void removeID() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {

    print("Handling a background message: ${message.messageId}");
    var map = message.data;

    print(map);

    if (map.containsKey('data')) {
      final dynamic data = map['data'];
    }

    if (map.containsKey('notification')) {
      final dynamic notification = map['notification'];
    }
  }

  void handleFirebaseMess() async {

   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      print("Push Messaging token: $token");
      FCMToken().setToken(token);

      if (UserInfo().getToken() != null) {
        RepositoryManager.deviceTokenRepository.updateDeviceTokenUser(token);
      }
    });


  }
}

class FCMToken {
  static final FCMToken _singleton = new FCMToken._internal();

  String? _token;

  String? get token => _token;

  factory FCMToken() {
    return _singleton;
  }

  FCMToken._internal();

  void setToken(String? code) {
    _token = code;
  }

  String? getToken() {
    return _token;
  }
}
