import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/utils/image_utils.dart';

class DistributeSelectController extends GetxController {
  var listDistribute = RxList<DistributesRequest>();
  var stringTextSuggestion = "";

  final listSuggestion = [
    "Kích thước",
    "Màu sắc",
    "Kiểu dáng",
    "Tạo thêm phân loại"
  ];

  DistributeSelectController() {
    addDistribute(listSuggestion[0]);
    addDistribute(listSuggestion[1]);
    addDistribute(listSuggestion[2]);
  }

  void editNameDistribute(int indexDistribute, String name) {
    if (listDistribute[indexDistribute] != null) {
      if (listDistribute.map((e) => e.name).contains(name)) {
        SahaAlert.showWarning(message: "Phân loại đã có");
        return;
      }
      var newDistribute = listDistribute[indexDistribute];
      newDistribute.name = name;

      listDistribute[indexDistribute] = newDistribute;
    }
  }

  void removeDistribute(int indexDistribute) {
    listDistribute.remove(listDistribute[indexDistribute]);
  }

  void toggleHasImage(int indexDistribute) {
    if (listDistribute[indexDistribute] != null) {
      var newDistribute = listDistribute[indexDistribute];
      newDistribute.boolHasImage = !newDistribute.boolHasImage!;
      listDistribute[indexDistribute] = newDistribute;
    }
  }

  void chooseImage(DistributesRequest? distributes,
      ElementDistributesRequest? elementDistributes) async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.getImage(source: ImageSource.gallery))!;
      var file = File(pickedFile.path);
      var fileUp = await ImageUtils.getImageCompress(file);

      var link = await RepositoryManager.imageRepository.uploadImage(fileUp);

      var indexElement = listDistribute[listDistribute.indexOf(distributes)]
          .elementDistributes!
          .indexOf(elementDistributes);
      listDistribute[listDistribute.indexOf(distributes)]
          .elementDistributes![indexElement]!
          .imageUrl = link;

      listDistribute.refresh();
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }

  }

  void addDistribute(String? name) {
    if (name == null) {
      var name = getNameNewDistribute();

      listDistribute.add(DistributesRequest(
          name: name, elementDistributes: [], boolHasImage: false));
      return;
    }

    for (var element in listDistribute) {
      if (element.name == name) {
        SahaAlert.showError(message: "Phân loại này đã có");
        return;
      }
    }

    listDistribute.add(DistributesRequest(
        name: name, elementDistributes: [], boolHasImage: false));
  }

  void addElementDistribute(int indexDistribute, String name) {
    if (listDistribute[indexDistribute] != null) {
      if (listDistribute[indexDistribute]
          .elementDistributes!
          .map((e) => e!.name)
          .contains(name)) {
        SahaAlert.showWarning(message: "Thuộc tính đã có");
        return;
      }
      listDistribute[indexDistribute]
          .elementDistributes!
          .add(ElementDistributesRequest(name: name));
    }
  }

  void removeElementDistribute(
      int indexDistribute, ElementDistributesRequest distributes) {
    listDistribute[indexDistribute].elementDistributes!.remove(distributes);
  }

  void refresh() {
    listDistribute.refresh();
  }

  List<String?> getListStringBuild(Distributes details) {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDistribute.map((detail) => detail.name).contains(text));

    listNew.insert(0, details.name!);
    if (!listNew.contains(listSuggestion.last)) {
      listNew.add(listSuggestion.last);
    }
    return listNew;
  }

  String? getNameNewDistribute() {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDistribute.map((detail) => detail.name).contains(text));

    if (listNew.length == 0) {
      return listSuggestion.last;
    }

    return listNew.first;
  }

  bool checkValidParam() {
    for (var itemDistribute in listDistribute) {
      var listCompare = listDistribute.toList()..remove(itemDistribute);

      if (listCompare
          .map((element) => element.name)
          .toList()
          .contains(itemDistribute.name)) {
        SahaAlert.showWarning(
            message: "Có các phân loại trùng nhau xin kiểm tra lại");
        return false;
      }
    }

    for (var itemDistribute in listDistribute) {
      if (itemDistribute.name == null || itemDistribute.name == "") {
        SahaAlert.showWarning(
            message: "Có các phân loại chưa nhập tên, xin kiểm tra lại");
        return false;
      }
    }
    return true;
  }

  List<DistributesRequest> getFinalDistribute() {
    var listRT = listDistribute.toList()
      ..removeWhere((element) {
        return (element.name == null ||
            element.name == "" ||
            element.elementDistributes == null ||
            element.elementDistributes!.length == 0);
      });
    return listRT.toList();
  }
}
