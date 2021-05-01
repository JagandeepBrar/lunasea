class LunaValidator {
  static const _EMAIL_REGEX =
      r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";

  /// Validate that a [String] contains an email.
  bool email(String email) => RegExp(_EMAIL_REGEX).hasMatch(email ?? '');
}
