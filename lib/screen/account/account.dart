import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/address_screen/all_address_customer/all_address_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/favorites/favorites.dart';
import 'package:sahashop_user/components/app_customer/screen/profile_screen/fanpage/fanpage_screen.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/utils/user_info.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
          appBar: SahaAppBar(
            titleText: "Tài khoản",
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn muốn đăng xuất",
                        onOK: () {
                          UserInfo().logout();
                        });
                  })
            ],
          ),
          body: Container()),
    );
  }
}
