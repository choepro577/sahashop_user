import 'package:get/get.dart';
import 'package:sahashop_user/data/socket/socket.dart';

class SahaDataController extends GetxController {
  var isPreview = false.obs;
  var unread = 0.obs;

  @override
  void onInit() {
    SocketUser().connect();
    getDataBoxChatUser();
    super.onInit();
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
