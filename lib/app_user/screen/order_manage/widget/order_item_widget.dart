import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/string_utils.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  final Function? onTap;

  const OrderItemWidget({Key? key, required this.order, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                    imageUrl: order.lineItemsAtTime!.length == 0
                        ? ""
                        : "${order.infoCustomer!.avatarImage}",
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text("${order.infoCustomer!.name}"),
                Spacer(),
                Text(
                  "${order.orderStatusName}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: order.lineItemsAtTime!.length == 0
                        ? ""
                        : "${order.lineItemsAtTime![0].imageUrl}",
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${order.lineItemsAtTime![0].name}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                Text(
                                  " x ${order.lineItemsAtTime![0].quantity}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Text(
                                  "đ${SahaStringUtils().convertToMoney(order.lineItemsAtTime![0].beforePrice)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[600]),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "đ${SahaStringUtils().convertToMoney(order.lineItemsAtTime![0].afterDiscount)}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          order.lineItemsAtTime!.length > 1
              ? Container(
                  width: Get.width,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Xem thêm sản phẩm",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                )
              : Container(),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  "${order.lineItemsAtTime!.length} sản phẩm",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
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
                Row(
                  children: [
                    Text("Thành tiền: "),
                    Text(
                      "đ${SahaStringUtils().convertToMoney(order.totalFinal)}",
                      style: TextStyle(
                          color: SahaColorUtils().colorPrimaryTextWithWhiteBackground()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(),
                Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Text(
                      "Xem",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
            ),
            child: Row(
              children: [
                Text(
                  "${SahaDateUtils().getHHMM(order.updatedAt!) + " " + SahaDateUtils().getDDMMYY2(order.updatedAt!)}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Spacer(),
                Text(
                  "${order.orderCode}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: "${order.orderCode}"));
                    SahaAlert.showToastMiddle(
                      message: "Đã sao chép",
                      color: Colors.grey[600],
                    );
                  },
                  child: Text(
                    "Sao chép",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
