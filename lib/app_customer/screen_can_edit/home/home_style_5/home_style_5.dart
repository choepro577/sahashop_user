import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/screen/home/widget/section_title.dart';

import '../home_body.dart';

class HomeScreenStyle5 extends StatefulWidget {
  const HomeScreenStyle5({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle5State createState() => _HomeScreenStyle5State();
}

class _HomeScreenStyle5State extends State<HomeScreenStyle5> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 100) {
          setState(() {
            _opacity = 1;
          });
        } else {
          _opacity = _scrollController.offset / 100;
        }
      });
    });

    configController.addButton(context);
  }

  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 248,
                child: BannerWidget(),
              ),
              HomeBodyWidget()
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(microseconds: 250),
          height: 100,
          width: double.infinity,
          color: Colors.white.withOpacity(_opacity),
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: SearchBarType1(
            onSearch: () {
              Get.to(CategoryProductScreen(
                autoSearch: true,
              ));
            },
          ),
        )
      ],
    ));
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
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
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
