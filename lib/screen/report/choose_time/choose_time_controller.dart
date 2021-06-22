import 'package:get/get.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ChooseTimeController extends GetxController {
  DateTime? timeNow;
  bool checkSelected = false;
  bool checkSelectedCP = false;
  List<String> listTextChooseDAY = ["Hôm nay: ", "Hôm qua: "];
  List<DateTime>? listFromDateDAY;
  List<DateTime>? listToDateDAY;
  List<String> listTextChooseWEEK = [
    "Tuần này: ",
    "7 ngày qua: ",
    "Tuần trước: "
  ];
  List<DateTime>? listFromDateWEEK;
  List<DateTime>? listToDateWEEK;
  List<String>? listTextChooseMONTH = [
    "Tháng này: ",
    "30 ngày qua: ",
    "Tháng trước: "
  ];
  List<DateTime>? listFromDateMONTH;
  List<DateTime>? listToDateMONTH;
  List<String>? listTextChooseYEAR = ["Năm này: ", "Năm trước: "];
  List<DateTime>? listFromDateYEAR;
  List<DateTime>? listToDateYEAR;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;

  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;

  /// compare
  bool? isCompareInput;
  var isCompare = false.obs;
  var listFromDateDAYCP = RxList<DateTime>();
  var listToDateDAYCP = RxList<DateTime>();
  var listFromDateWEEKCP = RxList<DateTime>();
  var listToDateWEEKCP = RxList<DateTime>();
  var listFromDateMONTHCP = RxList<DateTime>();
  var listToDateMONTHCP = RxList<DateTime>();
  var listFromDateYEARCP = RxList<DateTime>();
  var listToDateYEARCP = RxList<DateTime>();
  var fromDateOption = DateTime.now().obs;
  var toDateOption = DateTime.now().obs;
  var fromDateOptionCP = DateTime.now().obs;
  var toDateOptionCP = DateTime.now().obs;

  List<String> listTextChooseDAYCP = [
    "Ngày trước đó: ",
    "Ngày này tuần trước: ",
    'Ngày này năm trước: '
  ];

  List<String> listTextChooseWEEKCP = [
    "Tuần trước đó: ",
    "Tuần này tháng trước: ",
  ];

  List<String> listTextChooseMONTHCP = [
    "Tháng trước đó: ",
    "Tháng này năm trước: ",
  ];

  List<String> listTextChooseYEARCP = [
    "Năm trước đó: ",
  ];

  ChooseTimeController({this.isCompareInput}) {
    isCompare.value = isCompareInput!;

    timeNow = DateTime.now();
    listFromDateDAY = [
      timeNow!,
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listToDateDAY = [
      timeNow!,
      SahaDateUtils().getYesterdayDATETIME(),
    ];
    listFromDateWEEK = [
      SahaDateUtils().getFirstDayOfWeekDATETIME(),
      DateTime.now().subtract(Duration(days: 7)),
      SahaDateUtils().getFirstDayOfLastWeekDATETIME(),
    ];
    listToDateWEEK = [
      timeNow!,
      timeNow!,
      SahaDateUtils().getEndDayOfLastWeekDATETIME(),
    ];
    listFromDateMONTH = [
      SahaDateUtils().getFirstDayOfMonthDATETIME(),
      DateTime.now().subtract(Duration(days: 30)),
      SahaDateUtils().getFirstDayOfLastMonthDATETIME(),
    ];
    listToDateMONTH = [
      timeNow!,
      timeNow!,
      SahaDateUtils().getEndDayOfLastMonthDATETIME(),
    ];
    listFromDateYEAR = [
      SahaDateUtils().getFirstDayOfThisYearDATETIME(),
      SahaDateUtils().getFirstDayOfLastYearDATETIME(),
    ];
    listToDateYEAR = [
      timeNow!,
      SahaDateUtils().getEndDayOfLastYearDATETIME(),
    ];

    /// compare
    listFromDateDAYCP([
      SahaDateUtils().getYesterdayDATETIME(),
      SahaDateUtils().getYesterdayDATETIME().subtract(Duration(days: 6)),
      timeNow!.subtract(Duration(days: 365)),
    ]);

    listToDateDAYCP([
      SahaDateUtils().getYesterdayDATETIME(),
      SahaDateUtils().getYesterdayDATETIME().subtract(Duration(days: 6)),
      timeNow!.subtract(Duration(days: 365)),
    ]);

    listFromDateWEEKCP([
      SahaDateUtils().getFirstDayOfLastWeekDATETIME(),
      SahaDateUtils().getFirstDayOfWeekDATETIME().subtract(Duration(days: 31)),
    ]);

    listToDateWEEKCP([
      SahaDateUtils().getEndDayOfLastWeekDATETIME(),
      timeNow!.subtract(Duration(days: 31)),
    ]);

    listFromDateMONTHCP([
      SahaDateUtils().getFirstDayOfLastMonthDATETIME(),
      SahaDateUtils().getFirstDayOfMonthDATETIME().subtract(Duration(days: 365))
    ]);

    listToDateMONTHCP([
      timeNow!.subtract(Duration(days: 31)),
      timeNow!.subtract(Duration(days: 365)),
    ]);

    listFromDateYEARCP([
      SahaDateUtils().getFirstDayOfLastYearDATETIME(),
    ]);

    listToDateYEARCP([
      timeNow!.subtract(Duration(days: 365)),
    ]);

    fromDateOption.value = timeNow!;
    toDateOption.value = timeNow!;
    fromDateOptionCP.value = timeNow!;
    toDateOptionCP.value = timeNow!;
  }

  void chooseDate(DateTime fromDate, DateTime toDate, int indexType) {
    checkSelected = true;
    fromDay.value = fromDate;
    toDay.value = toDate;
    if (indexType == 0) {
      listFromDateDAYCP([
        fromDay.value.subtract(Duration(days: 1)),
        fromDay.value.subtract(Duration(days: 6)),
        fromDay.value.subtract(Duration(days: 365)),
      ]);
      listToDateDAYCP([
        toDay.value.subtract(Duration(days: 1)),
        toDay.value.subtract(Duration(days: 6)),
        toDay.value.subtract(Duration(days: 365)),
      ]);
    }
    if (indexType == 1) {
      listFromDateWEEKCP([
        fromDay.value.subtract(Duration(days: 7)),
        fromDay.value.subtract(Duration(days: 31)),
      ]);
      listToDateWEEKCP([
        toDay.value.subtract(Duration(days: 7)),
        toDay.value.subtract(Duration(days: 31)),
      ]);
    }
    if (indexType == 2) {
      listFromDateMONTHCP([
        fromDay.value.subtract(Duration(days: 31)),
        fromDay.value.subtract(Duration(days: 365)),
      ]);
      listToDateMONTHCP([
        toDay.value.subtract(Duration(days: 31)),
        toDay.value.subtract(Duration(days: 365)),
      ]);
    }
    if (indexType == 3) {
      listFromDateYEARCP([
        fromDay.value.subtract(Duration(days: 365)),
      ]);
      listToDateYEARCP([
        toDay.value.subtract(Duration(days: 365)),
      ]);
    }
  }

  void chooseDateCP(
    DateTime fromDate,
    DateTime toDate,
  ) {
    checkSelectedCP = true;
    fromDayCP.value = fromDate;
    toDayCP.value = toDate;
  }

  void onOkChooseTime(DateTime startDate, DateTime endDate) {
    checkSelected = true;
    fromDay.value = startDate;
    toDay.value = endDate;
    fromDateOption.value = startDate;
    toDateOption.value = endDate;
    Get.back();
  }

  void onOkChooseTimeCP(DateTime startDate, DateTime endDate) {
    checkSelectedCP = true;
    fromDayCP.value = startDate;
    toDayCP.value = endDate;
    fromDateOptionCP.value = startDate;
    toDateOptionCP.value = endDate;
    Get.back();
  }
}
