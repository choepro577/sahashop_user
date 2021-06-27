import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_loading_widget.dart';
import 'package:sahashop_user/components/app_customer/components/product_item/product_item_widget.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';

import 'favorites_controller.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesController favoritesController = FavoritesController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        favoritesController.getProducts(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: SahaAppBar(
        titleText: "Sản phẩm yêu thích",
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = favoritesController.isLoadingProduct.value;
      var list =
          isLoading ? LIST_PRODUCT_EXAMPLE : favoritesController.products;
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: RefreshIndicator(
            onRefresh: () async {
              await  favoritesController.getProducts(isRefresh: true);
            },
            child:  SingleChildScrollView(
              child: Container(
                height: Get.height,
                child:
                isLoading ?  StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) =>
                      ProductItemLoadingWidget(),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ) :

                StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) => ProductItemWidget(
                    product: list[index],
                    isLoading: isLoading,
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
              ),
            ),
        ),
      );
    });
  }
}
