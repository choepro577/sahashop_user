import 'dart:ui';

TextStyle getCustomFont(int color, double fontSize, String fontName) {
  return new TextStyle(
      // set color of text
      color: Color(color),
      // set the font family as defined in pubspec.yaml
      fontFamily: fontName,
      // set the font weight
      fontWeight: FontWeight.w400,
      // set the font size
      fontSize: fontSize);
}
