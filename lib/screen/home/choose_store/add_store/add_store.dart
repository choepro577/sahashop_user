import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/data/remote/response/store/type_store_respones.dart';
import 'package:sahashop_user/utils/keyboard.dart';
import 'package:sahashop_user/screen/home/home_screen.dart';
import 'package:sahashop_user/screen/sign_up/signUpScreen_controller.dart';

import 'add_store_controller.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  TextEditingController textEditingControllerNameShop =
      new TextEditingController();
  TextEditingController textEditingControllerAddress =
      new TextEditingController();
  TextEditingController textEditingControllerStoreCode =
      new TextEditingController();

  AddStoreController addStoreController = AddStoreController();

  final _formKey = GlobalKey<FormState>();

  String _chosenValue;
  List<DataTypeShop> listTypeShop;
  List<String> nameTypeShop = [];
  Map<String, String> chooseDropDownValue;
  // ignore: cancel_subscriptions
  StreamSubscription sub;
  final signUpController = Get.put(SignUpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addStoreController.getAllShopType();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sub ??= addStoreController.stateCreate.listen((state) {
      if (state != "success") {
        SahaDialogApp.showDialogError(context: context, errorMess: state);
        EasyLoading.dismiss();
      }

      if (state == "success") {
        Navigator.pop(context, "added");
        EasyLoading.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Th??m c???a h??ng",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "Th??ng tin c???a h??ng",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Xin qu?? kh??ch nh???p th??ng tin c???a h??ng \n????? kh???i t???o",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SahaTextField(
                controller: textEditingControllerNameShop,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 6) {
                    return 'T??n c???a h??ng ch???a 6 k?? t??? tr??? l??n';
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                obscureText: false,
                labelText: "T??n c???a h??ng",
                hintText: "Nh???p t??n c???a h??ng",
                icon: Icon(Icons.lock),
              ),
              SahaTextField(
                controller: textEditingControllerAddress,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 6) {
                    return 'm???t kh???u ch???a h??n 6 k?? t???';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "?????a ch??? c???a h??ng",
                hintText: "Nh???p ?????a ch??? c???a h??ng",
                icon: Icon(Icons.lock),
              ),
              SahaTextField(
                controller: textEditingControllerStoreCode,
                onChanged: (value) {},
                validator: (value) {
                  if (value.length < 2) {
                    return '?????a ch??? online ch???a 2 k?? t??? tr??? l??n';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                suffix: "sahashop.net",
                labelText: "?????a ch??? c???a h??ng Online",
                hintText: "Nh???p ?????a ch??? c???a h??ng Online",
                icon: Icon(Icons.lock),
              ),
              GetX<AddStoreController>(
                builder: (_) => DropdownButton<Map<String, String>>(
                  focusColor: Colors.white,
                  value: chooseDropDownValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: addStoreController.mapTypeShop
                      .map<DropdownMenuItem<Map<String, String>>>(
                          (Map<String, String> value) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: value,
                      child: Text(
                        "${value.values.first}",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Ch???n lo???i c???a h??ng kinh doanh",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (Map<String, String> value) {
                    setState(() {
                      chooseDropDownValue = value;
                      _chosenValue = value.keys.first;
                    });
                  },
                ),
              ),
              TextButton(
                // signUpController.shopPhones.toString()
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    addStoreController.createShop(
                        textEditingControllerNameShop.text,
                        textEditingControllerAddress.text,
                        _chosenValue,
                        textEditingControllerStoreCode.text);
                    EasyLoading.show();
                  }
                },
                style: ButtonStyle(),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
