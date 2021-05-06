
import 'package:get/get.dart';

class SahaDataController extends GetxController {

  var isPreview = false.obs;

  void changeStatusPreview(bool status) {
    isPreview.value = status;
  }

}
