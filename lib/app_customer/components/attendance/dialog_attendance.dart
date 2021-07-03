import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    Widget itemAttendance(RollCall rollCall) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: dateNow.day == rollCall.date!.day
                        ? Theme.of(Get.context!).primaryColor
                        : rollCall.checked == false
                            ? Colors.grey[400]!
                            : Colors.green),
              ),
              child: Center(
                child: Text(
                  "${dateNow.day == rollCall.date!.day ? scoreToday : rollCall.score ?? 0}",
                  style: TextStyle(fontSize: 13),
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
      );
    }

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Row(
              children: [
                Text("Điểm danh hôm nay:"),
                Spacer(),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: 30, width: 30, child: Icon(Icons.close)))
              ],
            ),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: Get.width * 0.95,
              height: 225,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Container(
                    width: Get.width / 2.5,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text("Nhận ${scoreToday ?? 15} poin"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
