import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../app_customer/screen_default/data_app_controller.dart';
import 'home_buttons_style_1/home_button_style_1.dart';

class ListHomeButtonWidget extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();


  var WIDTH_BUTTON = 80;

  @override
  Widget build(BuildContext context) {

    var listButtons = dataAppCustomerController.homeData!.buttons?.list;
    return listButtons == null || listButtons.length == 0 ? Container(): new StaggeredGridView.countBuilder(
      shrinkWrap: true,
      primary: false,
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      itemBuilder: (context, pos) {
        return HomeButtonStyle1Widget(
          homeButton: listButtons[pos],
        );
      },
      itemCount: listButtons.length,
      crossAxisCount: (MediaQuery.of(context).size.width/WIDTH_BUTTON).floor(),
      mainAxisSpacing: 4,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
