import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/model/product.dart';

import 'widget/distribute_select_controller.dart';
import 'widget/select_images_controller.dart';

class AddProductController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var listCategorySelected = RxList<Category>();
  var listAttribute = RxList<String>();
  var listCategory = RxList<Category>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingAttribute = false.obs;

  var isEdit = false.obs;
  var productEdit = Product().obs;

  var listDistribute = RxList<DistributesRequest>();

  List<ImageData>? listImages = [];
  var uploadingImages = false.obs;

  var attributeData = {}.obs;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  final TextEditingController textEditingControllerPrice =
      new TextEditingController();

  final TextEditingController textEditingControllerQuantityInStock =
      new TextEditingController();

  var description = "".obs;

  AddProductController({Product? productEd}) {
    getAllCategory();
    getAllAttribute();
    if (productEd != null) {
      productEdit(productEd);
      handleIfExistProduct(productEd: productEd);
    }
  }

  Future<bool?> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);

      isLoadingCategory.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }

  void handleIfExistProduct({Product? productEd}) {
    isEdit.value = true;
    textEditingControllerName.text = productEd!.name!;
    textEditingControllerPrice.text = productEd.price.toString();
    textEditingControllerQuantityInStock.text =
        productEd.quantityInStock == null || productEd.quantityInStock! < 0
            ? ""
            : productEd.quantityInStock.toString();
    description.value =
        productEd.description == null ? "" : productEd.description!;

    final DistributeSelectController distributeSelectController = Get.find();

    if (productEd.images != null) {
      listImages = productEd.images!
          .map((e) => ImageData(
              linkImage: e.imageUrl, errorUpload: false, uploading: false))
          .toList();
    }

    if (productEd.categories != null) {
      listCategorySelected.value = productEd.categories!.map((e) => e).toList();
    }

    if (productEd.attributes != null) {
      productEd.attributes!.forEach((element) {
        attributeData[element.name] = element.value;
      });
    }
    if (productEd.distributes != null) {
      listDistribute
          .addAll(productEd.distributes!.map((Distributes? listDistribute) {
        bool boolHasImage = false;
        if (listDistribute!.elementDistributes != null) {
          var listOK = listDistribute.elementDistributes!
              .where((elementDistribute) => elementDistribute.imageUrl != null);

          if (listOK.length > 0) {
            boolHasImage = true;
          }
        }

        return DistributesRequest(
            boolHasImage: boolHasImage,
            name: listDistribute.name,
            elementDistributes: listDistribute.elementDistributes!
                .map((e) => ElementDistributesRequest(
                    name: e.name, imageUrl: e.imageUrl))
                .toList());
      }).toList());

      distributeSelectController.listDistribute(listDistribute);
    }

    refresh();
  }

  void setNewListCategorySelected(List<Category> list) {
    listCategorySelected(list);
  }

  Future<bool?> getAllAttribute() async {
    isLoadingAttribute.value = true;
    try {
      var list =
          await RepositoryManager.attributesRepository.getAllAttributes();
      listAttribute(list!);

      isLoadingAttribute.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAttribute.value = false;
  }

  void setNewListDistribute(List<DistributesRequest> list) {
    List<DistributesRequest> listOK = [];
    listOK = list
        .where((element) =>
            element.name != null &&
            element.elementDistributes != null &&
            element.elementDistributes!.length > 0)
        .toList();

    listDistribute(listOK);
    refresh();
  }

  void setNewListAttribute(List<String> list) {
    listAttribute(list);
    var newData = {};
    list.forEach((element) {
      newData[element] = attributeData[element];
    });
    attributeData(newData);
  }

  void addValueToMapAttribute(String key, String value) {
    attributeData[key] = value;
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<bool?> createProduct({int status = 0}) async {
    try {
      isLoadingAdd.value = true;
      productRequest.categories =
          listCategorySelected.map((element) => element.id!).toList();
      productRequest.images = listImages == null
          ? []
          : listImages!.map((e) => e.linkImage!).toList();

      productRequest.description = description.value;
      productRequest.status = status;

      List<ListAttribute> listAttributeRequest = [];
      attributeData.keys.forEach((key) {
        if (key != null && attributeData[key] != null) {
          listAttributeRequest
              .add(ListAttribute(name: key, value: attributeData[key]));
        }
      });

      productRequest.listAttribute = listAttributeRequest;
      final DistributeSelectController distributeSelectController = Get.find();
      productRequest.listDistribute =
          distributeSelectController.listDistribute.toList();

      productRequest.price = double.tryParse(textEditingControllerPrice.text);
      productRequest.name = textEditingControllerName.text;
      if (textEditingControllerQuantityInStock.text.length > 0) {
        productRequest.quantityInStock =
            int.tryParse(textEditingControllerQuantityInStock.text);
      }

      if (isEdit.value == false) {
        var data =
            await RepositoryManager.productRepository.create(productRequest);
        SahaAlert.showSuccess(message: "Thêm thành công");
        Navigator.pop(Get.context!, "added");
      } else {
        var data = await RepositoryManager.productRepository
            .update(productEdit.value.id!, productRequest);
        SahaAlert.showSuccess(message: "Cập nhật thành công");
        Navigator.pop(Get.context!, {"update": data});
      }

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      isLoadingAdd.value = false;
    }
    isLoadingAdd.value = false;
  }
}
