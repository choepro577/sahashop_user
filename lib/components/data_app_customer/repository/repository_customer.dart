import 'package:sahashop_user/components/data_app_customer/repository/category/category_repository.dart';
import 'package:sahashop_user/components/data_app_customer/repository/config_app/config_ui_respository.dart';

class CustomerRepositoryManager {
  static CategoryRepository get categoryRepository => CategoryRepository();
  static ConfigUICustomerRepository get configUiRepository =>
      ConfigUICustomerRepository();
}
