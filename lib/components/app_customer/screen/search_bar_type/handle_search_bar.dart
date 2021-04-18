import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/search_screen/search_screen.dart';

class HandleSearchBar {
  static void onSearch(String text) {
    Get.to(SearchScreen(
      searchText: text,
    ));
  }
}
