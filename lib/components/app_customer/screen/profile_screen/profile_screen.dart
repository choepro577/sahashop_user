import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 185,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .color,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .color,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.chat,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                .color,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          child: CachedNetworkImage(
                              imageUrl:
                                  "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/118256441_2768245916792384_8843635159388304315_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=c9bnYRU10ZMAX9acx-T&_nc_ht=scontent.fvca1-1.fna&oh=db0cb804982586ff6f4d8a1ffd564860&oe=60D076EA"),
                          borderRadius: BorderRadius.circular(3000),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "Hieudeptrai",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 18,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                "Thành viên",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
