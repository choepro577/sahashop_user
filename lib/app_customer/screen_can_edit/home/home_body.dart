import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home_buttons/list_home_button.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/model/discount_product_list.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/model/product.dart';

class HomeBodyWidget extends StatelessWidget {
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  List<Widget> listLayout() {
    List<Widget> list = [];
    if (dataAppCustomerController.homeData!.listLayout != null) {
      for (var layout in dataAppCustomerController.homeData!.listLayout!) {
        list.add(layout.model == "HomeButton"&& layout.hide == false
            ? ListHomeButtonWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: SectionTitle(
                      title: layout.title ?? "",
                      titleEnd: "Tất cả",
                      pressTitleEnd: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  if (layout.model == "Product"&& layout.hide == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 251,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: layout.list!
                                .cast<Product>()
                                .map((product) => ProductItemWidget(
                                      width: 180,
                                      product: product,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  if (layout.model == "Category" && layout.hide == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: layout.list!
                                .cast<Category>()
                                .map((category) => CategoryButton(
                                      category: category,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  if (layout.model == "Post" && layout.hide == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: layout.list!
                              .cast<Post>()
                              .map((post) => PostItemWidget(
                                    width: 300,
                                    post: post,
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                ],
              ));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listLayout(),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.titleEnd,
    this.pressTitleEnd,
    this.colorTextTitle,
    this.colorTextMore,
  }) : super(key: key);

  final String title;
  final String? titleEnd;
  final Color? colorTextTitle;
  final Color? colorTextMore;

  final GestureTapCallback? pressTitleEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorTextTitle ?? Colors.black,
          ),
        ),
        pressTitleEnd == null
            ? Container()
            : GestureDetector(
                onTap: pressTitleEnd,
                child: Text(
                  "${titleEnd == null ? "" : titleEnd}",
                  style: TextStyle(
                    color: colorTextMore ?? Colors.grey[500],
                  ),
                ),
              ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(CategoryProductScreen(
            categoryId: category!.id,
          ));
        },
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 0.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 55,
                        width: 55,
                        imageUrl: category!.imageUrl ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    category!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
