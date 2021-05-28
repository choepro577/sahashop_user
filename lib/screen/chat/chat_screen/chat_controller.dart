import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_request.dart';
import 'package:sahashop_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/chat_user.dart';
import 'package:sahashop_user/model/message.dart';
import 'package:sahashop_user/screen/config_app/screens_config/header_config/image_carousel/select_image_carousel_controller.dart';
import 'package:sahashop_user/utils/image_utils.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  ChatUser chatUser;

  ChatController({this.chatUser}) {
    loadInitMessage();
  }

  var messageEditingController = new TextEditingController(text: "").obs;
  var isLoadingMessage = false.obs;
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  var isInput = false.obs;
  var listMessage = RxList<Message>();

  void loadInitMessage() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    loadMoreMessage();
  }

  Future<void> loadMoreMessage() async {
    isLoadingMessage.value = true;
    try {
      if (!isEndPageCombo) {
        var res = await RepositoryManager.chatRepository
            .getAllMessageUser(chatUser.customerId, pageLoadMore);
        listMessage.addAll(res.data.data);
        if (res.data.nextPageUrl != null) {
          pageLoadMore++;
          isEndPageCombo = false;
        } else {
          isEndPageCombo = true;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingMessage.value = false;
  }

  Future<SendMessageResponse> sendMessageToCustomer() async {
    try {
      var res = await RepositoryManager.chatRepository.sendMessageToCustomer(
          chatUser.customerId,
          SendMessageRequest(
            content: messageEditingController.value.text,
          ));
      listMessage.insert(
          0,
          Message(
            isUser: true,
            content: messageEditingController.value.text,
          ));
      messageEditingController.value.text = "";
      messageEditingController.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
