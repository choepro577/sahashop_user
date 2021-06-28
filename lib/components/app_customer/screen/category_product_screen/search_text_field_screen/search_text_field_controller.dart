import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/search_history/all_search_history_response.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';

class SearchTextFiledController extends GetxController {
  var histories = RxList<HistorySearch>();

  SearchTextFiledController() {
    getSearchHistory();
  }

  void addSearchHistory(String? text) async {
    if (text != null && text.length > 0) {
      try {
        await CustomerRepositoryManager.historySearchRepository
            .addHistorySearch(text);
      } catch (err) {}
    }
  }

  void deleteSearchHistory() async {
    try {
      await CustomerRepositoryManager.historySearchRepository
          .deleteHistorySearch();
    } catch (err) {}
  }

  void getSearchHistory() async {
    try {
      var data = await CustomerRepositoryManager.historySearchRepository
          .get10HistorySearch();
      histories(data);
    } catch (err) {}
  }
}
