import 'package:get/get.dart';

class HomeStyle3Controller extends GetxController {
  var opacity = .0.obs;
  var changeHeight = 35.0.obs;
  var checkTouch = false.obs;

  void changeOpacitySearch(double va) {
    opacity.value = va;
  }

  void changeHeightAppbar(double va) {
    changeHeight.value = va;
  }
}
