import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_store.dart';

import '../home_controller.dart';
import 'add_store/add_store.dart';
import 'choose_store_controller.dart';

class ChooseStoreScreen extends StatelessWidget {
  final ChooseStoreController chooseStoreController =
      new ChooseStoreController();

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Chọn cửa hàng",
      ),
      body: Obx(
        () => chooseStoreController.isLoading.value
            ? SahaLoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    chooseStoreController.checkNoStore.value
                        ? Expanded(
                            child: SahaEmptyStore(
                              width: Get.width,
                              height: 100,
                            ),
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Cửa hàng đã chọn",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(child: Obx(() {
                                  var listStore =
                                      chooseStoreController.listStore;

                                  var idSelected =
                                      homeController.storeCurrent?.value.id ??
                                          null;

                                  return ListView.builder(
                                      itemCount: listStore.length,
                                      itemBuilder: (context, index) => Column(
                                            children: [
                                              ItemStore(
                                                store: listStore[index],
                                                selected: listStore[index].id ==
                                                    idSelected,
                                                index: index + 1,
                                                onChange: (store) {
                                                  homeController
                                                      .setNewStoreCurrent(
                                                          store);

                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          ));
                                })),
                              ],
                            ),
                          ),
                    SahaButtonFullParent(
                      text: "Thêm cửa hàng",
                      onPressed: () {
                        Get.to(() => AddStore())!.then((value) => {
                              if (value == "create_success")
                                {
                                  chooseStoreController.getListStore(),
                                  // homeController.checkNoStore.value = false,
                                }
                            });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class ItemStore extends StatelessWidget {
  final Store? store;
  final Function? onChange;
  final bool selected;

  final int? index;

  const ItemStore(
      {Key? key, this.store, this.onChange, this.selected = false, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onChange!(store);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    imageUrl: store?.logoUrl ?? "",
                    placeholder: (context, u) => SahaLoadingContainer(),
                    errorWidget: (context, url, error) => SahaEmptyImage()),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                store?.name ?? "",
                style: TextStyle(),
              ),
              Spacer(),
              if (selected)
                Icon(
                  Icons.check,
                  color: SahaPrimaryColor,
                )
            ],
          ),
        ),
      ),
    );
  }
}
