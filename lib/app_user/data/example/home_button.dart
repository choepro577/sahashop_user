import 'package:sahashop_user/app_customer/screen_can_edit/home_buttons/list_home_button_controller.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';


List<HomeButton> LIST_HOME_BUTTON_EXAMPLE = [
  HomeButton(
    title: "Chat với cửa hàng",
    typeAction: mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]
  ),
  HomeButton(
      title: "Sản phẩm",
      typeAction: mapTypeAction[TYPE_ACTION.PRODUCT],
    imageUrl: "https://i.imgur.com/hESDRss.jpeg"
  ),
];
