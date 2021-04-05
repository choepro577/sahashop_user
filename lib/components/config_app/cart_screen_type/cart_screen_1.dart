import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/cart.dart';

class CartScreen1 extends StatefulWidget {
  final List<Cart> listCart;

  CartScreen1({this.listCart});

  @override
  _CartScreen1State createState() => _CartScreen1State();
}

class _CartScreen1State extends State<CartScreen1> {
  List<Cart> listCart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCart = widget.listCart ?? demoCarts;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${demoCarts.length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: listCart.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(listCart[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  demoCarts.removeAt(index);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/trash.svg"),
                  ],
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 88,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(listCart[index].product.images[0]),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listCart[index].product.title,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: "\$${listCart[index].product.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: SahaPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x${listCart[index].numOfItem}",
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: SahaPrimaryColor,
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$337.15",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: SahaPrimaryColor,
                        onPressed: () {},
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
