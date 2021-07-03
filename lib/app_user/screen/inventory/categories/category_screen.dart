import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/inventory/categories/category_controller.dart';
import 'add_category/add_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  final bool isSelect;
  final List<Category>? listCategorySelected;

  const CategoryScreen(
      {Key? key, this.isSelect = false, this.listCategorySelected = const []})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = new CategoryController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryController
        .listCategorySelected(widget.listCategorySelected!.toList());
  }

  Future<bool> _willPop() async {
    Get.back(result: categoryController.listCategorySelected.toList());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
          appBar: SahaAppBar(
            titleText: "Tất cả danh mục",
            actions: [
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _willPop();
                  })
            ],
          ),
          body: Obx(
            () => categoryController.loading.value
                ? SahaLoadingFullScreen()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            var list = categoryController.listCategory.reversed
                                .toList();
                            if (list == null || list.length == 0) {
                              return SahaEmptyWidget(
                                tile: "Không có danh mục nào",
                              );
                            }

                            return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  var selected =
                                      categoryController.selected(list[index]);

                                  return ItemCategoryWidget(
                                    category: list[index],
                                    selected: selected,
                                    isSelect: widget.isSelect,
                                    categoryController: categoryController,
                                    onTap: () {
                                      categoryController
                                          .selectCategory(list[index]);
                                      setState(() {});
                                    },
                                  );
                                });
                          }),
                        ),
                        SahaButtonFullParent(
                          onPressed: () {
                            Get.to(AddCategoryScreen())!.then((value) {
                              if (value == "added") {
                                categoryController.getAllCategory();
                              }
                            });
                          },
                          text: "Thêm danh mục mới",
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}

class ItemCategoryWidget extends StatelessWidget {
  final Category? category;
  final Function? onTap;
  final bool? selected;
  final bool? isSelect;
  final CategoryController? categoryController;

  const ItemCategoryWidget(
      {Key? key,
      this.category,
      this.onTap,
      this.selected,
      this.isSelect = false,
      this.categoryController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (isSelect!) {
            onTap!();
            return;
          }

          Get.to(() => AddCategoryScreen(
                    category: category,
                  ))!
              .then((value) {
            if (value == "added") {
              categoryController!.getAllCategory();
            }
          });
        },
        leading: Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(8),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
          child: CachedNetworkImage(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            imageUrl: category!.imageUrl ?? "",
            placeholder: (context, url) => new SahaLoadingWidget(
              size: 30,
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
        title: Text(category!.name!),
        selected: selected!,
        trailing: !isSelect!
            ? IconButton(
                icon: Icon(Icons.delete_rounded),
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn muốn xóa danh mục này?",
                      onOK: () {
                        categoryController!.deleteCategory(category!.id!);
                      });
                })
            : Checkbox(
                value: selected,
                onChanged: (bool? value) {
                  onTap!();
                },
              ),
      ),
    );
  }
}
