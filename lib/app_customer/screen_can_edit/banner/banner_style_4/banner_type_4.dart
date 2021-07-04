import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_container.dart';

import '../../../screen_default/data_app_controller.dart';

class BannerType4 extends StatefulWidget {
  @override
  _BannerType4State createState() => _BannerType4State();

  final double? height;

  BannerType4({this.height});
}

class _BannerType4State extends State<BannerType4> {
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
          : CarouselSlider(
        items: dataAppCustomerController.homeData!.banner!.list!
            .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      width: Get.width,
                      fit: BoxFit.cover,
                      imageUrl:  item.imageUrl!,
                      placeholder: (context, url) => SahaLoadingContainer(),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
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
                )),
          ),
        ))
            .toList(),
        options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 7,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),

    ]);
  }
}
