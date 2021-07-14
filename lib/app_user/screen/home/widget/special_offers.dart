import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/home_data/home_data_response.dart';

import 'section_title.dart';

class SpecialOffers extends StatelessWidget {

  final List<BannerUser> listBanner;

  const SpecialOffers({
    Key? key, required this.listBanner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SectionTitle(
            title: "Ưu đãi cho bạn",
            pressTitleEnd: () {
              Get.to(CategoryProductScreen());
            },
          ),
        ),
        SizedBox(height: 5),
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.99,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 8)
          ),
          items: listBanner.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return SpecialOfferCard(
                  image: i.imageUrl!,
                  category: "Smartphone",
                  numOfBrands: 18,
                  press: () {},
                );
              },
            );
          }).toList(),
        ),

      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: Get.width*0.99,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child:  CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image,
            ),

          ),
        ),
      ),
    );
  }
}
