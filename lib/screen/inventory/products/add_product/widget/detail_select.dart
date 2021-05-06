import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/dropdown_string.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';

import 'detail_select_controller.dart';

class DetailSelect extends StatefulWidget {

  final Function onData;

  const DetailSelect({Key key, this.onData}) : super(key: key);

  @override
  _DetailSelectState createState() => _DetailSelectState();
}

class _DetailSelectState extends State<DetailSelect> {
  final DetailSelectController detailSelectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var valid = detailSelectController.checkValidParam();
        if(valid) {
          widget.onData(detailSelectController.getFinalDetail());
        }
        return detailSelectController.checkValidParam();
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
                    children: detailSelectController.listDetail
                        .toList()
                        .map((e) => buildDetail(e))
                        .toList(),
                  ),
                  MaterialButton(
                    onPressed: () {
                      detailSelectController.addDetail(null);
                    },
                    padding: EdgeInsets.all(0),
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: SahaPrimaryColor,
                        radius: Radius.circular(8),
                        strokeWidth: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add),
                              Text("Thêm thuộc tính")
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetail(Details details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  CustomDropDownString(
                      value: !detailSelectController.listSuggestion
                              .contains(details.name)
                          ? detailSelectController.listSuggestion.last
                          : details.name,
                      hint: "",
                      errorText: "",
                      onChanged: (name) {
                        details.name = name;
                        detailSelectController.refresh();
                      },
                      items: detailSelectController
                          .getListStringBuild(details)
                          .map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList()),
                  !detailSelectController.listSuggestion
                          .sublist(0,
                              detailSelectController.listSuggestion.length - 1)
                          .contains(details.name)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height: 40,
                            child: SahaTextField(
                              hintText: details.name ?? "Tên phân loại",
                              onSubmitted: (text) {
                                detailSelectController.editNameDetail(
                                    detailSelectController.listDetail
                                        .indexOf(details),
                                    text);
                              },
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  children: buildListAttributes(
                    list: details.attributes,
                    onRemove: (attribute) {
                      detailSelectController.removeAttribute(
                          detailSelectController.listDetail.indexOf(details),
                          attribute);
                      detailSelectController.refresh();
                    },
                    onAdd: () {
                      inputDialog().then((value) {
                        detailSelectController.addAttribute(
                            detailSelectController.listDetail.indexOf(details),
                            value);

                        detailSelectController.refresh();
                      });
                    },
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onTap: () {
                      detailSelectController.removeDetail(
                          detailSelectController.listDetail.indexOf(details));
                    })
              ],
            )
          ],
        ),
        SizedBox(
          height: 7,
        ),
        SahaDivide()
      ],
    );
  }

  List<Widget> buildListAttributes(
      {List<Attributes> list, Function onRemove, Function onAdd}) {
    var rtList = list
        .map((e) => buildItemAttribute(attribute: e, onRemove: onRemove))
        .toList();
    rtList.add(buildItemAttribute(onAdd: onAdd, isAdd: true));
    return rtList;
  }

  Widget buildItemAttribute(
      {Attributes attribute,
      Function onRemove,
      Function onAdd,
      bool isAdd = false}) {
    return InkWell(
      onTap: isAdd ? onAdd : null,
      child: Container(
        margin: EdgeInsets.only(right: 8, top: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: SahaPrimaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isAdd ? "Thêm" : attribute.name ?? ""),
            InkWell(
                child: Icon(
                  isAdd ? Icons.add : Icons.clear,
                  size: 15,
                ),
                onTap: () {
                  isAdd ? onAdd() : onRemove(attribute);
                })
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

  Future inputDialog() async {
    String teamName = '';
    return showDialog(
      context: Get.context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tên'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
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
