import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:sahashop_user/utils/date_utils.dart';

class ChooseTimeController extends GetxController {
  DateTime timeNow;
  List<String> listTextChooseDAY = ["Hôm nay: ", "Hôm qua: "];
  List<DateTime> listFromDateDAY;
  List<DateTime> listToDateDAY;
  List<String> listTextChooseWEEK = [
    "Tuần này: ",
    "7 ngày qua: ",
    "Tuần trước: "
  ];
  List<DateTime> listFromDateWEEK;
  List<DateTime> listToDateWEEK;
  List<String> listTextChooseMONTH = [
    "Tháng này: ",
    "30 ngày qua: ",
    "Tháng trước: "
  ];
  List<DateTime> listFromDateMONTH;
  List<DateTime> listToDateMONTH;
  List<String> listTextChooseYEAR = ["Năm này: ", "Năm trước: "];
  List<DateTime> listFromDateYEAR;
  List<DateTime> listToDateYEAR;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;

  ChooseTimeController() {
    timeNow = DateTime.now();
    listFromDateDAY = [
      timeNow,
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listToDateDAY = [
      timeNow,
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listFromDateWEEK = [
      SahaDateUtils().getFirstDayOfWeekDATETIME(),
      DateTime.now().subtract(Duration(days: 7)),
      SahaDateUtils().getFirstDayOfLastWeekDATETIME(),
    ];
    listToDateWEEK = [
      timeNow,
      timeNow,
      SahaDateUtils().getEndDayOfLastWeekDATETIME(),
    ];
    listFromDateMONTH = [
      SahaDateUtils().getFirstDayOfMonthDATETIME(),
      DateTime.now().subtract(Duration(days: 30)),
      SahaDateUtils().getFirstDayOfLastMonthDATETIME(),
    ];
    listToDateMONTH = [
      timeNow,
      timeNow,
      SahaDateUtils().getEndDayOfLastMonthDATETIME(),
    ];
    listFromDateYEAR = [
      SahaDateUtils().getFirstDayOfThisYearDATETIME(),
      SahaDateUtils().getFirstDayOfLastYearDATETIME(),
    ];
    listToDateYEAR = [
      timeNow,
      SahaDateUtils().getEndDayOfLastYearDATETIME(),
    ];
  }

  Future<void> chooseRangeTime(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        locale: Locale('vi', 'VN'),
        context: context,
        initialFirstDate: new DateTime.now(),
        initialLastDate: new DateTime.now(),
        firstDate: new DateTime(2015),
        lastDate: new DateTime(DateTime.now().year + 2));
    if (picked != null && picked.length == 2) {
      fromDay.value = picked[0];
      toDay.value = picked[1];
    }
  }
}
