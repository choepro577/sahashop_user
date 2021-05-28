import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/chat_user.dart';

class AllMessageUserController extends GetxController {
  var isLoadingMessage = false.obs;
  var listChatUser = RxList<ChatUser>();
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  var isSearch = false.obs;

  AllMessageUserController() {
    loadInitChatUser();
  }

  void loadInitChatUser() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    loadMoreChatUser();
  }

  Future<void> loadMoreChatUser() async {
    isLoadingMessage.value = true;
    try {
      var res =
          await RepositoryManager.chatRepository.getAllChatUser(pageLoadMore);
      if (res.data.data == []) {
        isEndPageCombo = true;
      } else {
        listChatUser.addAll(res.data.data);
        pageLoadMore++;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingMessage.value = false;
  }
}
