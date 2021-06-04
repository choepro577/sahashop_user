import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/address_screen/choose_address_receiver/receiver_address_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/confirm_screen/controller/confirm_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/shipment_screen/shipment_customer_screen.dart';
import 'package:sahashop_user/components/utils/money.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/info_address_customer.dart';
import 'package:sahashop_user/model/shipment_method.dart';

class ConfirmScreen extends StatefulWidget {
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen>
    with SingleTickerProviderStateMixin {
  ConfirmController confirmController;
  final dataKey = new GlobalKey();
  Color _color = Colors.transparent;
  double _opacityCurrent = 1;

  @override
  void initState() {
    confirmController = Get.put(ConfirmController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận đơn hàng"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                key: dataKey,
                height: 5,
              ),
              Obx(
                () => Column(
                  children: [
                    if (confirmController.infoAddressCustomer.value != null)
                      Card(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ReceiverAddressCustomerScreen(
                                  infoAddressCustomers: confirmController
                                      .infoAddressCustomer.value,
                                  callback: (InfoAddressCustomer
                                      infoAddressCustomer) {
                                    confirmController.infoAddressCustomer
                                        .value = infoAddressCustomer;
                                  },
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/location.svg",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Địa chỉ nhận hàng :"),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            "${confirmController.infoAddressCustomer.value.name ?? "Chưa có tên"}  | ${confirmController.infoAddressCustomer.value.phone ?? "Chưa có số điện thoại"}",
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            "${confirmController.infoAddressCustomer.value.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            "${confirmController.infoAddressCustomer.value.districtName ?? "Chưa có Quận/Huyện"}, ${confirmController.infoAddressCustomer.value.wardsName ?? "Chưa có Phường/Xã"}, ${confirmController.infoAddressCustomer.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 13),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_forward_ios_rounded)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AnimatedOpacity(
                          opacity: _opacityCurrent,
                          duration: const Duration(seconds: 1),
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                                border: Border.all(color: _color)),
                            duration: Duration(seconds: 1),
                            child: Card(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ReceiverAddressCustomerScreen(
                                        infoAddressCustomers: confirmController
                                            .infoAddressCustomer.value,
                                        callback: (InfoAddressCustomer
                                            infoAddressCustomer) {
                                          confirmController.infoAddressCustomer
                                              .value = infoAddressCustomer;
                                        },
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF5F6F9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/location.svg",
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Địa chỉ nhận hàng :"),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Text(
                                                  "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_forward_ios_rounded)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/cart_icon.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Các mặt hàng đã đặt :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                confirmController.dataAppCustomerController.listOrder.length,
                (index) => Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: confirmController
                                            .dataAppCustomerController
                                            .listOrder[index]
                                            .product
                                            .images
                                            .length ==
                                        0
                                    ? ""
                                    : confirmController
                                        .dataAppCustomerController
                                        .listOrder[index]
                                        .product
                                        .images[0]
                                        .imageUrl,
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
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: Get.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              confirmController.dataAppCustomerController
                                      .listOrder[index].product.name ??
                                  "Loi san pham",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text:
                                    "\$${FormatMoney.toVND(confirmController.dataAppCustomerController.listOrder[index].product.price)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: SahaPrimaryColor),
                                children: [
                                  TextSpan(
                                      text:
                                          " x ${confirmController.dataAppCustomerController.listOrder[index].quantity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ShipmentCustomerScreen(
                        infoAddressCustomer:
                            confirmController.infoAddressCustomer.value,
                        callback: (ShipmentMethod shipmentMethod) {
                          confirmController.shipmentMethod.value =
                              shipmentMethod;
                        },
                        isShipmentFast:
                            confirmController.shipmentMethod.value.shipType == 0
                                ? true
                                : false,
                      ));
                },
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Đơn vị vận chuyển ( Nhấn để chọn )',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                confirmController
                                            .shipmentMethod.value.shipType ==
                                        0
                                    ? Text(
                                        'Vận chuyển nhanh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Vận chuyển siêu tốc',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${confirmController.shipmentMethod.value.name ?? "Chưa chọn đơn vị vẩn chuyển"}"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Nhận hàng sau 1 - 2 ngày nội thành",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    '${confirmController.shipmentMethod.value.fee ?? ""} đ'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Tin nhắn : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Lưu ý cho người bán ...",
                        ),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng số tiền (${confirmController.dataAppCustomerController.listOrder.length} sản phẩm) : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                          "${FormatMoney.toVND(confirmController.dataAppCustomerController.totalMoney.value + confirmController.shipmentMethod.value.fee)}"),
                    )
                  ],
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/receipt.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Shop Voucher : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Chọn hoặc nhập mã"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/money.svg",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Phương thức thanh toán',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 120,
                                  child: Text(
                                    "Chọn phương thức thanh toán",
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền hàng :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${FormatMoney.toVND(confirmController.dataAppCustomerController.totalMoney.value)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền vận chuyển :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${FormatMoney.toVND(confirmController.shipmentMethod.value.fee.toDouble())}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng thanh toán :',
                            ),
                            Text(
                                "${FormatMoney.toVND(confirmController.dataAppCustomerController.totalMoney.value + confirmController.shipmentMethod.value.fee.toDouble())}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/doc.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản SahaShop "),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 0.1), // Shadow position
              ),
            ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Tổng thanh toán"),
                    Text(
                      "${FormatMoney.toVND(confirmController.dataAppCustomerController.totalMoney.value + confirmController.shipmentMethod.value.fee.toDouble())}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    if (confirmController.infoAddressCustomer.value == null) {
                      Scrollable.ensureVisible(dataKey.currentContext,
                          duration: Duration(milliseconds: 500));
                      setState(() {
                        _color = Colors.red;
                        _opacityCurrent = 0;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            _opacityCurrent = 1;
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              setState(() {
                                _opacityCurrent = 0;
                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    _opacityCurrent = 1;
                                  });
                                });
                              });
                            });
                          });
                        });
                      });
                    } else {
                      confirmController.createOrders();
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Đặt hàng",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
