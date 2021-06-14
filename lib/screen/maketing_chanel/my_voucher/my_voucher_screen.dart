import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/discount_product_list.dart';
import 'package:sahashop_user/model/voucher.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/create_my_program.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/my_program_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/update_my_program/update_my_program.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/create_my_voucher/create_my_voucher_screen.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/my_voucher_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/update_voucher/update_voucher_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class MyVoucherScreen extends StatefulWidget {
  @override
  _MyVoucherScreenState createState() => _MyVoucherScreenState();
}

class _MyVoucherScreenState extends State<MyVoucherScreen>
    with TickerProviderStateMixin {
  bool isHasDiscount = false;
  bool isTabOnTap = false;
  TabController tabController;
  MyVoucherController myVoucherController = Get.put(MyVoucherController());

  List<String> stateVoucher = [
    "Chưa có Voucher nào được tạo",
    "Chưa có Voucher nào được tạo",
    "Chưa có Voucher nào được tạo",
  ];

  List<String> stateVoucherSub = [
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    myVoucherController.getAllVoucher();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Mã giảm giá của tôi'),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: "Sắp diễn ra"),
              Tab(text: "Đang diễn ra"),
              Tab(text: "Đã kết thúc"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(3, (int index) {
            return buildStateProgram(index);
          }),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Tạo Voucher mới",
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 250,
                        color: Colors.white,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(() => CreateMyVoucher(
                                          voucherType: 0,
                                        ))
                                    .then((value) =>
                                        {myVoucherController.refreshData()});
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạo Voucher toàn Shop",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Có thể áp dụng voucher này cho tất cả các sản phẩm trong Shop của bạn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(() => CreateMyVoucher(
                                      voucherType: 1,
                                    ));
                              },
                              child: Container(
                                height: 80,
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạo Voucher sản phẩm",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Có thể áp dụng voucher này cho một số sản phẩm nhất định trong Shop của bạn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              color: Colors.grey[200],
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Thoát",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStateProgram(int indexState) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(
          complete: Text(""),
        ),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus mode,
          ) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("Xem thêm");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Đã hết Voucher kết thúc");
            } else {
              body = Text("Đã xem hết Voucher");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 300));

          // if (mounted) setState(() {});
          if (indexState == 2) {
            myVoucherController.loadInitEndVoucher();
          } else {
            myVoucherController.refreshData();
          }
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 300));
          if (indexState == 2) {
            if (!myVoucherController.isEndPageVoucher) {
              myVoucherController.loadMoreEndVoucher();
              _refreshController.loadComplete();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        child: Obx(
          () => myVoucherController
                  .listAllSaveStateBefore.value[indexState].isNotEmpty
              ? Obx(
                  () => myVoucherController.isRefreshingData.value == true &&
                          myVoucherController.listAllSaveStateBefore
                              .value[indexState].isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myVoucherController.listAllSaveStateBefore
                                      .value[indexState].length, (index) {
                                return programIsComingItem(
                                    myVoucherController.listAllSaveStateBefore
                                        .value[indexState][index],
                                    indexState);
                              })
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myVoucherController.listAllSaveStateBefore
                                      .value[indexState].length, (index) {
                                return programIsComingItem(
                                    myVoucherController.listAllSaveStateBefore
                                        .value[indexState][index],
                                    indexState);
                              })
                            ],
                          ),
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(15.0),
                        width: Get.width * 0.4,
                        child: AspectRatio(
                            aspectRatio: 1,
                            child:
                                SvgPicture.asset("assets/icons/time_out.svg"))),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateVoucher[indexState],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateVoucherSub[indexState],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget programIsComingItem(Voucher listVoucherState, int indexState) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listVoucherState.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(listVoucherState.startTime)} ${SahaDateUtils().getHHMM(listVoucherState.startTime)} - ${SahaDateUtils().getDDMMYY(listVoucherState.endTime)} ${SahaDateUtils().getHHMM(listVoucherState.endTime)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 55,
                      height: 55,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: listVoucherState.imageUrl == null
                            ? ""
                            : "${listVoucherState.imageUrl}",
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listVoucherState.discountType == 1
                                ? Text(
                                    "${listVoucherState.valueDiscount}% Giảm",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    "đ${listVoucherState.valueDiscount} Giảm",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Đơn tối thiểu ${SahaStringUtils().convertToMoney("${listVoucherState.valueLimitTotal}")}",
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            listVoucherState.voucherType == 0
                                ? Text(
                                    "Voucher toàn Shop",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                : Text(
                                    "Voucher theo sản phẩm",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  ),
                          ],
                        ),
                        Text("${listVoucherState.code}")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              indexState == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => UpdateMyVoucherScreen(
                                  voucher: listVoucherState,
                                  onlyWatch: true,
                                ));
                          },
                          child: Container(
                            height: 35,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.circular(2.0)),
                            child: Center(
                              child: Text("Xem"),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => UpdateMyVoucherScreen(
                                      voucher: listVoucherState,
                                    ))
                                .then((value) =>
                                    {myVoucherController.refreshData()});
                          },
                          child: Container(
                            height: 35,
                            width: Get.width * 0.45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.circular(2.0)),
                            child: Center(
                              child: Text("Thay đổi"),
                            ),
                          ),
                        ),
                        indexState == 1
                            ? InkWell(
                                onTap: () {
                                  myVoucherController
                                      .endVoucher(listVoucherState.id);
                                },
                                child: Container(
                                  height: 35,
                                  width: Get.width * 0.45,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[600]),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Center(
                                    child: Text("Kết thúc ngay"),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  myVoucherController
                                      .deleteVoucher(listVoucherState.id);
                                },
                                child: Container(
                                  height: 35,
                                  width: Get.width * 0.45,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[600]),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Center(
                                    child: Text("Xoá"),
                                  ),
                                ),
                              )
                      ],
                    ),
            ],
          )),
    );
  }
}
