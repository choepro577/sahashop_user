import 'auth/auth_service.dart';
import 'createShop/create_service.dart';
import 'device/device.dart';

class RemoteManager {
  static AuthService get authService => AuthService();
  static DeviceService get deviceService => DeviceService();
  static CreateShopService get createShopService => CreateShopService();
}