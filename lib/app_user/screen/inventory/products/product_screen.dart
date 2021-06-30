import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'product_controller.dart';
import 'widget/product_page/product_page.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();
  late TabController _controller;

  ProductsController productsController = ProductsController();

  @override
  void initState() {
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: productsController.searching.value
                ? SahaTextFieldSearch(
                    onSubmitted: (va) {
                      productsController.onSearch(va);
                    },
                    onClose: () {
                      productsController.closeSearch();
                      productsController.searching.value = false;
                    },
                  )
                : Text("Tất cả sản phẩm"),
            actions: [
              IconButton(
                  icon: Icon(Icons.search_outlined),
                  onPressed: () {
                    productsController.searching.value = true;
                  })
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Còn hàng\n(${productsController.totalStoking})",
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Hết hàng\n(${productsController.totalOutOfStock})",
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Đã ẩn\n(${productsController.totalHide})",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          body: PageStorage(
            bucket: bucket,
            child: TabBarView(children: [
              ProductPage(
                typePage: TYPE_PAGE.STOCKING,
                updateTotal: updateTotal,
                onReturnController: (pageController) {
                  productsController.addPageController(pageController,TYPE_PAGE.STOCKING);
                },
              ),
              ProductPage(
                typePage: TYPE_PAGE.OUT_OF_STOCK,
                updateTotal: updateTotal,
                onReturnController: (pageController) {
                  productsController.addPageController(pageController,TYPE_PAGE.OUT_OF_STOCK);
                },
              ),
              ProductPage(
                typePage: TYPE_PAGE.HIDE,
                updateTotal: updateTotal,
                onReturnController: (pageController) {
                  productsController.addPageController(pageController,TYPE_PAGE.HIDE,);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void updateTotal(int totalStoking, int totalOutOfStock, int totalHide) {
    productsController.updateTotal(
        totalStokingI: totalStoking,
        totalOutOfStockI: totalOutOfStock,
        totalHideI: totalHide);
  }
}
