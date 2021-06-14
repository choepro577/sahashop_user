import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/empty/empty_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/model/attributes.dart';

import 'attributes_controller.dart';


class AttributeScreen extends StatelessWidget {
  AttributeController attributeController = new AttributeController();

  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: "Tất cả thuộc tính",
        ),
        body: Obx(
              () => attributeController.loading.value
              ? SahaLoadingFullScreen()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    var list = attributeController.listAttribute?.toList().toList();
                    if (list == null || list.length == 0) {
                      return SahaEmptyWidget(
                        tile: "Không có danh mục nào",
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ItemAttributeWidget(
                            attribute: list[index],
                          );
                        });
                  }),
                ),
                SahaButtonFullParent(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Tên thuộc tính'),
                            content: TextField(
                              onChanged: (value) {

                              },
                              controller: textEditingController,
                              decoration: InputDecoration(hintText: "Nhập tên thuộc tính"),
                            ),
                          );
                        });
                  },
                  text: "Thêm thuộc tính mới",
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}

class ItemAttributeWidget extends StatelessWidget {
  final Attribute attribute;

  const ItemAttributeWidget({Key key, this.attribute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(attribute.name),
      ),
    );
  }
}
