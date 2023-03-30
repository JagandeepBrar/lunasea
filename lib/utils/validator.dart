class LunaValidator {
  bool email(String email) {
    const regex = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    return RegExp(regex).hasMatch(email);
  }
}
