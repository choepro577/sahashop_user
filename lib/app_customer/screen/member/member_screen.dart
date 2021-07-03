import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/text/text_money.dart';

class MemberScreen extends StatelessWidget {
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
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Color(0xffe6b92f))),
                          child: Center(
                            child: Text(
                              "5000 Poin",
                              style: TextStyle(
                                  color: Color(0xffe6b92f),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
                        Text(
                          "Để thăng hạng Bạc",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
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
                    child: Column(
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
                                price: 100000,
                                sizeText: 13,
                                sizeVND: 12,
                                color: Colors.red,
                              ),
                              Text(" /"),
                              SahaMoneyText(
                                price: 1000000,
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
                                price: 1000000,
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
                svgPath: "assets/icons/unlock.svg",
                title: "Voucher hấp dẫn",
                description: "Liên hệ shop nhận ưu đãi"),
            boxItem(
                svgPath: "assets/icons/unlock.svg",
                title: "Sinh nhật đổi quà",
                description: "Liên hệ shop nhận ưu đãi"),
          ],
        ),
      ),
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
