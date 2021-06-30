import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/app_user/screen/report/report_controller.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class BusinessChart extends StatefulWidget {
  @override
  _BusinessChartState createState() => _BusinessChartState();
}

class _BusinessChartState extends State<BusinessChart> {
  ReportController? reportController;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    reportController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var checkLandscape = context.isLandscape;
    return Column(
      children: [
        checkLandscape == true
            ? Container()
            : Container(
                height: 115,
                width: Get.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        reportController!.changeChooseChartType(index);
                      },
                      child: Obx(
                        () => Stack(
                          children: [
                            Container(
                              height: 85,
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              width: (Get.width - 40) / 2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: (reportController!
                                              .listChooseChartType[index]
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[500])!),
                                  borderRadius: BorderRadius.circular(2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  reportController!.isCompare.value
                                      ? index == 0
                                          ? Text(
                                              "${reportController!.listNameChartType[index]} ${reportController!.reportPrimeTime.value.totalFinal! != 0 ? reportController!.differenceTotalFinal.value > 0 ? ' tăng ${reportController!.percentTotalFinal.value.toInt()}%' : ' giảm ${reportController!.percentTotalFinal.value.toInt()}%' : ""}")
                                          : Text(
                                              "${reportController!.listNameChartType[index]} ${reportController!.reportPrimeTime.value.totalFinal! != 0 ? reportController!.differenceOrder.value > 0 ? ' tăng ${reportController!.percentOrder.value.toInt()}%' : ' giảm ${reportController!.percentOrder.value.toInt()}%' : ""}")
                                      : Text(
                                          "${reportController!.listNameChartType[index]}"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  index == 1
                                      ? Text(
                                          "${reportController!.reportPrimeTime.value.totalOrderCount!.toInt()}")
                                      : SahaMoneyText(
                                          price: reportController!
                                              .reportPrimeTime.value.totalFinal,
                                          fontWeight: FontWeight.w400,
                                          sizeVND: 14,
                                          sizeText: 15,
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  reportController!.isCompare.value
                                      ? index == 1
                                          ? Text(
                                              "${reportController!.differenceOrder.value > 0 ? '+ ${reportController!.differenceOrder.value.toInt().abs()}' : '- ${reportController!.differenceOrder.value.toInt().abs()}'}")
                                          : reportController!
                                                      .differenceTotalFinal
                                                      .value >
                                                  0
                                              ? Row(
                                                  children: [
                                                    Text("+ "),
                                                    SahaMoneyText(
                                                      price: reportController!
                                                          .differenceTotalFinal
                                                          .value,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      sizeVND: 14,
                                                      sizeText: 15,
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text("- "),
                                                    SahaMoneyText(
                                                      price: reportController!
                                                          .differenceTotalFinal
                                                          .value
                                                          .abs(),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      sizeVND: 14,
                                                      sizeText: 15,
                                                    ),
                                                  ],
                                                )
                                      : Container(),
                                ],
                              ),
                            ),
                            reportController!.listChooseChartType[index]
                                ? Positioned(
                                    height: 30,
                                    width: 30,
                                    top: 9,
                                    right: 9,
                                    child: SvgPicture.asset(
                                      "assets/icons/levels.svg",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Container(),
                            reportController!.listChooseChartType[index]
                                ? Positioned(
                                    height: 15,
                                    width: 15,
                                    top: 9,
                                    right: 9,
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
        Obx(
          () => Container(
            padding: const EdgeInsets.all(5.0),
            height: 500,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(
                  text:
                      '${reportController!.isCompare.value ? reportController!.isTotalChart.value ? "So sánh chênh lệch doanh thu" : "So sánh chênh lệch đơn" : reportController!.isTotalChart.value ? "Doanh thu" : "Đơn hàng"}'),
              // Enable legend
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              // Enable tooltip
              tooltipBehavior: _tooltipBehavior,
              series: reportController!.isCompare.value
                  ? <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                        legendItemText:
                            "${SahaDateUtils().getDDMM(reportController!.fromDayCP.value)} Đến ${SahaDateUtils().getDDMM(reportController!.toDayCP.value)}",
                        color: Colors.red,
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Colors.red),
                        dataSource: <SalesData>[
                          ...List.generate(
                            reportController!
                                .reportCompareTime.value.charts!.length,
                            (index) => SalesData(
                                '${reportController!.reportCompareTime.value.charts![index]!.time == null ? reportController!.listMonth[index] : reportController!.fromDay.value.day == DateTime.now().day || reportController!.fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportController!.reportCompareTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController!.reportCompareTime.value.charts![index]!.time!)}"}',
                                (reportController!.isTotalChart.value
                                    ? reportController!.reportCompareTime.value
                                        .charts![index]!.totalFinal
                                    : reportController!.reportCompareTime.value
                                        .charts![index]!.totalOrderCount)!),
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
                        color: Colors.blue,
                        legendItemText:
                            "${SahaDateUtils().getDDMM(reportController!.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportController!.toDay.value)}",
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Colors.blue),
                        dataSource: <SalesData>[
                          ...List.generate(
                            reportController!
                                .reportPrimeTime.value.charts!.length,
                            (index) => SalesData(
                                '${reportController!.reportPrimeTime.value.charts![index]!.time == null ? reportController!.listMonth[index] : reportController!.fromDay.value.day == DateTime.now().day || reportController!.fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportController!.reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController!.reportPrimeTime.value.charts![index]!.time!)}"}',
                                (reportController!.isTotalChart.value
                                    ? reportController!.reportPrimeTime.value
                                        .charts![index]!.totalFinal
                                    : reportController!.reportPrimeTime.value
                                        .charts![index]!.totalOrderCount)!),
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
                    ]
                  : <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                        legendItemText:
                            "${SahaDateUtils().getDDMM(reportController!.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportController!.toDay.value)}",
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Theme.of(context).primaryColor),
                        dataSource: <SalesData>[
                          ...List.generate(
                            reportController!
                                .reportPrimeTime.value.charts!.length,
                            (index) => SalesData(
                                '${reportController!.reportPrimeTime.value.charts![index]!.time == null ? reportController!.listMonth[index] : reportController!.fromDay.value.day == DateTime.now().day || reportController!.fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportController!.reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController!.reportPrimeTime.value.charts![index]!.time!)}"}',
                                (reportController!.isTotalChart.value
                                    ? reportController!.reportPrimeTime.value
                                        .charts![index]!.totalFinal
                                    : reportController!.reportPrimeTime.value
                                        .charts![index]!.totalOrderCount)!),
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
                    ],
            ),
          ),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
