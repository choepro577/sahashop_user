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


import 'setup_info_shop_controller.dart';

class SetUpInfoShop extends StatefulWidget {
  @override
  _SetUpInfoShopState createState() => _SetUpInfoShopState();
}

class _SetUpInfoShopState extends State<SetUpInfoShop> {
  TextEditingController textEditingControllerNameShop = new TextEditingController();
  TextEditingController textEditingControllerAddress = new TextEditingController();

  SetUpInfoShopController setUpInfoShopController = SetUpInfoShopController();

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
    setUpInfoShopController.getAllShopType();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sub ??= setUpInfoShopController.stateCreate.listen((state) {
      if (state != "success") {
        SahaDialogApp.showDialogError(context: context,errorMess: state);
        EasyLoading.dismiss();
      }

      if (state == "success") {
        Get.offAll(HomeScreen());
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
          "Sign In",
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
                    return 'B???n ch??a nh???p s??? ??i???n tho???i';
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
              GetX<SetUpInfoShopController>(
                builder: (_) => DropdownButton<Map<String, String>>(
                  focusColor: Colors.white,
                  value: chooseDropDownValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: setUpInfoShopController.mapTypeShop
                      .map<DropdownMenuItem<Map<String, String>>>((Map<String, String> value) {
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
                    setUpInfoShopController.createShop(textEditingControllerNameShop.text,
                        textEditingControllerAddress.text,
                        _chosenValue,
                        textEditingControllerNameShop.text + signUpController.shopPhones.toString());
                    EasyLoading.show();
                  }
                },
                style: ButtonStyle(

                ),
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
