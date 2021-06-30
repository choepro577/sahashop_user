import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

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
