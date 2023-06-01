import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/enum/activity_enum.dart';

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

  static String getActivityString(ActivityEnum type) {
    switch (type) {
      case ActivityEnum.comment:
        return S.current.txt_commented;
      case ActivityEnum.like:
        return S.current.txt_liked;
      case ActivityEnum.post:
        return S.current.txt_post;
      case ActivityEnum.save:
        return S.current.txt_saved;
      case ActivityEnum.unlike:
        return S.current.txt_unliked;
      case ActivityEnum.unsave:
        return S.current.txt_unsaved;
    }
  }
}
