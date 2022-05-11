import 'package:lunasea/vendor.dart';

class LunaValidator {
  const LunaValidator._();

  bool email(String email) {
    const regex = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    return RegExp(regex).hasMatch(email);
  }
}

final validatorProvider = Provider((_) => const LunaValidator._());
