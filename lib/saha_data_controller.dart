import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/data/socket/socket.dart';

import 'app_customer/utils/thread_data.dart';


class SahaDataController extends GetxController {
  var isPreview = false.obs;
  var unread = 0.obs;
  ScrollController scrollController = new ScrollController();

  @override
  void onInit() {
    SocketUser().connect();
    getDataBoxChatUser();
    super.onInit();

    isPreview.stream.listen((event) {
      if(event == true) {
        FlowData().setIsOnline(true);
      } else {
        FlowData().setIsOnline(false);
      }
    });
  }

  void getDataBoxChatUser() {
    SocketUser().listenCustomer((data) {
      print("------------------------------${data.toString()}");

      unread.value = Unread.fromJson(data).uread!;
      print("------------------------------$unread");
    });
  }

  void changeStatusPreview(bool status) {
    isPreview.value = status;
    if(status == true) {
      FlowData().setIsOnline(true);
    } else {
      FlowData().setIsOnline(false);
    }
  }
}

class Unread {
  Unread({
    this.uread,
  });

  int? uread;

  factory Unread.fromJson(Map<String, dynamic> json) => Unread(
        uread: int.parse(json["uread"]),
      );

  Map<String, dynamic> toJson() => {
        "uread": uread,
      };
}
