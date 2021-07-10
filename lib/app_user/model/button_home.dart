import 'dart:convert';


HomeButton homeButtonFromJson(String str) =>
    HomeButton.fromJson(json.decode(str));

String homeButtonToJson(HomeButton data) => json.encode(data.toJson());

class HomeButton {
  HomeButton({
    this.title,
    this.typeAction,
    this.imageUrl,
    this.value,
  });

  String? title;
  String? typeAction;
  String? imageUrl;
  String? value;

  factory HomeButton.fromJson(Map<String, dynamic> json) => HomeButton(
        title: json["title"],
        typeAction: json["type_action"],
        imageUrl: json["image_url"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type_action": typeAction,
        "image_url": imageUrl,
        "value": value,
      };
}
