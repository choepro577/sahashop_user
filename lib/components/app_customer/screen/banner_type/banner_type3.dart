import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_container.dart';

import '../data_app_controller.dart';

class BannerType3 extends StatefulWidget {
  @override
  _BannerType3State createState() => _BannerType3State();

  final double? height;

  BannerType3({this.height});
}

class _BannerType3State extends State<BannerType3> {
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
          scrollDirection: Axis.vertical,
            aspectRatio: 16 / 7,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      dataAppCustomerController.homeData?.banner?.list == null
          ? Container()
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        dataAppCustomerController.homeData!.banner!.list!.map((url) {
          int index =
          dataAppCustomerController.homeData!.banner!.list!.indexOf(url);
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
