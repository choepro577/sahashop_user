import 'package:get/get.dart';

class HomeController extends GetxController {
  var isExpansion = false.obs;

  void onChangeExpansion(bool value) {
    isExpansion.value = value;
  }
}