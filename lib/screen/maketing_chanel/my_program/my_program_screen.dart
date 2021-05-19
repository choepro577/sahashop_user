import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/discount_product_list.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/create_my_program.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/my_program_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/update_my_program/update_my_program.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class MyProgram extends StatefulWidget {
  Function onChange;

  MyProgram({this.onChange});

  @override
  _MyProgramState createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> with TickerProviderStateMixin {
  bool isHasDiscount = false;
  bool isTabOnTap = false;
  TabController tabController;
  MyProgramController myProgramController = Get.put(MyProgramController());

  List<String> stateProgram = [
    "Không có khuyến mãi sắp diễn ra",
    "Không có khuyến mãi đang diễn ra",
    "Không có khuyến mãi đã kết thúc",
  ];

  List<String> stateProgramSub = [
    "Không có chương trình khuyến mãi nào sắp diễn ra",
    "Không có chương trình khuyến mãi nào đang diễn ra",
    "Không có chương trình khuyến mãi nào đã kết thúc",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    myProgramController.getAllDiscount();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Chương trình của tôi'),
          bottom: TabBar(
            controller: tabController,
            onTap: (index) {
              isTabOnTap = true;
            },
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
                text: "Tạo chương trình khuyến mãi",
                onPressed: () {
                  Get.to(() => CreateMyProgram()).then((value) => {
                        myProgramController.refreshData(),
                      });
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
            myProgramController.loadInitEndDiscount();
          } else {
            myProgramController.refreshData();
          }
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 300));
          if (indexState == 2) {
            if (!myProgramController.isEndPageDiscount) {
              myProgramController.loadMoreEndDiscount();
              _refreshController.loadComplete();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        child: Obx(
          () => myProgramController
                  .listAllSaveStateBefore.value[indexState].isNotEmpty
              ? Obx(
                  () => myProgramController.isRefreshingData.value == true &&
                          myProgramController.listAllSaveStateBefore
                              .value[indexState].isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myProgramController.listAllSaveStateBefore
                                      .value[indexState].length, (index) {
                                return programIsComingItem(
                                    myProgramController.listAllSaveStateBefore
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
                                  myProgramController.listAllSaveStateBefore
                                      .value[indexState].length, (index) {
                                return programIsComingItem(
                                    myProgramController.listAllSaveStateBefore
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
                        stateProgram[indexState],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateProgramSub[indexState],
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

  Widget programIsComingItem(
      DiscountProductsList listProgramState, int indexState) {
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
                          listProgramState.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(listProgramState.startTime)} ${SahaDateUtils().getHHMM(listProgramState.startTime)} - ${SahaDateUtils().getDDMMYY(listProgramState.endTime)} ${SahaDateUtils().getHHMM(listProgramState.endTime)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: listProgramState.products[0].images.length ==
                                0
                            ? ""
                            : "${listProgramState.products[0].images[0].imageUrl}",
                        errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                          ),
                        ),
                      ),
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
                            Get.to(() => UpdateMyProgram(
                                  programDiscount: listProgramState,
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
                            Get.to(() => UpdateMyProgram(
                                      programDiscount: listProgramState,
                                    ))
                                .then((value) =>
                                    {myProgramController.refreshData()});
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
                                  myProgramController.endDiscount(
                                      listProgramState.id,
                                      true,
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      0,
                                      false,
                                      0,
                                      "");
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
                                  myProgramController.deleteDiscount(
                                    listProgramState.id,
                                  );
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
