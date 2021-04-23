import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/const/constant.dart';

class OrderStep extends PreferredSize {
  final Widget child;
  final double height;
  final int step;

  OrderStep({this.step, this.child, this.height = 150});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        height: 130,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      stepCircle(context, step == 1, 1, "Thông tin"),
                      space(),
                      stepCircle(context, step == 2, 2, "Thanh toán"),
                      space(),
                      stepCircle(context, step == 3, 3, "Xác nhận"),
                    ],
                  )
                ],
              ),
              Container()
            ],
          ),
        ));
  }

  Widget space() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: 40,
        height: 5,
        color: Colors.black12,
      ),
    );
  }

  Widget stepCircle(
      BuildContext context, bool currentPosition, int step, String name) {
    return Column(
      children: <Widget>[
        CircleAvatar(
            backgroundColor: currentPosition
                ? Theme.of(context).primaryTextTheme.headline6.color
                : Theme.of(context).primaryTextTheme.headline1.color,
            radius: 20,
            child: Text(
              "$step",
              style: TextStyle(fontWeight: FontWeight.w800),
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
              color: Theme.of(context).primaryTextTheme.headline6.color),
        )
      ],
    );
  }
}
