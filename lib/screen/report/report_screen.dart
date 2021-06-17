import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/screen/report/choose_time/choose_time_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              Get.to(() => ChooseTimeScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text("${SahaDateUtils().getDDMMYY(DateTime.now())} "),
                  Text(
                    "Đến: ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text("${SahaDateUtils().getDDMMYY(DateTime.now())}"),
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
            ),
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text("Doanh số: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Đơn đã cọc: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Chưa thanh toán: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Chờ xử lí: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Đang giao hàng: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Đã hoàn thành: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Khách huỷ: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Shop huỷ: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Chờ trả hàng: "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
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
                      Text("Đã hoàn tiền : "),
                      Spacer(),
                      SahaMoneyText(
                        sizeText: 14,
                        sizeVND: 12,
                        price: 2000000,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
