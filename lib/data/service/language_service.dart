import 'package:steemit/data/service/local_service_client.dart';
import 'package:steemit/util/constant/shared_preferences_key.dart';

final LanguageService languageService = LanguageService();

class LanguageService {
  saveLanguageKey(String? languageKey) async {
    await LocalServiceClient.save(
        key: SharedPreferencesKey.languageKey, value: languageKey);
  }

  Future<String?> getLanguageKey() async {
    final data = await LocalServiceClient.get(SharedPreferencesKey.languageKey);
    return data;
  }

  removeLanguageKey() async {
    await LocalServiceClient.remove(SharedPreferencesKey.languageKey);
  }
}
