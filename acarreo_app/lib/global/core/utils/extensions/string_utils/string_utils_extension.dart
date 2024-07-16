import 'package:remove_diacritic/remove_diacritic.dart';

extension StringUtilsExtension on String {
  String replaceDiacritics() {
    return removeDiacritics(this);
  }
}
