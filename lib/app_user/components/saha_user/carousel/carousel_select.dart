import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../fakedevicepixelratio.dart';

class CarouselSelect extends StatefulWidget {
  final List<Widget>? listWidget;
  final Function? onChange;
  final Function? onSelected;
  final int? indexSelected;
  final int? initPage;
  final double? height;
  final double? width;

  const CarouselSelect(
      {Key? key,
      this.listWidget,
      this.onChange,
      this.indexSelected,
      this.initPage=0,
      this.height,
        this.width,
      this.onSelected})
      : super(key: key);

  @override
  _CarouselSelectState createState() => _CarouselSelectState();
}

class _CarouselSelectState extends State<CarouselSelect> {
  int? page;
  int? indexSelected;
  double? height;
  double? width;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = widget.initPage;
    height = widget.height;
    width = widget.width;
    indexSelected = widget.indexSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.listWidget!
                .map((e) => Container(
              width: width,
                  child: Center(
                    child: Card(
                          child: IgnorePointer(
                            child: FakeDevicePixelRatio(
                              child: e,
                              fakeDevicePixelRatio: 2.0,
                            ),
                          ),
                        ),
                  ),
                ))
                .toList(),
            options: CarouselOptions(
              height: height,

              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: widget.initPage!,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (va, reason) {
                page = va;
                print(va);
                if (widget.onChange != null) widget.onChange!(va);
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listWidget!.map((url) {
            int index = widget.listWidget!.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: page == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
        Container(
          height: 40,
          child: FilterChip(
            label: Text(indexSelected == page ? "Đã chọn" : "Chọn", style: TextStyle(fontSize: 13),),
            selected: indexSelected == page,
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(side: BorderSide()),
            onSelected: (bool value) {
              indexSelected = page;
              setState(() {});
              widget.onSelected!(indexSelected);
            },
          ),
        ),
      ],
    );
  }
}
