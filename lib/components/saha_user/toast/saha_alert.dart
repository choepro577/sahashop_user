import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/constant.dart';

class SahaAlert {
  static void showError({
    String message = "",
    String title = "Saha",
  }) {
    showFlash(
      duration: Duration(milliseconds: 3500),
      context: Get.context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.black87, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('$title'),
              message: Text('$message'),
              leftBarIndicatorColor: Colors.red,
              icon: Icon(Icons.error),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Đóng'),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showWarning({
    String message = "",
    String title = "Saha",
  }) {
    showFlash(
      duration: Duration(milliseconds: 2000),
      context: Get.context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.amber,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.black87, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('$title'),
              message: Text('$message'),
              leftBarIndicatorColor: Colors.yellow,
              icon: Icon(Icons.info_outline),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Đóng'),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSuccess({
    String message = "",
    String title = "Saha",
  }) {
    showFlash(
      duration: Duration(milliseconds: 1000),
      context: Get.context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.black87, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('$title'),
              message: Text('$message'),
              leftBarIndicatorColor: Colors.green,
              icon: Icon(Icons.check),
            ),
          ),
        );
      },
    );
  }

  static void showBasicsFlash(
    String message, {
    Duration duration,
    flashStyle = FlashStyle.floating,
  }) {
    showFlash(
      context: Get.context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: flashStyle,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            message: Text('$message'),
          ),
        );
      },
    );
  }

  static void showNotificationTopFlash(String title, String body) {
    showFlash(
      duration: Duration(milliseconds: 3500),
      context: Get.context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: SahaPrimaryColor,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.white, Colors.white],
            center: Alignment.topLeft,
            radius: 2,
          ),
          position: FlashPosition.top,
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.black87),
            child: FlashBar(
              title: Text('$title'),
              message: Text('$body'),
              leftBarIndicatorColor: SahaPrimaryColor,
              icon: Icon(Icons.notifications_active),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Đóng'),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showTopFlash({FlashStyle style = FlashStyle.floating}) {
    showFlash(
      context: Get.context,
      duration: const Duration(seconds: 2),
      persistent: false,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          style: style,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text('Title'),
            message: Text('Hello world!'),
            showProgressIndicator: true,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: Text('Đóng', style: TextStyle(color: Colors.amber)),
            ),
          ),
        );
      },
    );
  }

  static void showBottomFlash(
      {bool persistent = true, EdgeInsets margin = EdgeInsets.zero}) {
    showFlash(
      context: Get.context,
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: margin,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.amber, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('Hello Flash'),
              message: Text('You can put any message of any length here.'),
              leftBarIndicatorColor: Colors.red,
              icon: Icon(Icons.info_outline),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Đóng'),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => controller.dismiss('Yes, I do!'),
                    child: Text('YES')),
                TextButton(
                    onPressed: () => controller.dismiss('No, I do not!'),
                    child: Text('NO')),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  static void showInputFlash({
    bool persistent = true,
    WillPopCallback onWillPop,
  }) {
    var editingController = TextEditingController();
    showFlash(
      context: Get.context,
      persistent: persistent,
      onWillPop: onWillPop,
      builder: (_, controller) {
        return Flash.bar(
          controller: controller,
          barrierColor: Colors.black54,
          borderWidth: 3,
          style: FlashStyle.grounded,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          child: FlashBar(
            title: Text('Hello Flash', style: TextStyle(fontSize: 24.0)),
            message: Column(
              children: [
                Text('You can put any message of any length here.'),
                Form(
                  child: TextFormField(
                    controller: editingController,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            leftBarIndicatorColor: Colors.red,
            primaryAction: IconButton(
              onPressed: () {
                if (editingController.text.isEmpty) {
                  controller.dismiss();
                } else {
                  var message = editingController.text;
                  _showMessage(message);
                  editingController.text = '';
                }
              },
              icon: Icon(Icons.send, color: Colors.amber),
            ),
          ),
        );
      },
    );
  }

  static void showCenterFlash({
    FlashPosition position,
    FlashStyle style,
    Alignment alignment,
  }) {
    showFlash(
      context: Get.context,
      duration: Duration(seconds: 5),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.black87,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          position: position,
          style: style,
          alignment: alignment,
          enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Text(
                'You can put any message of any length here.',
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  static void _showMessage(String message) {
    showFlash(
        context: Get.context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            style: FlashStyle.grounded,
            child: FlashBar(
              icon: Icon(
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              message: Text(message),
            ),
          );
        });
  }
}
