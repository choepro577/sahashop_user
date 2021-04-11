
import 'dart:convert';

ConfigApp configAppFromJson(String str) => ConfigApp.fromJson(json.decode(str));

String configAppToJson(ConfigApp data) => json.encode(data.toJson());

class ConfigApp {
  ConfigApp({
    this.logoUrl,
    this.isShowLogo,
    this.colorMain1,
    this.colorMain2,
    this.fontFamily,
    this.fontColorAllPage,
    this.fontColorTitle,
    this.fontColorMain,
    this.iconHotline,
    this.isShowIconHotline,
    this.colorIconHotline,
    this.noteIconHotline,
    this.phoneNumberHotline,
    this.iconEmail,
    this.isShowIconEmail,
    this.colorIconEmail,
    this.titlePopupIconEmail,
    this.titlePopupSuccessIconEmail,
    this.bodyEmailSuccessIconEmail,
    this.iconFacebook,
    this.isShowIconFacebook,
    this.colorIconFacebook,
    this.noteIconFacebook,
    this.idFacebook,
    this.iconZalo,
    this.isShowIconZalo,
    this.colorIconZalo,
    this.noteIconZalo,
    this.idZalo,
    this.headerType,
    this.colorBackgroundHeader,
    this.colorTextHeader,
    this.typeOfMenu,
    this.typeNavigator,
    this.searchType,
    this.searchBackgroundHeader,
    this.searchTextHeader,
    this.carouselType,
    this.homeIdCarouselAppImage,
    this.homeListCategoryIsShow,
    this.homeIdListCategoryAppImage,
    this.homeTopIsShow,
    this.homeTopText,
    this.homeTopColor,
    this.homeCarouselIsShow,
    this.homePageType,
    this.categoryPageType,
    this.productPageType,
    this.isShowSameProduct,
    this.contactPageType,
    this.contactGoogleMap,
    this.contactAddress,
    this.contactEmail,
    this.contactPhoneNumber,
    this.contactTimeWork,
    this.contactInfoBank,
    this.cartPageType,
  });

  String logoUrl;
  bool isShowLogo;
  String colorMain1;
  String colorMain2;
  String fontFamily;
  String fontColorAllPage;
  String fontColorTitle;
  String fontColorMain;
  String iconHotline;
  bool isShowIconHotline;
  String colorIconHotline;
  String noteIconHotline;
  String phoneNumberHotline;
  String iconEmail;
  bool isShowIconEmail;
  String colorIconEmail;
  String titlePopupIconEmail;
  String titlePopupSuccessIconEmail;
  String bodyEmailSuccessIconEmail;
  String iconFacebook;
  bool isShowIconFacebook;
  String colorIconFacebook;
  String noteIconFacebook;
  String idFacebook;
  String iconZalo;
  bool isShowIconZalo;
  String colorIconZalo;
  String noteIconZalo;
  String idZalo;
  int headerType;
  String colorBackgroundHeader;
  String colorTextHeader;
  int typeOfMenu;
  int typeNavigator;
  int searchType;
  String searchBackgroundHeader;
  String searchTextHeader;
  int carouselType;
  dynamic homeIdCarouselAppImage;
  bool homeListCategoryIsShow;
  dynamic homeIdListCategoryAppImage;
  bool homeTopIsShow;
  dynamic homeTopText;
  dynamic homeTopColor;
  bool homeCarouselIsShow;
  int homePageType;
  int categoryPageType;
  int productPageType;
  bool isShowSameProduct;
  int contactPageType;
  String contactGoogleMap;
  String contactAddress;
  String contactEmail;
  String contactPhoneNumber;
  String contactTimeWork;
  String contactInfoBank;
  int cartPageType;

  factory ConfigApp.fromJson(Map<String, dynamic> json) => ConfigApp(
    logoUrl: json["logo_url"],
    isShowLogo: json["is_show_logo"],
    colorMain1: json["color_main_1"],
    colorMain2: json["color_main_2"],
    fontFamily: json["font_family"],
    fontColorAllPage: json["font_color_all_page"],
    fontColorTitle: json["font_color_title"],
    fontColorMain: json["font_color_main"],
    iconHotline: json["icon_hotline"],
    isShowIconHotline: json["is_show_icon_hotline"],
    colorIconHotline: json["color_icon_hotline"],
    noteIconHotline: json["note_icon_hotline"],
    phoneNumberHotline: json["phone_number_hotline"],
    iconEmail: json["icon_email"],
    isShowIconEmail: json["is_show_icon_email"],
    colorIconEmail: json["color_icon_email"],
    titlePopupIconEmail: json["title_popup_icon_email"],
    titlePopupSuccessIconEmail: json["title_popup_success_icon_email"],
    bodyEmailSuccessIconEmail: json["body_email_success_icon_email"],
    iconFacebook: json["icon_facebook"],
    isShowIconFacebook: json["is_show_icon_facebook"],
    colorIconFacebook: json["color_icon_facebook"],
    noteIconFacebook: json["note_icon_facebook"],
    idFacebook: json["id_facebook"],
    iconZalo: json["icon_zalo"],
    isShowIconZalo: json["is_show_icon_zalo"],
    colorIconZalo: json["color_icon_zalo"],
    noteIconZalo: json["note_icon_zalo"],
    idZalo: json["id_zalo"],
    headerType: json["header_type"],
    colorBackgroundHeader: json["color_background_header"],
    colorTextHeader: json["color_text_header"],
    typeOfMenu: json["type_of_menu"],
    typeNavigator: json["type_navigator"],
    searchType: json["search_type"],
    searchBackgroundHeader: json["search_background_header"],
    searchTextHeader: json["search_text_header"],
    carouselType: json["carousel_type"],
    homeIdCarouselAppImage: json["home_id_carousel_app_image"],
    homeListCategoryIsShow: json["home_list_category_is_show"],
    homeIdListCategoryAppImage: json["home_id_list_category_app_image"],
    homeTopIsShow: json["home_top_is_show"],
    homeTopText: json["home_top_text"],
    homeTopColor: json["home_top_color"],
    homeCarouselIsShow: json["home_carousel_is_show"],
    homePageType: json["home_page_type"],
    categoryPageType: json["category_page_type"],
    productPageType: json["product_page_type"],
    isShowSameProduct: json["is_show_same_product"],
    contactPageType: json["contact_page_type"],
    contactGoogleMap: json["contact_google_map"],
    contactAddress: json["contact_address"],
    contactEmail: json["contact_email"],
    contactPhoneNumber: json["contact_phone_number"],
    contactTimeWork: json["contact_time_work"],
    contactInfoBank: json["contact_info_bank"],
    cartPageType: json["cart_page_type"],
  );

  Map<String, dynamic> toJson() => {
    "logo_url": logoUrl,
    "is_show_logo": isShowLogo,
    "color_main_1": colorMain1,
    "color_main_2": colorMain2,
    "font_family" : fontFamily,
    "font_color_all_page": fontColorAllPage,
    "font_color_title": fontColorTitle,
    "font_color_main": fontColorMain,
    "icon_hotline": iconHotline,
    "is_show_icon_hotline": isShowIconHotline,
    "color_icon_hotline": colorIconHotline,
    "note_icon_hotline": noteIconHotline,
    "phone_number_hotline": phoneNumberHotline,
    "icon_email": iconEmail,
    "is_show_icon_email": isShowIconEmail,
    "color_icon_email": colorIconEmail,
    "title_popup_icon_email": titlePopupIconEmail,
    "title_popup_success_icon_email": titlePopupSuccessIconEmail,
    "body_email_success_icon_email": bodyEmailSuccessIconEmail,
    "icon_facebook": iconFacebook,
    "is_show_icon_facebook": isShowIconFacebook,
    "color_icon_facebook": colorIconFacebook,
    "note_icon_facebook": noteIconFacebook,
    "id_facebook": idFacebook,
    "icon_zalo": iconZalo,
    "is_show_icon_zalo": isShowIconZalo,
    "color_icon_zalo": colorIconZalo,
    "note_icon_zalo": noteIconZalo,
    "id_zalo": idZalo,
    "header_type": headerType,
    "color_background_header": colorBackgroundHeader,
    "color_text_header": colorTextHeader,
    "type_of_menu": typeOfMenu,
    "type_navigator": typeNavigator,
    "search_type": searchType,
    "search_background_header": searchBackgroundHeader,
    "search_text_header": searchTextHeader,
    "carousel_type": carouselType,
    "home_id_carousel_app_image": homeIdCarouselAppImage,
    "home_list_category_is_show": homeListCategoryIsShow,
    "home_id_list_category_app_image": homeIdListCategoryAppImage,
    "home_top_is_show": homeTopIsShow,
    "home_top_text": homeTopText,
    "home_top_color": homeTopColor,
    "home_carousel_is_show": homeCarouselIsShow,
    "home_page_type": homePageType,
    "category_page_type": categoryPageType,
    "product_page_type": productPageType,
    "is_show_same_product": isShowSameProduct,
    "contact_page_type": contactPageType,
    "contact_google_map": contactGoogleMap,
    "contact_address": contactAddress,
    "contact_email": contactEmail,
    "contact_phone_number": contactPhoneNumber,
    "contact_time_work": contactTimeWork,
    "contact_info_bank": contactInfoBank,
    "cart_page_type": cartPageType,
  };
}
