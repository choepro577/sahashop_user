import 'dart:ui';

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      var a = int.parse(hexColor, radix: 16);
      return a;
    } catch (err) {
      return int.parse("FF93b9b4", radix: 16);
    }
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}

extension ToHexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
