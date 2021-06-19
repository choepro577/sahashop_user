import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/report/report_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/chart.dart';
import 'package:sahashop_user/screen/report/option_report/report_order.dart';

import 'option_report/chart_business.dart';

class ReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var listChart = RxList<Chart>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var listChooseChartType = RxList<bool>([true, false]);
  var reportPrimeTime = DataPrimeTime().obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:"];
  List<bool> listChooseOption = [true, false];

  List<Widget> listOptionWidget = [
    ReportOrder(),
    BusinessChart(),
  ];

  ReportController() {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
    getReport();
  }

  void changeChooseOption(int index) {
    listChooseOption = [false, false];
    listChooseOption[index] = true;
    print(listChooseOption);
  }

  void changeChooseChartType(int index) {
    listChooseChartType([false, false]);
    listChooseChartType[index] = true;
    listChooseChartType.refresh();
    if (listChooseChartType[1] == true) {
      isTotalChart.value = false;
    } else {
      isTotalChart.value = true;
    }
  }

  void setIndexTab(int index) {
    indexOption.value = index;
  }

  Future<void> getReport() async {
    try {
      var res = await RepositoryManager.reportRepository.getReport(
          fromDay.value.toIso8601String(),
          toDay.value.toIso8601String(),
          "",
          "");
      listChart(res.data.dataPrimeTime.charts);
      reportPrimeTime.value = res.data.dataPrimeTime;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
