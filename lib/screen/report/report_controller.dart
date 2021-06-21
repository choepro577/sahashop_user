import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/report/report_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/chart.dart';
import 'package:sahashop_user/screen/report/option_report/report_order.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'option_report/chart_business.dart';

class ReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var listChart = RxList<Chart?>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var listChooseChartType = RxList<bool>([true, false]);
  var reportPrimeTime = DataPrimeTime().obs;
  var reportCompareTime = DataCompareTime().obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:"];
  List<bool> listChooseOption = [true, false];

  var listLineChart = RxList<LineSeries<SalesData?, String>>();

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
        fromDayCP.value.toIso8601String(),
        toDayCP.value.toIso8601String(),
      );
      reportPrimeTime.value = res!.data!.dataPrimeTime!;
      reportCompareTime.value = res.data!.dataCompareTime ??
          DataCompareTime(totalOrderCount: 1000000);
      if (reportCompareTime.value.totalOrderCount != 1000000) {
        listLineChart([
          LineSeries<SalesData, String>(
            markerSettings: MarkerSettings(
                isVisible: true,
                height: 4,
                width: 4,
                shape: DataMarkerType.circle,
                borderWidth: 2,
                borderColor: Colors.black),
            dataSource: <SalesData>[
              ...List.generate(
                reportPrimeTime.value.charts!.length,
                (index) => SalesData(
                    '${fromDay.value.day == DateTime.now().day || fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportPrimeTime.value.charts![index]!.time!)}"}',
                    (isTotalChart.value
                        ? reportPrimeTime.value.charts![index]!.totalFinal
                        : reportPrimeTime
                            .value.charts![index]!.totalOrderCount)!),
              )
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            // Enable data label
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          LineSeries<SalesData, String>(
            markerSettings: MarkerSettings(
                isVisible: true,
                height: 4,
                width: 4,
                shape: DataMarkerType.circle,
                borderWidth: 2,
                borderColor: Colors.red),
            dataSource: <SalesData>[
              ...List.generate(
                reportCompareTime.value.charts!.length,
                (index) => SalesData(
                    '${fromDay.value.day == DateTime.now().day || fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportCompareTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportCompareTime.value.charts![index]!.time!)}"}',
                    (isTotalChart.value
                        ? reportCompareTime.value.charts![index]!.totalFinal
                        : reportCompareTime
                            .value.charts![index]!.totalOrderCount)!),
              )
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            // Enable data label
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ]);
      } else {
        listLineChart([
          LineSeries<SalesData, String>(
            markerSettings: MarkerSettings(
                isVisible: true,
                height: 4,
                width: 4,
                shape: DataMarkerType.circle,
                borderWidth: 2,
                borderColor: Colors.black),
            dataSource: <SalesData>[
              ...List.generate(
                reportPrimeTime.value.charts!.length,
                (index) => SalesData(
                    '${fromDay.value.day == DateTime.now().day || fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportPrimeTime.value.charts![index]!.time!)}"}',
                    (isTotalChart.value
                        ? reportPrimeTime.value.charts![index]!.totalFinal
                        : reportPrimeTime
                            .value.charts![index]!.totalOrderCount)!),
              )
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            // Enable data label
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ]);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
