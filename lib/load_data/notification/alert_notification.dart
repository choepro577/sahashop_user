import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';

class SahaNotificationAlert {
  static const String NEW_ORDER = "NEW_ORDER";

  static void alertNotification(Map<String, dynamic> message) {

    if (message['notification'] != null &&
        message['notification']['body'] != null &&
        message['notification']['title'] != null) {

      SahaAlert.showNotificationTopFlash(
          message['notification']['title'], message['notification']['body']);
    }
  }
}
