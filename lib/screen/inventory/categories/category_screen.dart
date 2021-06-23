import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/empty/empty_widget.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/inventory/categories/category_controller.dart';
import 'add_category/add_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  final bool isSelect;
  final List<Category>? listCategorySelected;

  const CategoryScreen({Key? key, this.isSelect = false, this.listCategorySelected = const []}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = new CategoryController();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryController.listCategorySelected(widget.listCategorySelected!.toList());
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
                            var list = categoryController.listCategory
                                .toList()
                                .reversed
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

  const ItemCategoryWidget(
      {Key? key,
      this.category,
      this.onTap,
      this.selected,
      this.isSelect = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (isSelect!) onTap!();
        },
        leading: CachedNetworkImage(
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          imageUrl: category!.imageUrl ?? "",
          placeholder: (context, url) => new SahaLoadingWidget(
            size: 30,
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
        title: Text(category!.name!),
        selected: selected!,
        trailing: !isSelect!
            ? Container(
                width: 1,
              )
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
