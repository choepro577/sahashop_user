import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';

import 'home_buttons_style_1/home_button_style_1.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({Key? key, this.homeButton, this.onTap})
      : super(key: key);

  final HomeButton? homeButton;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return HomeButtonStyle1Widget(
      homeButton: homeButton,
      onTap: onTap,
    );
  }
}
