import 'package:sahashop_user/data/remote/response-request/address/address_request.dart';
import 'package:sahashop_user/data/remote/response-request/address/address_respone.dart';
import 'package:sahashop_user/data/remote/response-request/address/all_address_store_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/create_address_store_response.dart';
import 'package:sahashop_user/data/remote/response-request/address/delete_address_store_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class AddressRepository {
  Future<AddressResponse> getProvince() async {
    try {
      var res = await SahaServiceManager().service.getProvince();
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddressResponse> getDistrict(int idProvince) async {
    try {
      var res = await SahaServiceManager().service.getDistrict(idProvince);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddressResponse> getWard(int idDistrict) async {
    try {
      var res = await SahaServiceManager().service.getWard(idDistrict);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateAddressStoreResponse> createAddressStore(
      AddressRequest addressRequest) async {
    try {
      var res = await SahaServiceManager().service.createAddressStore(
            UserInfo().getCurrentStoreCode(),
            addressRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateAddressStoreResponse> updateAddressStore(
      int idAddressStore, AddressRequest addressRequest) async {
    try {
      var res = await SahaServiceManager().service.updateAddressStore(
            UserInfo().getCurrentStoreCode(),
            idAddressStore,
            addressRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteAddressStoreResponse> deleteAddressStore(
      int idAddressStore) async {
    try {
      var res = await SahaServiceManager().service.deleteAddressStore(
            UserInfo().getCurrentStoreCode(),
            idAddressStore,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllAddressStoreResponse> getAllAddressStore() async {
    try {
      var res = await SahaServiceManager().service.getAllAddressStore(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
