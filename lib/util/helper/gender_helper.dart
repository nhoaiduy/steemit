import 'package:steemit/util/enum/gender_enum.dart';

class GenderHelper {
  static mapEnumToString(Gender gender) {
    if (gender == Gender.male) return "Male";
    return "Female";
  }

  static mapStringToEnum(String genderString) {
    try {
      return Gender.values.byName(genderString.toLowerCase());
    } catch (e) {
      return Gender.male;
    }
  }
}
