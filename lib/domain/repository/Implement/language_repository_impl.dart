import 'package:steemit/data/service/language_service.dart';

abstract class LanguageRepositoryInterface {
  changeLanguage({String? languageKey});

  Future<String?> getLanguageKey();
}

class LanguageRepository extends LanguageRepositoryInterface {
  @override
  changeLanguage({String? languageKey}) async {
    if (languageKey != null) {
      languageService.saveLanguageKey(languageKey);
    } else {
      languageService.removeLanguageKey();
    }
  }

  @override
  Future<String?> getLanguageKey() async {
    return await languageService.getLanguageKey();
  }
}
