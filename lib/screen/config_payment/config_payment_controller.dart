import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

class ConfigPaymentController extends GetxController {
  var listNamePaymentMethod = RxList<String?>();
  var listUsePaymentMethod = RxList<bool?>();
  var listIdPaymentMethod = RxList<int?>();
  var listDefineField = RxList<List<dynamic>?>();
  var listFieldResponse = RxList<List<dynamic>?>();
  var listFieldRequest = RxList<Map<String, dynamic>>();
  var listTextEditingController = RxList<List<TextEditingController>>();

  ConfigPaymentController() {
    getPaymentMethod();
  }

  Future<void> getPaymentMethod() async {
    try {
      var res = await RepositoryManager.paymentRepository.getPaymentMethod();
      res!.data!.forEach((element) {
        listNamePaymentMethod.add(element["name"]);
        listUsePaymentMethod.add(element["use"]);
        listIdPaymentMethod.add(element["id"]);
        listDefineField.add(element["define_field"]);
        listFieldResponse.add(element["field"]);
      });

      listFieldResponse.forEach((e) {
        var listItemInput = Map<String, dynamic>();
        var listEditingController = RxList<TextEditingController>();
        e!.forEach((item) {
          listItemInput[item] = "nothing";
        });
        listItemInput.forEach((key, value) {
          listEditingController.add(new TextEditingController());
        });
        listEditingController.add(new TextEditingController());
        listTextEditingController.add(listEditingController);
        listFieldRequest.add(listItemInput);
      });
      print(listFieldRequest);
    } catch (err) {
      print(err);
      SahaAlert.showError(message: err.toString());
    }
  }

  void resetData() {
    listNamePaymentMethod([]);
    listUsePaymentMethod([]);
    listIdPaymentMethod([]);
    listDefineField([]);
    listFieldResponse([]);
    listTextEditingController([]);
    listFieldRequest([]);
    getPaymentMethod();
  }

  Future<void> upDatePaymentMethod(
      int? idPaymentMethod, Map<String, dynamic> body, bool use) async {
    try {
      body["use"] = use;
      var res = await RepositoryManager.paymentRepository
          .upDatePaymentMethod(idPaymentMethod, body);
      if (use == true) {
        Get.back();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    resetData();
  }
}
