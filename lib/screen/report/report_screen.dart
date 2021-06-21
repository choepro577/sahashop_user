import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/screen/report/choose_time/choose_time_screen.dart';
import 'package:sahashop_user/screen/report/report_controller.dart';
import 'package:sahashop_user/screen/report/widget/show_choose_option.dart';
import 'package:sahashop_user/utils/date_utils.dart';

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
  ReportController? reportController;

  @override
  Widget build(BuildContext context) {
    reportController = Get.put(ReportController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Tổng quan"),
        actions: [
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.settings_outlined),
              onPressed: () {
                print(reportController!.listChooseOption);
                ShowChooseOrderOption.showChoose(
                    onReturn: (index) {
                      reportController!.indexOption.value = index;
                      reportController!.changeChooseOption(index);
                      Get.back();
                    },
                    listChooseOption: reportController!.listChooseOption);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 4,
              color: Colors.grey[200],
            ),
            InkWell(
              onTap: () {
                Get.to(() => ChooseTimeScreen(
                          isCompare: reportController!.isCompare.value,
                          callback: (DateTime fromDate,
                              DateTime toDay,
                              DateTime fromDateCP,
                              DateTime toDayCP,
                              bool isCompare) {
                            reportController!.fromDay.value = fromDate;
                            reportController!.toDay.value = toDay;
                            reportController!.fromDayCP.value = fromDateCP;
                            reportController!.toDayCP.value = toDayCP;
                            reportController!.isCompare.value = isCompare;
                          },
                        ))!
                    .then((value) => reportController!.getReport());
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => reportController!.fromDay.value !=
                            reportController!.toDay.value
                        ? Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Theme.of(context).primaryColor,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Từ: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                          "${SahaDateUtils().getDDMMYY(reportController!.fromDay.value)} "),
                                      Text(
                                        "Đến: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                          "${SahaDateUtils().getDDMMYY(reportController!.toDay.value)}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  reportController!.isCompare.value
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Vs: ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Text(
                                                "${SahaDateUtils().getDDMMYY(reportController!.fromDayCP.value)} "),
                                            Text(
                                              "Đến: ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Text(
                                                "${SahaDateUtils().getDDMMYY(reportController!.toDayCP.value)}"),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 21,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          )
                        : reportController!.fromDay.value.day ==
                                DateTime.now().day
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Hôm nay: ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          Text(
                                              "${SahaDateUtils().getDDMMYY(reportController!.fromDay.value)} "),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      reportController!.isCompare.value
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Vs: ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Text(
                                                    "${SahaDateUtils().getDDMMYY(reportController!.fromDayCP.value)} "),
                                                reportController!.fromDayCP
                                                            .value.day !=
                                                        reportController!
                                                            .toDayCP.value.day
                                                    ? Text(
                                                        "Đến: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      )
                                                    : Container(),
                                                reportController!.fromDayCP
                                                            .value.day !=
                                                        reportController!
                                                            .toDayCP.value.day
                                                    ? Text(
                                                        "${SahaDateUtils().getDDMMYY(reportController!.toDayCP.value)}")
                                                    : Container(),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 21,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Hôm qua: ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          Text(
                                              "${SahaDateUtils().getDDMMYY(reportController!.fromDay.value)} "),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      reportController!.isCompare.value
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Vs: ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Text(
                                                    "${SahaDateUtils().getDDMMYY(reportController!.fromDayCP.value)} "),
                                                Text(
                                                  "Đến: ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Text(
                                                    "${SahaDateUtils().getDDMMYY(reportController!.toDayCP.value)}"),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 21,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              ),
                  )),
            ),
            Container(
              height: 4,
              color: Colors.grey[200],
            ),
            Obx(() => reportController!
                .listOptionWidget[reportController!.indexOption.value]),
          ],
        ),
      ),
    );
  }
}
