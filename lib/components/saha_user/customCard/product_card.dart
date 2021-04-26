import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/utils/money.dart';
import 'package:sahashop_user/model/product.dart';

import '../../../const/constant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    @required this.press,
    this.isLoading,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback press;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: SahaSecondaryColor.withOpacity(0.1),
      ),
      child: InkWell(
        onTap: press,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? Container(
                    height: 180,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: CachedNetworkImage(
                      height: 180,
                      width: Get.width,
                      fit: BoxFit.cover,
                      imageUrl: product.images[0].imageUrl,
                      errorWidget: (context, url, error) => CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                      ),
                    ),
                  ), //product.images[0].imageUrl
            SizedBox(height: 5),
            isLoading
                ? Container(
                    width: 40,
                    height: 10,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? Container(
                        height: 10,
                        width: 20,
                        color: Colors.black87,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "${FormatMoney.toVND(product.price)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset(
                        "assets/icons/gift_icon.svg",
                        color: true
                            ? Theme.of(context).primaryColor
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
