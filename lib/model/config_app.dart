import 'dart:convert';

ConfigApp configAppFromJson(String str) => ConfigApp.fromJson(json.decode(str));

String configAppToJson(ConfigApp data) => json.encode(data.toJson());

class ConfigApp {
  ConfigApp({
    this.userId,
    this.logoUrl,
    this.isShowLogo,
    this.colorMain1,
    this.colorMain2,
    this.fontColorAllPage,
    this.fontColorTitle,
    this.fontColorMain,
    this.typeOfMenu,
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
    this.searchType,
    this.searchBackgroundHeader,
    this.searchTextHeader,
    this.homeTopIsShow,
    this.homeTopText,
    this.homeTopColor,
    this.homeCarouselIsShow,
    this.homeIdCarouselAppImage,
    this.homeListCategoryIsShow,
    this.homeIdListCategoryAppImage,
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

  int userId;
  String logoUrl;
  bool isShowLogo;
  String colorMain1;
  String colorMain2;
  String fontColorAllPage;
  String fontColorTitle;
  String fontColorMain;
  int typeOfMenu;
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
  int searchType;
  String searchBackgroundHeader;
  String searchTextHeader;
  bool homeTopIsShow;
  String homeTopText;
  String homeTopColor;
  bool homeCarouselIsShow;
  int homeIdCarouselAppImage;
  dynamic homeListCategoryIsShow;
  dynamic homeIdListCategoryAppImage;
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
        userId: json["user_id"] ?? null,
        logoUrl: json["logo_url"] ?? null,
        isShowLogo: json["is_show_logo"] ?? null,
        colorMain1: json["color_main_1"] ?? null,
        colorMain2: json["color_main_2"] ?? null,
        fontColorAllPage: json["font_color_all_page"] ?? null,
        fontColorTitle: json["font_color_title"] ?? null,
        fontColorMain: json["font_color_main"] ?? null,
        typeOfMenu: json["type_of_menu"],
        iconHotline: json["icon_hotline"] ?? null,
        isShowIconHotline: json["is_show_icon_hotline"] ?? null,
        colorIconHotline: json["color_icon_hotline"] ?? null,
        noteIconHotline: json["note_icon_hotline"] ?? null,
        phoneNumberHotline: json["phone_number_hotline"] ?? null,
        iconEmail: json["icon_email"] ?? null,
        isShowIconEmail: json["is_show_icon_email"] ?? null,
        colorIconEmail: json["color_icon_email"] ?? null,
        titlePopupIconEmail: json["title_popup_icon_email"] ?? null,
        titlePopupSuccessIconEmail:
            json["title_popup_success_icon_email"] ?? null,
        bodyEmailSuccessIconEmail:
            json["body_email_success_icon_email"] ?? null,
        iconFacebook: json["icon_facebook"] ?? null,
        isShowIconFacebook: json["is_show_icon_facebook"] ?? null,
        colorIconFacebook: json["color_icon_facebook"] ?? null,
        noteIconFacebook: json["note_icon_facebook"] ?? null,
        idFacebook: json["id_facebook"] ?? null,
        iconZalo: json["icon_zalo"] ?? null,
        isShowIconZalo: json["is_show_icon_zalo"] ?? null,
        colorIconZalo: json["color_icon_zalo"] ?? null,
        noteIconZalo: json["note_icon_zalo"] ?? null,
        idZalo: json["id_zalo"] ?? null,
        headerType: json["header_type"],
        colorBackgroundHeader: json["color_background_header"] ?? null,
        colorTextHeader: json["color_text_header"] ?? null,
        searchType: json["search_type"],
        searchBackgroundHeader: json["search_background_header"] ?? null,
        searchTextHeader: json["search_text_header"] ?? null,
        homeTopIsShow: json["home_top_is_show"] ?? null,
        homeTopText: json["home_top_text"] ?? null,
        homeTopColor: json["home_top_color"] ?? null,
        homeCarouselIsShow: json["home_carousel_is_show"] ?? null,
        homeIdCarouselAppImage: json["home_id_carousel_app_image"],
        homeListCategoryIsShow: json["home_list_category_is_show"] ?? null,
        homeIdListCategoryAppImage:
            json["home_id_list_category_app_image"] ?? null,
        categoryPageType: json["category_page_type"],
        productPageType: json["product_page_type"],
        isShowSameProduct: json["is_show_same_product"] ?? null,
        contactPageType: json["contact_page_type"],
        contactGoogleMap: json["contact_google_map"] ?? null,
        contactAddress: json["contact_address"] ?? null,
        contactEmail: json["contact_email"] ?? null,
        contactPhoneNumber: json["contact_phone_number"] ?? null,
        contactTimeWork: json["contact_time_work"] ?? null,
        contactInfoBank: json["contact_info_bank"] ?? null,
        cartPageType: 1,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId ?? 1,
        "logo_url": logoUrl,
        "is_show_logo": isShowLogo,
        "color_main_1": colorMain1,
        "color_main_2": colorMain2,
        "font_color_all_page": fontColorAllPage,
        "font_color_title": fontColorTitle,
        "font_color_main": fontColorMain,
        "type_of_menu": typeOfMenu ?? 0,
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
        "header_type": headerType ?? 0,
        "color_background_header": colorBackgroundHeader,
        "color_text_header": colorTextHeader,
        "search_type": searchType ?? 0,
        "search_background_header": searchBackgroundHeader,
        "search_text_header": searchTextHeader,
        "home_top_is_show": homeTopIsShow,
        "home_top_text": homeTopText,
        "home_top_color": homeTopColor,
        "home_carousel_is_show": homeCarouselIsShow,
        "home_id_carousel_app_image": homeIdCarouselAppImage ?? 0,
        "home_list_category_is_show": homeListCategoryIsShow,
        "home_id_list_category_app_image": homeIdListCategoryAppImage,
        "category_page_type": categoryPageType ?? 0,
        "product_page_type": productPageType ?? 0,
        "is_show_same_product": isShowSameProduct,
        "contact_page_type": contactPageType ?? 0,
        "contact_google_map": contactGoogleMap,
        "contact_address": contactAddress,
        "contact_email": contactEmail,
        "contact_phone_number": contactPhoneNumber,
        "contact_time_work": contactTimeWork,
        "contact_info_bank": contactInfoBank,
        "cart_page_type": cartPageType ?? 0,
      };
}
