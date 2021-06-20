import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/screen/report/widget/item_report_order.dart';

class ReportOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
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
                      color: Theme.of(context).primaryColor, fontSize: 16),
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
                      color: Theme.of(context).primaryColor, fontSize: 16),
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
    );
  }
}
