import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/screen/report/choose_time/choose_time_controller.dart';
import 'package:sahashop_user/screen/report/choose_time/widget/pick_date.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ChooseTimeScreen extends StatefulWidget {
  final Function callback;

  ChooseTimeScreen({this.callback});

  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  ChooseTimeController chooseTimeController = ChooseTimeController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 5, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            children: [
              Text('Thời gian'),
              Spacer(),
              InkWell(
                onTap: () {
                  widget.callback(chooseTimeController.fromDay.value,
                      chooseTimeController.toDay.value);
                },
                child: Text(
                  'Lưu',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: [
              Tab(text: "Ngày"),
              Tab(text: "Tuần"),
              Tab(text: "Tháng"),
              Tab(text: "Năm"),
              Tab(text: "Tuỳ chỉnh"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(5, (int index) {
            return SingleChildScrollView(
              child: index == 0
                  ? Obx(
                      () => Column(
                        children: [
                          ...List.generate(
                            2,
                            (index) => PickDate(
                              isChoose: chooseTimeController.fromDay.value ==
                                          chooseTimeController
                                              .listFromDateDAY[index] &&
                                      chooseTimeController.toDay.value ==
                                          chooseTimeController
                                              .listToDateDAY[index]
                                  ? true
                                  : false,
                              text:
                                  chooseTimeController.listTextChooseDAY[index],
                              fromDate:
                                  chooseTimeController.listFromDateDAY[index],
                              toDay: chooseTimeController.listToDateDAY[index],
                              onReturn: (fromDate, toDay) {
                                chooseTimeController.fromDay.value = fromDate;
                                chooseTimeController.toDay.value = toDay;
                              },
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text("So sánh với"),
                                Spacer(),
                                CustomSwitch(
                                  value: true,
                                  onChanged: (v) {},
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            height: 4,
                          ),
                          ...List.generate(
                            2,
                            (index) => PickDate(
                              isChoose: chooseTimeController.fromDay.value ==
                                          chooseTimeController
                                              .listFromDateDAY[index] &&
                                      chooseTimeController.toDay.value ==
                                          chooseTimeController
                                              .listToDateDAY[index]
                                  ? true
                                  : false,
                              text:
                                  chooseTimeController.listTextChooseDAY[index],
                              fromDate:
                                  chooseTimeController.listFromDateDAY[index],
                              toDay: chooseTimeController.listToDateDAY[index],
                              onReturn: (fromDate, toDay) {
                                chooseTimeController.fromDay.value = fromDate;
                                chooseTimeController.toDay.value = toDay;
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : index == 1
                      ? Obx(
                          () => Column(
                            children: [
                              ...List.generate(
                                3,
                                (index) => PickDate(
                                  isChoose: chooseTimeController
                                                  .fromDay.value ==
                                              chooseTimeController
                                                  .listFromDateWEEK[index] &&
                                          chooseTimeController.toDay.value ==
                                              chooseTimeController
                                                  .listToDateWEEK[index]
                                      ? true
                                      : false,
                                  text: chooseTimeController
                                      .listTextChooseWEEK[index],
                                  fromDate: chooseTimeController
                                      .listFromDateWEEK[index],
                                  toDay: chooseTimeController
                                      .listToDateWEEK[index],
                                  onReturn: (fromDate, toDay) {
                                    chooseTimeController.fromDay.value =
                                        fromDate;
                                    chooseTimeController.toDay.value = toDay;
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : index == 2
                          ? Obx(
                              () => Column(
                                children: [
                                  ...List.generate(
                                    3,
                                    (index) => PickDate(
                                      isChoose: chooseTimeController
                                                      .fromDay.value ==
                                                  chooseTimeController
                                                          .listFromDateMONTH[
                                                      index] &&
                                              chooseTimeController
                                                      .toDay.value ==
                                                  chooseTimeController
                                                      .listToDateMONTH[index]
                                          ? true
                                          : false,
                                      text: chooseTimeController
                                          .listTextChooseMONTH[index],
                                      fromDate: chooseTimeController
                                          .listFromDateMONTH[index],
                                      toDay: chooseTimeController
                                          .listToDateMONTH[index],
                                      onReturn: (fromDate, toDay) {
                                        chooseTimeController.fromDay.value =
                                            fromDate;
                                        chooseTimeController.toDay.value =
                                            toDay;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : index == 3
                              ? Obx(
                                  () => Column(
                                    children: [
                                      ...List.generate(
                                        2,
                                        (index) => PickDate(
                                          isChoose: chooseTimeController
                                                          .fromDay.value ==
                                                      chooseTimeController
                                                              .listFromDateYEAR[
                                                          index] &&
                                                  chooseTimeController
                                                          .toDay.value ==
                                                      chooseTimeController
                                                          .listToDateYEAR[index]
                                              ? true
                                              : false,
                                          text: chooseTimeController
                                              .listTextChooseYEAR[index],
                                          fromDate: chooseTimeController
                                              .listFromDateYEAR[index],
                                          toDay: chooseTimeController
                                              .listToDateYEAR[index],
                                          onReturn: (fromDate, toDay) {
                                            chooseTimeController.fromDay.value =
                                                fromDate;
                                            chooseTimeController.toDay.value =
                                                toDay;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : index == 4
                                  ? Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            chooseTimeController
                                                .chooseRangeTime(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Obx(
                                                  () => Text(
                                                      "Ngày bắt đầu và kết thúc: ${SahaDateUtils().getDDMM(chooseTimeController.fromDay.value)} đến ${SahaDateUtils().getDDMM(chooseTimeController.toDay.value)}"),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.check,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                      ],
                                    )
                                  : Container(),
            );
          }),
        ),
      ),
    );
  }
}
