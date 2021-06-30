import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import 'speed_edit_controller.dart';

class SpeedEdit extends StatefulWidget {

  final Product? product;

  const SpeedEdit({Key? key, this.product}) : super(key: key);
  @override
  _SpeedEditState createState() => _SpeedEditState();
}

class _SpeedEditState extends State<SpeedEdit> {
  late SpeedEditController speedEditController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    speedEditController  = new SpeedEditController(product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Sửa nhanh",
        ),
        body: Column(
          children: [
            Expanded(child: Column(children: [
              SahaTextFieldNoBorder(
                controller: speedEditController
                    .textEditingControllerPrice,
                onChanged: (value) {
                  speedEditController.productRequest.price =
                      double.tryParse(value!);
                },
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Không được để trống';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                labelText: "Giá",
                hintText: "Đặt",
              ),
              SahaDivide(),
              SahaTextFieldNoBorder(
                controller: speedEditController
                    .textEditingControllerQuantityInStock,
                onChanged: (value) {
                  speedEditController
                      .productRequest.quantityInStock =
                      int.tryParse(value!) ?? 0;
                },
                validator: (value) {},
                textInputType: TextInputType.number,
                labelText: "Số lượng trong kho",
                hintText: "Đặt",
                helperText:
                "Để trống khi bán không quan tâm số lượng",
              ),
            ],)),

            SahaButtonFullParent(
              text: "Cập nhật",
              onPressed: () {
                speedEditController.updateProduct();
              },
            )
          ],
        ),
      ),
    );
  }
}