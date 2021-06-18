import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/screen/report/choose_time/choose_time_screen.dart';
import 'package:sahashop_user/screen/report/report_controller.dart';
import 'package:sahashop_user/screen/report/widget/item_report_order.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ReportScreen extends StatelessWidget {
  ReportController reportController;

  @override
  Widget build(BuildContext context) {
    reportController = ReportController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tổng quan"),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.settings_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 4,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: () {
              Get.to(() => ChooseTimeScreen(
                    callback: (DateTime fromDate, DateTime toDay) {
                      print(fromDate);
                      print(toDay);
                      reportController.fromDay.value = fromDate;
                      reportController.toDay.value = toDay ?? DateTime.now();
                    },
                  ));
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => reportController.fromDay.value !=
                          reportController.toDay.value
                      ? Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Từ: ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                                "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
                            Text(
                              "Đến: ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                                "${SahaDateUtils().getDDMMYY(reportController.toDay.value)}"),
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
                      : reportController.fromDay.value.day == DateTime.now().day
                          ? Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Hôm nay: ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                    "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
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
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Hôm qua: ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                    "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
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
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/money.svg",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Doanh thu:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SahaMoneyText(
                        price: 9999999999,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 4,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        child: SvgPicture.asset(
                          "assets/icons/check_list.svg",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Hoá đơn:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                ItemReportOrder(
                  text: "Doanh số: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Đơn đã cọc: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Chưa thanh toán: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Chờ xử lí: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Đang giao hàng: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Đã hoàn thành: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Khách huỷ: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Shop huỷ: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Chờ trả hàng: ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
                ItemReportOrder(
                  text: "Đã hoàn tiền : ",
                  totalOrder: 0,
                  totalPrice: 2000000,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
