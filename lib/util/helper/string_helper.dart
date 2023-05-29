import 'package:steemit/generated/l10n.dart';

class StringHelper {
  static String createNameKey(String name) {
    if (name.isEmpty) return "";
    String result = name[0];
    for (int i = 0; i < name.length - 1; i++) {
      if (name[i] == " " && name[i + 1] != " ") result += name[i + 1];
    }
    if (result.length > 2) result = result.substring(0, 2);
    return result.toUpperCase();
  }

  static String formatDate(String date) {
    String d = date.substring(8, 10);
    String m = date.substring(5, 7);
    String y = date.substring(0, 4);
    return "$d/$m/$y";
  }

  static String getDifference(Duration duration) {
    int difference = duration.inDays;
    if (difference > 365) {
      return "${difference ~/ 365} ${S.current.txt_y}";
    }
    if (difference > 7) {
      return "${difference ~/ 7} ${S.current.txt_w}";
    }
    if (difference > 0) {
      return "$difference ${S.current.txt_d}";
    }
    difference = duration.inHours;
    if (difference > 0) {
      return "$difference ${S.current.txt_h}";
    }
    difference = duration.inMinutes;
    if (difference > 0) {
      return "$difference ${S.current.txt_m}";
    }
    return S.current.txt_just_now;
  }
}
