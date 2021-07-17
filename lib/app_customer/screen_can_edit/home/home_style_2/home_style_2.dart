import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../screen_default/search_bar_type/search_bar_type1.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/model/button.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import '../home_body.dart';

class HomeScreenStyle2 extends StatefulWidget {
  final List<Category>? categories;
  final List<ButtonConfig>? buttonConfigs;

  HomeScreenStyle2({
    Key? key,
    this.categories,
    this.buttonConfigs,
  }) : super(key: key);

  @override
  _HomeScreenStyle2State createState() => _HomeScreenStyle2State();
}

class _HomeScreenStyle2State extends State<HomeScreenStyle2> {
  ConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    configController.addButton(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: configController.contactButton.isNotEmpty
          ? SpeedDial(
              marginEnd: 18,
              marginBottom: 20,
              icon: Icons.phone,
              activeIcon: Icons.read_more_sharp,
              buttonSize: 56.0,
              visible: true,
              closeManually: false,
              renderOverlay: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.grey[300],
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 8.0,
              shape: CircleBorder(),
              children: configController.contactButton,
            )
          : Container(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SearchBarType1(
              onSearch: () {
                Get.to(CategoryProductScreen(
                  autoSearch: true,
                ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            BannerWidget(),
            HomeBodyWidget()
          ],
        ),
      ),
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
