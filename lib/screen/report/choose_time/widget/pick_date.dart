import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class PickDate extends StatelessWidget {
  final String text;
  final DateTime fromDate;
  final DateTime toDay;
  final bool isChoose;
  final Function onReturn;

  PickDate(
      {this.text,
      this.fromDate,
      this.toDay,
      this.isChoose = false,
      this.onReturn});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InkWell(
          onTap: () {
            onReturn(fromDate, toDay);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                toDay == fromDate
                    ? Text("$text ${SahaDateUtils().getDDMMYY(fromDate)}")
                    : Text(
                        "$text ${SahaDateUtils().getDDMM(fromDate)} đến ${SahaDateUtils().getDDMM(toDay)}"),
                Spacer(),
                isChoose
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
