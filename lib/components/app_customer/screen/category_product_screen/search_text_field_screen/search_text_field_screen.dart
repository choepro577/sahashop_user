import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/text_field/saha_text_field_search.dart';

import 'search_text_field_controller.dart';

class SearchTextFiledScreen extends StatelessWidget {
  final Function(String? text, int? categoryId)? onSubmit;

  SearchTextFiledController searchTextFiledController =
      SearchTextFiledController();

  SearchTextFiledScreen({Key? key, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SahaTextFieldSearch(
          onSubmitted: (va) {
            if (onSubmit != null) onSubmit!(va, null);
            searchTextFiledController.addSearchHistory(va);
            Get.back();
          },
          onClose: () {},
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => searchTextFiledController.histories.length == 0
                ? Container()
                : Column(
                    children: searchTextFiledController.histories
                        .map((element) => ListTile(
                              title: Text(element.text ?? ""),
                            ))
                        .toList(),
                  ),
          ),
          Expanded(child: Text("dtdf"))
        ],
      ),
    );
  }
}
