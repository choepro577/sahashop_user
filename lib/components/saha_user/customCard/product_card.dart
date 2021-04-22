import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: SahaSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: press,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLoading
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 100,
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: product.images[0].imageUrl,
                            errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 100,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), //product.images[0].imageUrl
                SizedBox(height: 10),
                isLoading
                    ? Container(
                        width: 40,
                        height: 10,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                          ),
                        ],
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
                        : Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: ThemeData().primaryColor,
                            ),
                          ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: true
                              ? SahaPrimaryColor.withOpacity(0.15)
                              : SahaSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/gift_icon.svg",
                          color: true
                              ? ThemeData().primaryColor
                              : Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
