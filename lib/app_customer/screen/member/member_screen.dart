import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/attendance/dialog_attendance.dart';
import 'package:sahashop_user/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen/member/member_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/app_user/model/score_history_item.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

// ignore: must_be_immutable
class MemberScreen extends StatelessWidget {
  MemberController memberController = MemberController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Khách hàng thân thiết"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            var memberType = memberController.memberType.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star_around.svg",
                                  height: 10,
                                  width: 10,
                                  color: memberType == "Bạc"
                                      ? Colors.grey
                                      : memberType == "Vàng"
                                          ? Color(0xffe6b92f)
                                          : memberType == "Bạch kim"
                                              ? Colors.cyan
                                              : memberType == "Kim cương"
                                                  ? Colors.lightBlueAccent
                                                  : Colors.transparent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Thành viên $memberType",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: memberType == "Bạc"
                                          ? Colors.grey
                                          : memberType == "Vàng"
                                              ? Color(0xffe6b92f)
                                              : memberType == "Bạch kim"
                                                  ? Colors.cyan
                                                  : memberType == "Kim cương"
                                                      ? Colors.lightBlueAccent
                                                      : Colors.transparent,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/star_around.svg",
                                  height: 10,
                                  width: 10,
                                  color: memberType == "Bạc"
                                      ? Colors.grey
                                      : memberType == "Vàng"
                                          ? Color(0xffe6b92f)
                                          : memberType == "Bạch kim"
                                              ? Colors.cyan
                                              : memberType == "Kim cương"
                                                  ? Colors.lightBlueAccent
                                                  : Colors.transparent,
                                ),
                              ],
                            );
                          }),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                "assets/icons/wallet_color.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Điểm tích luỹ: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                DialogAttendance.showAttendanceDialog(
                                    context,
                                    memberController
                                        .dataAppCustomerController.scoreToday,
                                    memberController.dataAppCustomerController
                                        .listRollCall);
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffe6b92f)),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/star_around.svg",
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        " Điểm danh nào ! ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffe6b92f)),
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/star_around.svg",
                                        height: 10,
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Color(0xffe6b92f))),
                          child: Center(
                            child: Text(
                              "${memberController.dataAppCustomerController.badge.value.customerScore} Poin",
                              style: TextStyle(
                                  color: Color(0xffe6b92f),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        memberController.seeScoreHistory();
                      },
                      child: Text(
                        "Lịch sử tích điểm",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffe6b92f),
                        ),
                      ))
                ],
              ),
            ),
            Obx(
              () => AnimatedContainer(
                height: memberController.isScoreHistory.value
                    ? memberController.listScoreHistory.length * 55 >
                            Get.height / 2
                        ? Get.height / 2
                        : memberController.listScoreHistory.length * 55
                    : 0,
                width: Get.width,
                duration: Duration(milliseconds: 300),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                          memberController.listScoreHistory.length,
                          (index) => historyItem(
                              memberController.listScoreHistory[index]))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]!),
                              color: Colors.grey[200],
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            "assets/icons/unlock.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Text(
                            "Để thăng hạng ${memberController.memberTypeNext.value}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 115,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Chi tiêu",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(2)),
                                  height: 18,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      "Chưa đạt",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SahaMoneyText(
                                  price: memberController
                                      .dataAppCustomerController
                                      .badge
                                      .value
                                      .totalBoughtAmount,
                                  sizeText: 13,
                                  sizeVND: 12,
                                  color: Colors.red,
                                ),
                                Text(" / "),
                                SahaMoneyText(
                                  price: memberController.scoreTarget.value,
                                  sizeText: 13,
                                  sizeVND: 12,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Mua thêm "),
                                SahaMoneyText(
                                  price: memberController.scoreTarget.value -
                                      memberController.dataAppCustomerController
                                          .badge.value.totalBoughtAmount!,
                                  sizeText: 13,
                                  sizeVND: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                Text(" Để được nâng hạng")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            boxItem(
                svgPath: "assets/icons/coupon_color.svg",
                title: "Voucher hấp dẫn",
                description: "Liên hệ shop nhận ưu đãi"),
            boxItem(
                svgPath: "assets/icons/birthday-cake.svg",
                title: "Sinh nhật đổi quà",
                description: "Liên hệ shop nhận ưu đãi"),
            boxItem(
                svgPath: "assets/icons/free-delivery.svg",
                title: "Miễn phí vận chuyển",
                description: "Liên hệ shop nhận ưu đãi"),
            boxItem(
                svgPath: "assets/icons/gift_color.svg",
                title: "Giảm giá hoá đơn",
                description: "Liên hệ shop nhận ưu đãi"),
            boxItem(
                svgPath: "assets/icons/top.svg",
                title: "Thăng hạng đổi quà",
                description: "Liên hệ shop nhận ưu đãi"),
          ],
        ),
      ),
    );
  }

  Widget historyItem(ScoreHistoryItem scoreHistoryItem) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${scoreHistoryItem.content}"),
                  Text("Điểm nhận : ${scoreHistoryItem.score}"),
                ],
              ),
              Spacer(),
              Text(
                "${SahaDateUtils().getDDMMYY(DateTime.now())}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  Widget boxItem({
    String? svgPath,
    String? title,
    String? description,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    color: Colors.grey[200],
                    shape: BoxShape.circle),
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  svgPath!,
                  height: 20,
                  width: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    description!,
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
