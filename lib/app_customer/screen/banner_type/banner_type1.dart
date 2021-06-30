import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';

import '../data_app_controller.dart';

class BannerType1 extends StatefulWidget {
  @override
  _BannerType1State createState() => _BannerType1State();

  final double? height;

  BannerType1({this.height});
}

class _BannerType1State extends State<BannerType1> {
  int _current = 0;
  double? height;

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      dataAppCustomerController.homeData?.banner?.list == null
          ? Container()
          : Container(
              width: Get.width,
              child: CarouselSlider(
                items: dataAppCustomerController.homeData!.banner!.list!
                    .map((item) => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              width: Get.width,
                              fit: BoxFit.cover,
                              imageUrl: item.imageUrl!,
                              placeholder: (context, url) =>
                                  SahaLoadingContainer(),
                              errorWidget: (context, url, error) =>
                                  SahaEmptyImage(),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 20 / 7,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
      dataAppCustomerController.homeData?.banner?.list == null
          ? Container()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  dataAppCustomerController.homeData!.banner!.list!.map((url) {
                int index = dataAppCustomerController.homeData!.banner!.list!
                    .indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
    ]);
  }
}
