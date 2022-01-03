import 'package:lunasea/core.dart';

String lunaSafeString(
  String? string, {
  bool isEmptySafe = false,
}) {
  if (string == null) return LunaUI.TEXT_EMDASH;
  if (!isEmptySafe && string.isEmpty) return LunaUI.TEXT_EMDASH;
  return string;
}
