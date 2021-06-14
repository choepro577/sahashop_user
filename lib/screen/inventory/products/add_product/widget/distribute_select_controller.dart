import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/product.dart';

class DistributeSelectController extends GetxController {
  var listDistribute = RxList<Distributes>();
  var stringTextSuggestion = "";

  final listSuggestion = [
    "Kích thước",
    "Màu sắc",
    "Kiểu dáng",
    "Tạo thêm phân loại"
  ];

  DistributeSelectController() {
    //addDistribute(listSuggestion[0]);
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


  void addDistribute(String name) {
    if (name == null) {
      var name = getNameNewDistribute();

      listDistribute.add(Distributes(name: name, elementDistributes: []));
      return;
    }

    for (var element in listDistribute) {
      if (element.name == name) {
        SahaAlert.showError(message: "Thuộc tính này đã thêm từ trước");
        return;
      }
    }

    listDistribute.add(Distributes(name: name, elementDistributes: []));
  }

  void addElementDistribute(int indexDistribute, String name) {
    if (listDistribute[indexDistribute] != null) {
      if (listDistribute[indexDistribute]
          .elementDistributes
          .map((e) => e.name)
          .contains(name)) {
        SahaAlert.showWarning(message: "Thuộc tính đã có");
        return;
      }
      listDistribute[indexDistribute].elementDistributes.add(ElementDistributes(name: name));
    }
  }

  void removeElementDistribute(int indexDistribute, Distributes distributes) {
    listDistribute[indexDistribute].elementDistributes.remove(distributes);
  }

  void refresh() {
    listDistribute.refresh();
  }

  List<String> getListStringBuild(Distributes details) {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDistribute.map((detail) => detail.name).contains(text));

    listNew.insert(0, details.name);
    if (!listNew.contains(listSuggestion.last)) {
      listNew.add(listSuggestion.last);
    }
    return listNew;
  }

  String getNameNewDistribute() {
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

     if( listCompare.map((element) => element.name).toList().contains(itemDistribute.name)) {

       SahaAlert.showWarning(message: "Có các phân loại trùng nhau xin kiểm tra lại");
       return false;
     }

    }

    for (var itemDistribute in listDistribute) {
      if(itemDistribute.name == null || itemDistribute.name =="") {

        SahaAlert.showWarning(message: "Có các phân loại chưa nhập tên, xin kiểm tra lại");
        return false;
      }

    }
    return true;
  }


  List<Distributes> getFinalDistribute() {
    var listRT =  listDistribute.toList()..removeWhere((element) {
      return (element.name == null || element.name == "" ||
          element.elementDistributes == null ||element.elementDistributes.length==0);
    });
    return listRT;
  }
}
