import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/model/voucher.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class DetailVoucherScreen extends StatelessWidget {
  final Voucher? voucher;

  DetailVoucherScreen({this.voucher});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết mã giảm giá"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.grey[500]!),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 80,
                              child: voucher!.voucherType == 1
                                  ? voucher!.discountType == 1
                                      ? Text(
                                          "Mã: ${voucher!.code} giảm ${voucher!.valueDiscount} %",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 4,
                                        )
                                      : Text(
                                          "Mã: ${voucher!.code} giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 4,
                                        )
                                  : voucher!.discountType == 1
                                      ? Text(
                                          "Mã: ${voucher!.code} giảm ${voucher!.valueDiscount} %",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 4,
                                        )
                                      : Text(
                                          "Mã: ${voucher!.code} giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 4,
                                        ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 5,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 20,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 35,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 50,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 65,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 80,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${voucher!.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                    ),
                                    voucher!.voucherType == 1
                                        ? Text(
                                            "Giảm giá cho các sản phẩm sau:",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                          )
                                        : Text(
                                            "Giảm giá cho toàn bộ các sản phẩm",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                          ),
                                    voucher!.voucherType == 1
                                        ? Text(
                                            "${voucher!.products![0].name}, vv...",
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                            maxLines: 1,
                                          )
                                        : Container(),
                                    Text(
                                      "HSD: ${SahaDateUtils().getDDMMYY(voucher!.endTime!)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ưu đãi",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  voucher!.voucherType == 1
                      ? voucher!.discountType == 1
                          ? Text(
                              "Giảm ${voucher!.valueDiscount} % cho các sản phẩm sau:",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                            )
                          : Text(
                              "Giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ cho các sản phẩm sau:",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                            )
                      : voucher!.discountType == 1
                          ? Text(
                              "Giảm ${voucher!.valueDiscount} % cho toàn bộ các sản phẩm",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                            )
                          : Text(
                              "Giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ cho toàn bộ các sản phẩm",
                              textAlign: TextAlign.center,
                              maxLines: 4,
                            ),
                  voucher!.voucherType == 1
                      ? Text(
                          "${voucher!.products![0].name}, vv...",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          maxLines: 1,
                        )
                      : Container(),
                  voucher!.setLimitValueDiscount == true
                      ? Text(
                          "Giới hạn giảm ${SahaStringUtils().convertToMoney(voucher!.maxValueDiscount)}đ.")
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Có hiệu lực:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${SahaDateUtils().getDDMMYY(voucher!.startTime!)} ${SahaDateUtils().getHHMM(voucher!.startTime!)} - ${SahaDateUtils().getDDMMYY(voucher!.endTime!)} ${SahaDateUtils().getHHMM(voucher!.endTime!)}",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Thanh toán:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Mọi hình thức thanh toán."),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Điều kiện sử dụng:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  voucher!.setLimitAmount == true
                      ? Text("Số lượng giới hạn: ${voucher!.amount}.")
                      : Container(),
                  voucher!.voucherType == 1
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Chỉ áp dụng cho các sản phẩm sau: "),
                              ...List.generate(
                                  voucher!.products!.length,
                                  (index) => Text(
                                      "${voucher!.products![index].name}."))
                            ],
                          ),
                        )
                      : Container(),
                  voucher!.setLimitTotal == true
                      ? Text(
                          "Giá trị tổng đơn hàng tối thiểu: ${SahaStringUtils().convertToMoney(voucher!.valueLimitTotal)}đ.")
                      : Container(),
                  Text(
                    "HSD: ${SahaDateUtils().getDDMMYY(voucher!.startTime!)} ${SahaDateUtils().getHHMM(voucher!.startTime!)} - ${SahaDateUtils().getDDMMYY(voucher!.endTime!)} ${SahaDateUtils().getHHMM(voucher!.endTime!)}.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
