import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';

import 'layout_sort_screen.dart';


class LayoutConfig extends StatefulWidget {
  @override
  _LayoutConfigState createState() => _LayoutConfigState();
}

class _LayoutConfigState extends State<LayoutConfig> {

  String? fontTitle;

  ConfigController controller = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    fontTitle = controller.configApp.fontFamily;
  }

  List<Widget> listLayout() {

    List<Widget> list = [];

    list.add(
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Get.to(LayoutSortChangeScreen())!.then((value) {
              controller.getAppTheme(refresh: true);
            });
          },
          child: Container(
            padding:
            EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/svg/change.svg",
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Tùy chỉnh"),
              ],
            ),
          ),
        ),
      ),

    );

    var i = 1;
    if (dataAppCustomerController.homeData!.listLayout != null) {
      for (var layout in dataAppCustomerController.homeData!.listLayout!) {
        if(layout.hide == false) {
          list.add(
              ListTile(
                title: Text(layout.title ?? ""),
                leading: CircleAvatar(
                  radius: 12,
                  child: Text("$i"),
                ),
              )
          );
          i++;
        }

      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: listLayout(),
    );
  }
}
