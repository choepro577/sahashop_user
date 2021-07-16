import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/model/profile_user.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

import 'account_controller.dart';
import 'change_password/change_password.dart';
import 'edit_profile/edit_profile_screen.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  AccountController accountController = AccountController();

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
          body: Container(
            child: Column(
              children: [
                Obx(() => itemUser(accountController.user.value)),
                Spacer(),
                TextButton(
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn muốn đăng xuất",
                        onOK: () {
                          UserInfo().logout();
                        });
                  },
                  child: Text(
                    "Đăng xuất",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[500]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(ChangePassword());
                  },
                  child: Text(
                    "Thay đổi mật khẩu",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }

  Widget itemUser(ProfileUser user) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 200,
                width: Get.width,
                child: Opacity(
                  opacity: 0.8,
                  child: CachedNetworkImage(
                    height: 70,
                    width: 70,
                    imageUrl: user.avatarImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SahaLoadingContainer(),
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(Get.context!).primaryColor)),
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: user.avatarImage ?? "",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SahaLoadingContainer(),
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    ),
                    borderRadius: BorderRadius.circular(3000),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Get.to(() => EditProfileUser(
                              user: user,
                            ))!
                        .then((value) => {accountController.getUser()});
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.edit_road_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Họ và Tên:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    '${user.name == null || user.name == "" ? "Chưa có tên" : user.name}'),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Giới tính:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    '${user.sex == 0 ? "Khác" : user.sex == 1 ? "Nam" : "Nữ"} '),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Ngày sinh:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    '${user.dateOfBirth == null ? "Chưa có ngày sinh" : SahaDateUtils().getDDMMYY(user.dateOfBirth!)}'),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Số điện thoại:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  '${user.phoneNumber ?? "Chưa có user Code"}',
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Số cửa hàng:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    "${(user.createMaximumStore == null) ? "Chưa có Cửa hàng" : user.createMaximumStore}"),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    "${(user.email == null || user.email == "") ? "Chưa có Email" : user.email}"),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Ngày tạo:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                    '${SahaDateUtils().getDDMMYY(user.createdAt ?? DateTime.now())}'),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
