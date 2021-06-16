import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/dropdown_string.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';

import 'distribute_select_controller.dart';

class DistributeSelect extends StatefulWidget {
  final Function onData;

  const DistributeSelect({Key key, this.onData}) : super(key: key);

  @override
  _DistributeSelectState createState() => _DistributeSelectState();
}

class _DistributeSelectState extends State<DistributeSelect> {
  final DistributeSelectController distributeSelectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var valid = distributeSelectController.checkValidParam();
        if (valid) {
          widget.onData(distributeSelectController.getFinalDistribute());
        }
        return distributeSelectController.checkValidParam();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Phân loại sản phẩm",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: distributeSelectController.listDistribute
                        .toList()
                        .map((e) => buildDistribute(e))
                        .toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        inputDialog().then((value) {
                          if (value != null && value.length > 0) {
                            distributeSelectController.addDistribute(value);

                            distributeSelectController.refresh();
                          }
                        });
                      },
                      padding: EdgeInsets.all(0),
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: SahaPrimaryColor,
                          radius: Radius.circular(4),
                          strokeWidth: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add),
                                Text("Thêm phân loại")
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDistribute(DistributesRequest distributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                inputDialog(initValue: distributes.name).then((value) {
                  if (value != null && value.length > 0) {
                    distributeSelectController.editNameDistribute(
                        distributeSelectController.listDistribute
                            .indexOf(distributes),
                        value);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  distributes?.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Ảnh minh họa",
                  style: TextStyle(color: Colors.grey, fontSize: 9),
                ),
                SizedBox(
                  child: Transform.scale(
                    scale: 0.5,
                    child: new CupertinoSwitch(
                      value: distributes.boolHasImage,
                      onChanged: (bool value1) {
                        distributeSelectController.toggleHasImage(
                            distributeSelectController.listDistribute
                                .indexOf(distributes));
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    distributeSelectController.removeDistribute(
                        distributeSelectController.listDistribute
                            .indexOf(distributes));
                  },
                  child: Text(
                    "Xóa",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 9),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildListDistributes(
                      distribute: distributes,
                      list: distributes.elementDistributes,
                      onRemove: (distribute) {
                        distributeSelectController.removeElementDistribute(
                            distributeSelectController.listDistribute
                                .indexOf(distributes),
                            distribute);
                        distributeSelectController.refresh();
                      },
                      onAdd: () {
                        inputDialog(isElementDistribute: true).then((value) {
                          if (value != null && value.length != 0) {
                            distributeSelectController.addElementDistribute(
                                distributeSelectController.listDistribute
                                    .indexOf(distributes),
                                value);
                          }

                          distributeSelectController.refresh();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        SahaDivide()
      ],
    );
  }

  List<Widget> buildListDistributes(
      {List<ElementDistributesRequest> list,
      Function onRemove,
      DistributesRequest distribute,
      Function onAdd}) {
    var rtList = list
        .map((e) => buildItemDistribute(
            distribute: distribute, elementDistribute: e, onRemove: onRemove))
        .toList();
    rtList.add(
        buildItemDistribute(onAdd: onAdd, isAdd: true, distribute: distribute));
    return rtList;
  }

  Widget buildItemDistribute(
      {ElementDistributesRequest elementDistribute,
      Function onRemove,
      DistributesRequest distribute,
      Function onAdd,
      bool isAdd = false}) {
    return InkWell(
      onTap: isAdd ? onAdd : null,
      child: Container(
        margin: EdgeInsets.only(right: 8, top: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: SahaPrimaryColor),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            !isAdd &&
                    distribute.boolHasImage != null &&
                    distribute.boolHasImage == true
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: SahaPrimaryColor,
                        radius: Radius.circular(4),
                        strokeWidth: 1,
                        child: InkWell(
                          onTap: () {
                            distributeSelectController.chooseImage(
                                distribute, elementDistribute);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            child: elementDistribute.imageUrl != null
                                ? CachedNetworkImage(
                              fit: BoxFit. cover,
                                    imageUrl: elementDistribute?.imageUrl,
                                    placeholder: (context, url) =>
                                        Center(child: SahaLoadingWidget()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colors.grey,
                                    )),
                          ),
                        )),
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isAdd ? "Thêm" : elementDistribute.name ?? ""),
                  InkWell(
                      child: Icon(
                        isAdd ? Icons.add : Icons.clear,
                        size: 15,
                      ),
                      onTap: () {
                        isAdd ? onAdd() : onRemove(elementDistribute);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    // setState(() {
    //   _selectedTest = selectedTest;
    // });
  }

  Future inputDialog(
      {bool isElementDistribute = false, String initValue}) async {
    String teamName = '';
    return showDialog(
      context: Get.context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isElementDistribute ? 'Tên thuộc tính' : "Tên phân loại"),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextFormField(
                initialValue: initValue ?? "",
                autofocus: true,
                decoration: new InputDecoration(),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }
}
