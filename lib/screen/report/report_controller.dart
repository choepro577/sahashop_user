import 'package:get/get.dart';

class ReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;

  ReportController() {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
  }
}
