import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/delete_address_customer_response.dart';
import 'package:sahashop_user/screen/report/choose_time/widget/pick_date.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ChooseTimeScreen extends StatefulWidget {
  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen>
    with TickerProviderStateMixin {
  TabController tabController;

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
          title: Text('Thời gian'),
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
                  ? Column(
                      children: [
                        PickDate(
                          text: "Hôm nay:",
                          fromDate: DateTime.now(),
                          onReturn: (fromDate, toDay) {
                            print(fromDate);
                            print(toDay);
                          },
                        ),
                        PickDate(
                          text: "Hôm qua:",
                          fromDate: SahaDateUtils().getYesterdayDATETIME(),
                          onReturn: (fromDate, toDay) {
                            print(fromDate);
                            print(toDay);
                          },
                        ),
                      ],
                    )
                  : index == 1
                      ? Column(
                          children: [
                            PickDate(
                              text: "Tuần này:",
                              fromDate:
                                  SahaDateUtils().getFirstDayOfWeekDATETIME(),
                              toDay: DateTime.now(),
                              onReturn: (fromDate, toDay) {
                                print(fromDate);
                                print(toDay);
                              },
                            ),
                            PickDate(
                              text: "7 ngày qua:",
                              fromDate:
                                  DateTime.now().subtract(Duration(days: 7)),
                              toDay: DateTime.now(),
                              onReturn: (fromDate, toDay) {
                                print(fromDate);
                                print(toDay);
                              },
                            ),
                            PickDate(
                              text: "Tuần trước:",
                              fromDate: SahaDateUtils()
                                  .getFirstDayOfLastWeekDATETIME(),
                              toDay:
                                  SahaDateUtils().getEndDayOfLastWeekDATETIME(),
                              onReturn: (fromDate, toDay) {
                                print(fromDate);
                                print(toDay);
                              },
                            ),
                          ],
                        )
                      : index == 2
                          ? Column(
                              children: [
                                PickDate(
                                  text: "Tháng này:",
                                  fromDate: SahaDateUtils()
                                      .getFirstDayOfMonthDATETIME(),
                                  toDay: DateTime.now(),
                                  onReturn: (fromDate, toDay) {
                                    print(fromDate);
                                    print(toDay);
                                  },
                                ),
                                PickDate(
                                  text: "30 ngày qua:",
                                  fromDate: DateTime.now()
                                      .subtract(Duration(days: 30)),
                                  toDay: DateTime.now(),
                                  onReturn: (fromDate, toDay) {
                                    print(fromDate);
                                    print(toDay);
                                  },
                                ),
                                PickDate(
                                  text: "Tháng trước:",
                                  fromDate: SahaDateUtils()
                                      .getFirstDayOfLastMonthDATETIME(),
                                  toDay: SahaDateUtils()
                                      .getEndDayOfLastMonthDATETIME(),
                                  onReturn: (fromDate, toDay) {
                                    print(fromDate);
                                    print(toDay);
                                  },
                                ),
                              ],
                            )
                          : index == 3
                              ? Column(
                                  children: [
                                    PickDate(
                                      text: "Năm này:",
                                      fromDate: SahaDateUtils()
                                          .getFirstDayOfThisYearDATETIME(),
                                      toDay: DateTime.now(),
                                      onReturn: (fromDate, toDay) {
                                        print(fromDate);
                                        print(toDay);
                                      },
                                    ),
                                    PickDate(
                                      text: "Năm trước:",
                                      fromDate: SahaDateUtils()
                                          .getFirstDayOfLastYearDATETIME(),
                                      toDay: SahaDateUtils()
                                          .getEndDayOfLastYearDATETIME(),
                                      onReturn: (fromDate, toDay) {
                                        print(fromDate);
                                        print(toDay);
                                      },
                                    ),
                                  ],
                                )
                              : index == 4
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "Tuần này: ${SahaDateUtils().getDDMMYY(DateTime.now())}"),
                                              Spacer(),
                                              Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "7 ngày qua: ${SahaDateUtils().getYesterday()}"),
                                              Spacer(),
                                              Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "Tuần trước: ${SahaDateUtils().getYesterday()}"),
                                              Spacer(),
                                              Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
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
