import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/chip/ticker.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ModalBottomOptionBuyProduct {
  static Future<void> showModelOption(
      {required Product product,
      List<DistributesSelected>? distributesSelectedParam,
      int? quantity,
      Function(int quantity, Product product,
              List<DistributesSelected> distributesSelected)?
          onSubmit}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return OptionBuyProduct(
          product: product,
          onSubmit: onSubmit,
          distributesSelectedParam: distributesSelectedParam,
          quantity: quantity,
        );
      },
    );
  }
}

class OptionBuyProduct extends StatefulWidget {
  final Product product;
  final List<DistributesSelected>? distributesSelectedParam;
  final int? quantity;
  final Function(int quantity, Product product,
      List<DistributesSelected> distributesSelected)? onSubmit;

  const OptionBuyProduct(
      {Key? key,
      required this.product,
      this.onSubmit,
      this.distributesSelectedParam,
      this.quantity})
      : super(key: key);

  @override
  _OptionBuyProductState createState() => _OptionBuyProductState();
}

class _OptionBuyProductState extends State<OptionBuyProduct> {
  int quantity = 1;
  String errorTextInBottomModel = "";

  List<DistributesSelected> distributesSelected = [];

  bool canDecrease = true;
  bool canIncrease = true;

  var quantityInStock;
  int? max = -1;

  @override
  void initState() {
    super.initState();

    if (widget.distributesSelectedParam != null) {
      distributesSelected = widget.distributesSelectedParam!;
    }
    if (widget.quantity != null) {
      quantity = widget.quantity!;
    }

    quantityInStock = widget.product.quantityInStock == null ||
            widget.product.quantityInStock! < 0
        ? "Vô hạn"
        : widget.product.quantityInStock;
    checkCanCrease();
  }

  void onCheckElementDistribute(String name, String value) {
    distributesSelected.removeWhere((distribute) => distribute.name == name);
    distributesSelected.add(DistributesSelected(name: name, value: value));
    setState(() {});
  }

  bool isChecked(String nameDistribute, String nameElement) {
    if (distributesSelected.map((e) => e.name).contains(nameDistribute) &&
        distributesSelected.map((e) => e.value).contains(nameElement)) {
      return true;
    } else {
      return false;
    }
  }

  void onSubmitBuy({bool buyNow = false}) {
    if (max == 0) {
      errorTextInBottomModel = "Hết hàng";
      setState(() {});
      return;
    }

    for (var distribute in widget.product.distributes!) {
      if (!distributesSelected
          .map((element) => element.name)
          .contains(distribute.name)) {
        errorTextInBottomModel = "Mời chọn ${distribute.name}";
        setState(() {});
        return;
      }
    }
    widget.onSubmit!(quantity, widget.product, distributesSelected);
  }

  bool isDoneCheckElement() {
    bool ok =
        (widget.product.distributes!.length == distributesSelected.length);
    if (ok == true) errorTextInBottomModel = "";
    return ok;
  }

  void checkCanCrease() {
    setState(() {
      max = widget.product.quantityInStock == null ||
              widget.product.quantityInStock! < 0
          ? -1
          : widget.product.quantityInStock;

      if (max == 0) {
        errorTextInBottomModel = "Hết hàng";
      }

      if (quantity == 1)
        canDecrease = false;
      else
        canDecrease = true;

      if (quantity + 1 > max! && max != -1)
        canIncrease = false;
      else
        canIncrease = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: CachedNetworkImage(
                          imageUrl: widget.product.images!.length == 0
                              ? ""
                              : widget.product.images![0].imageUrl!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/saha_loading.png")),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SahaMoneyText(
                        price: widget.product.price,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Kho: $quantityInStock")
                    ],
                  )
                ],
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 15,
          ),
          widget.product.distributes == null ||
                  widget.product.distributes!.length == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 35.0,
                        maxHeight: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Get.height * 0.5
                            : Get.height * 0.2,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.product.distributes!
                                .map((distribute) => Container(
                                      width: Get.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8),
                                            child: Text(distribute.name!),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Wrap(
                                              children: distribute
                                                  .elementDistributes!
                                                  .map(
                                                    (elementDistribute) =>
                                                        TickerStateLess(
                                                      text: elementDistribute
                                                          .name,
                                                      ticked: isChecked(
                                                          distribute.name!,
                                                          elementDistribute
                                                              .name!),
                                                      onChange: (va) {
                                                        onCheckElementDistribute(
                                                            distribute.name!,
                                                            elementDistribute
                                                                .name!);
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số lượng",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity == 1) return;
                          quantity--;
                        });
                        errorTextInBottomModel = "";
                        checkCanCrease();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.remove,
                          color: canDecrease ? Colors.black : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!)),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          int? max = widget.product.quantityInStock == null ||
                                  widget.product.quantityInStock! < 0
                              ? -1
                              : widget.product.quantityInStock;
                          if (quantity + 1 > max! && max != -1) {
                            errorTextInBottomModel =
                                "Bạn đã chọn hết số hàng trong kho";

                            return;
                          } else {
                            errorTextInBottomModel = "";
                          }

                          quantity++;
                        });

                        checkCanCrease();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.add,
                          color: canIncrease ? Colors.black : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          !isDoneCheckElement() && errorTextInBottomModel.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$errorTextInBottomModel",
                    style: TextStyle(fontSize: 12, color: Colors.redAccent),
                  ),
                )
              : Container(),
          SahaButtonFullParent(
            text: "Mua ngay",
            textColor: Theme.of(context).primaryTextTheme.headline6!.color,
            color: isDoneCheckElement()
                ? Theme.of(context).primaryColor
                : Colors.grey,
            onPressed: () {
              onSubmitBuy();
            },
          ),
        ],
      ),
    );
  }
}
