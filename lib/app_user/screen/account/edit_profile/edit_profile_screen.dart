import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/app_user/model/profile_user.dart';
import 'package:sahashop_user/app_user/screen/account/edit_profile/widget/select_avatar_image.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';
import 'package:sahashop_user/app_user/utils/keyboard.dart';

import 'edit_profile_controller.dart';

class EditProfileUser extends StatelessWidget {
  final ProfileUser user;

  EditProfileUser({required this.user}) {
    textEditingControllerName.text = user.name ?? "";
    textEditingControllerPhone.text = user.phoneNumber ?? "";
    textEditingControllerEmail.text = user.email ?? "";
    editProfileController = EditProfileController(
        dateOfBirthInput: user.dateOfBirth, linkAvatarInput: user.avatarImage);
  }

  TextEditingController textEditingControllerName = new TextEditingController();
  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();

  late EditProfileController editProfileController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa Shop"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SelectAvataImage(
                  linkLogo: editProfileController.linkAvatar.value,
                  onChange: (link) {
                    editProfileController.linkAvatar.value = link;
                  },
                ),
              ),
              SahaTextField(
                controller: textEditingControllerName,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.length <= 0) {
                    return 'Chưa nhập Họ và tên';
                  }
                  return null;
                },
                autoFocus: false,
                textInputType: TextInputType.name,
                obscureText: false,
                labelText: "Họ và tên",
                hintText: "Mời nhập Họ và tên",
                withAsterisk: true,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Giới tính"),
                    InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xff999999),
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CupertinoButton(
                                        child: Text('Thoát'),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 5.0,
                                        ),
                                      ),
                                      CupertinoButton(
                                        child: Text('Xong'),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 5.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  color: Color(0xfff7f7f7),
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (value) {
                                      editProfileController
                                          .onChangeSexPicker(value);
                                    },
                                    children: const [
                                      Text('Khác'),
                                      Text('Nam'),
                                      Text('Nữ'),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => Text(
                                "${editProfileController.sex.value} ",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/icons/right_arrow.svg",
                              color: Colors.black,
                              height: 10,
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Ngày sinh: ",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    Spacer(),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime(2021, 1, 1),
                              theme: DatePickerTheme(
                                  headerColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  itemStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16)), onConfirm: (date) {
                            editProfileController.dateOfBirth.value = date;
                          },
                              currentTime:
                                  editProfileController.dateOfBirth.value,
                              locale: LocaleType.vi);
                        },
                        child: Text(
                          '${SahaDateUtils().getDDMMYY(editProfileController.dateOfBirth.value)}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                editProfileController.updateProfile(
                  name: textEditingControllerName.text,
                );
              }
            },
            child: Container(
              width: Get.width - 50,
              height: 45,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Theme.of(Get.context!).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "Cập nhật",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
