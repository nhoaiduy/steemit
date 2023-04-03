
import 'package:steemit/generated/l10n.dart';

import 'package:steemit/util/enum/gender_enum.dart';

class GenderHelper {
  static mapEnumToString(Gender gender) {
    if (gender == Gender.male) return S.current.txt_male;
    return S.current.txt_female;

  }

  static mapStringToEnum(String genderString) {
    try {
      return Gender.values.byName(genderString.toLowerCase());
    } catch (e) {
      return Gender.male;
    }
  }
}
