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
}
