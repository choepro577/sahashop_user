import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/report/product_report_response.dart';
import 'package:sahashop_user/data/remote/response-request/report/report_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'option_report/chart_business.dart';

class ReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var listChart = RxList<Chart?>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var listChooseChartType = RxList<bool>([true, false]);
  var reportPrimeTime = DataPrimeTime().obs;
  var reportCompareTime = DataCompareTime().obs;
  var isOpenOrderDetail = false.obs;
  var isLoading = false.obs;

  var differenceTotalFinal = 0.0.obs;
  var differenceOrder = 0.0.obs;
  var percentTotalFinal = 0.0.obs;
  var percentOrder = 0.0.obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:"];
  List<String> listMonth = [
    "Tháng 1",
    "Tháng 2",
    "Tháng 3",
    "Tháng 4",
    "Tháng 5",
    "Tháng 6",
    "Tháng 7",
    "Tháng 8",
    "Tháng 9",
    "Tháng 10",
    "Tháng 11",
    "Tháng 12",
  ];

  var listLineChart = RxList<LineSeries<SalesData?, String>>();

  /// order report

  var orderPartiallyPaid = Chart().obs;
  var orderUnPaid = Chart().obs;
  var orderWaitingProcess = Chart().obs;
  var orderShipping = Chart().obs;
  var orderCompleted = Chart().obs;
  var orderCustomerCancel = Chart().obs;
  var orderUserCancel = Chart().obs;
  var orderWaitingReturn = Chart().obs;
  var orderWaitingRefunds = Chart().obs;

  ReportController() {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
    getReport();
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  void changeChooseChartType(int index) {
    listChooseChartType([false, false]);
    listChooseChartType[index] = true;
    listChooseChartType.refresh();
    if (listChooseChartType[1] == true) {
      isTotalChart.value = false;
    } else {
      isTotalChart.value = true;
    }
  }

  Future<void> getReport() async {
    isLoading.value = true;
    try {
      DetailsByPaymentStatus? detailsByPaymentStatus;
      DetailsByOrderStatus? detailsByOrderStatus;
      var res = await RepositoryManager.reportRepository.getReport(
        fromDay.value.toIso8601String(),
        toDay.value.toIso8601String(),
        fromDayCP.value.toIso8601String(),
        toDayCP.value.toIso8601String(),
      );

      reportPrimeTime.value = res!.data!.dataPrimeTime!;
      reportCompareTime.value = res.data!.dataCompareTime ??
          DataCompareTime(totalOrderCount: 1000000);
      differenceTotalFinal.value = reportPrimeTime.value.totalFinal! -
          reportCompareTime.value.totalFinal!;
      differenceOrder.value = reportPrimeTime.value.totalOrderCount! -
          reportCompareTime.value.totalOrderCount!;
      percentTotalFinal.value = differenceTotalFinal.value.abs() *
          100 /
          (reportPrimeTime.value.totalFinal! + 1);
      percentOrder.value = differenceOrder.value.abs() *
          100 /
          (reportPrimeTime.value.totalOrderCount! + 1);

      detailsByPaymentStatus = res.data!.dataPrimeTime!.detailsByPaymentStatus;
      detailsByOrderStatus = res.data!.dataPrimeTime!.detailsByOrderStatus;
      orderPartiallyPaid.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.partiallyPaid!;
      orderUnPaid.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.unpaid!;
      orderWaitingProcess.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!
              .waitingForProgressing!;
      orderShipping.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.shipping!;
      orderCompleted.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.completed!;
      orderCustomerCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerCancelled!;
      orderUserCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.userCancelled!;
      orderWaitingReturn.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerReturning!;
      orderWaitingRefunds.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.refunds!;
      getProductReport();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// chart_product

  var listTotalItemPr = RxList<TotalItem>();
  var listNumberOrderPr = RxList<NumberOfOrder>();
  var listPricePr = RxList<TotalPrice>();
  var listViewPr = RxList<View>();
  var listNameProductTop = RxList<String>();
  var listPropertiesTop = RxList<int>();
  var listProductInChart = RxList<List<dynamic>>();
  var listChooseChartProduct = RxList<bool>([true, false, false, false]);
  var indexTypeChart = 0.obs;

  List<String> listNameChartProduct = [
    "Top Số lượng:",
    "Top Số đơn:",
    "Top Tổng thu:",
    "Top lượt xem:"
  ];

  void changeChooseChartProduct(int index) {
    listChooseChartProduct([false, false, false, false]);
    listChooseChartProduct[index] = true;
    listChooseChartProduct.refresh();
    indexTypeChart.value = index;
  }

  Future<void> getProductReport() async {
    try {
      var res = await RepositoryManager.reportRepository.getProductReport(
        fromDay.value.toIso8601String(),
        toDay.value.toIso8601String(),
      );
      listTotalItemPr(res!.data!.totalItems);
      listNumberOrderPr(res.data!.numberOfOrders);
      listPricePr(res.data!.totalPrice);
      listViewPr(res.data!.view);
      listNameProductTop([
        listTotalItemPr.isEmpty ? "nothing" : listTotalItemPr[0].product!.name!,
        listNumberOrderPr.isEmpty
            ? "nothing"
            : listNumberOrderPr[0].product!.name!,
        listPricePr.isEmpty ? "nothing" : listPricePr[0].product!.name!,
        listViewPr.isEmpty ? "nothing" : listViewPr[0].product!.name!,
      ]);
      listPropertiesTop([
        listTotalItemPr.isEmpty ? 0 : listTotalItemPr[0].totalItems!,
        listNumberOrderPr.isEmpty ? 0 : listNumberOrderPr[0].numberOfOrders!,
        listPricePr.isEmpty ? 0 : listPricePr[0].totalPrice!.toInt(),
        listViewPr.isEmpty ? 0 : listViewPr[0].view!,
      ]);
      listProductInChart(
          [listTotalItemPr, listNumberOrderPr, listPricePr, listViewPr]);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
