import 'package:get/get.dart';

class HomeStyle1Controller extends GetxController {
  var opacity = .0.obs;

  void changeOpacitySearch(double va) {
    opacity.value = va;
  }
}