import 'package:sahashop_user/data/remote/response/marketing_chanel_response/discount/create_discount_respone.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/discount/end_discount_response.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/voucher/create_voucher_reponse.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/delete_voucher_discount_response.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/discount/my_program_reponse.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/voucher/end_voucher_response.dart';
import 'package:sahashop_user/data/remote/response/marketing_chanel_response/voucher/my_voucher_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/voucher_request.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class MarketingChanelRepository {
  Future<CreateDiscountResponse> createDiscount(
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    int value,
    bool setLimitedAmount,
    int amount,
    String listIdProduct,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service
          .createDiscount(UserInfo().getCurrentStoreCode(), {
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "value": value,
        "set_limit_amount": setLimitedAmount,
        "amount": amount,
        "product_ids": listIdProduct,
      });

      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MyProgramResponse> updateDiscount(
    int idDiscount,
    bool isEnd,
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    int value,
    bool setLimitedAmount,
    int amount,
    String listIdProduct,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service
          .updateDiscount(UserInfo().getCurrentStoreCode(), idDiscount, {
        "is_end": isEnd,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "value": value,
        "set_limit_amount": setLimitedAmount,
        "amount": amount,
        "product_ids": listIdProduct,
      });
      return res;
    } catch (err) {}
  }

  Future<MyProgramResponse> getAllDiscount() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAllDisCount(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MyVoucherResponse> getAllVoucher() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAllVoucher(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndVoucherResponse> getEndVoucherFromPage(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service
          .getEndVoucherFromPage(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndDiscountResponse> getEndDiscountFromPage(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service
          .getEndDiscountFromPage(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteDisCountVoucherResponse> deleteDiscount(int idDiscount) async {
    try {
      var res = await SahaServiceManager()
          .service
          .deleteDiscount(UserInfo().getCurrentStoreCode(), idDiscount);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteDisCountVoucherResponse> deleteVoucher(int idVoucher) async {
    try {
      var res = await SahaServiceManager()
          .service
          .deleteVoucher(UserInfo().getCurrentStoreCode(), idVoucher);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateVoucherResponse> createVoucher(
      VoucherRequest voucherRequest) async {
    try {
      var res = await SahaServiceManager().service.createVoucher(
          UserInfo().getCurrentStoreCode(), voucherRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateVoucherResponse> updateVoucher(
      int idVoucher, VoucherRequest voucherRequest) async {
    try {
      var res = await SahaServiceManager().service.updateVoucher(
          UserInfo().getCurrentStoreCode(), idVoucher, voucherRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
