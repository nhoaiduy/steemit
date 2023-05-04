import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/path/image_path.dart';

class Language {
  Language({this.key, required this.name, required this.imageIconPath});

  final String? key;
  final String name;
  final String imageIconPath;

  static List<Language> languages() {
    return [
      Language(
          name: S.current.txt_system_language,
          imageIconPath: ImagePath.systemLanguageFlag),
      Language(
          key: "vi", name: "Tiếng Việt", imageIconPath: ImagePath.vietnamFlag),
      Language(key: "en", name: "English", imageIconPath: ImagePath.ukFlag),
    ];
  }
}
