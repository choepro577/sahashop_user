import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/screen/login/reset_password/reset_password_controller.dart';
import 'package:sahashop_user/app_user/utils/keyboard.dart';
import 'package:sahashop_user/app_user/utils/phone_number.dart';

import 'change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ChangePasswordController changePasswordController =
      new ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay đổi mật khẩu"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SahaTextField(
              controller: changePasswordController.textEditingControllerOldPass,
              onChanged: (value) {},
              autoFocus: true,
              validator: (value) {

                return null;
              },
              textInputType: TextInputType.emailAddress,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu cũ",
              hintText: "Mời nhập mật khẩu cũ",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),

            SahaTextField(
              controller: changePasswordController.textEditingControllerNewPass,
              onChanged: (value) {},
              autoFocus: true,
              validator: (value) {
                if (value!.length < 6) {
                  return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                }
                return null;
              },
              textInputType: TextInputType.emailAddress,
              obscureText: true,
              withAsterisk: true,
              labelText: "Mật khẩu mới",
              hintText: "Mời nhập mật khẩu mới",
            ),

            SahaButtonSizeChild(
                width: 200,
                text: "Thay đổi",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    changePasswordController.onChange();
                  }
                }),
            Spacer(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
