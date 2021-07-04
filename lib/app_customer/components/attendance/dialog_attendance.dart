import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/app_user/model/roll_call.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

class DialogAttendance {
  static DialogAttendance _instance = new DialogAttendance.internal();

  DialogAttendance.internal();

  factory DialogAttendance() => _instance;

  static void showAttendanceDialog(
    BuildContext context,
    int? scoreToday,
    List<RollCall>? listRollCall,
  ) {
    var dateNow = DateTime.now();

    DataAppCustomerController dataAppCustomerController = Get.find();

    Widget itemAttendance(RollCall rollCall) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -5,
              left: -4,
              child: SvgPicture.asset(
                "assets/icons/sun.svg",
                height: 40,
                width: 40,
                color: dateNow.isAfter(rollCall.date!)
                    ? rollCall.checked! == true
                        ? null
                        : dateNow.day == rollCall.date!.day
                            ? Colors.red
                            : Colors.grey[400]!
                    : Colors.blue,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: dateNow.isAfter(rollCall.date!)
                          ? rollCall.checked! == true
                              ? Color(0xffe6b92f)
                              : Colors.grey[400]!
                          : Colors.blue,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${dateNow.isAfter(rollCall.date!) ? dateNow.day == rollCall.date!.day ? rollCall.scoreInDay : rollCall.score : rollCall.scoreInDay ?? 0}",
                      style: TextStyle(
                        fontSize: 13,
                        color: dateNow.isAfter(rollCall.date!)
                            ? rollCall.checked! == true
                                ? Color(0xffe6b92f)
                                : Colors.grey[400]!
                            : Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${SahaDateUtils().getDDMM(rollCall.date ?? DateTime.now())}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    }

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Row(
              children: [
                Text(
                  "Điểm danh hôm nay:",
                  style: TextStyle(color: Colors.blue),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.close,
                          color: Colors.blue,
                        )))
              ],
            ),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: Get.width * 0.95,
              height: 225,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          4, (index) => itemAttendance(listRollCall![index])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(3,
                          (index) => itemAttendance(listRollCall![index + 4])),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      dataAppCustomerController.checkIn();
                    },
                    child: Container(
                      width: Get.width / 2.5,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/star_around.svg",
                              height: 10,
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Nhận ${scoreToday ?? 15} poin",
                              style: TextStyle(color: Color(0xffe6b92f)),
                            ),
                            SizedBox(
                              width: 10,
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
            ),
          );
        });
  }
}
