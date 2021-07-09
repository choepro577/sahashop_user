import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaDialogApp {
  static void showDialogOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thành công!"),
          content: new Text(
              mess == null ? "Gửi yêu cầu bài hát mới thành công!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogNotificationOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogInput(
      {String? title,
      String? hintText,
      Function? onInput,
      Function? onCancel}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              new TextEditingController();
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    controller: textEditingController,
                    decoration: new InputDecoration(
                        labelText: title ?? "", hintText: hintText ?? ""),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(textEditingController.text);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  static void showDialogError(
      {required BuildContext context, String? errorMess}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Có lỗi xảy ra"),
          content: new Text(errorMess!),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogYesNo(
      {String? mess,
      bool barrierDismissible = true,
      Function? onClose,
      Function? onOK}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Hủy",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
            new TextButton(
              child: new Text(
                "Đồng ý",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onOK!();
              },
            ),
          ],
        );
      },
    );
  }
}
