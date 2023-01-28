import 'package:flutter/services.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

extension StringNullableExtension on String? {
  /// Return a "UI-Safe" string by replacing null or empty (if considered unsafe) strings with a dash.
  String uiSafe({
    bool isEmptySafe = false,
  }) {
    if (this == null) return LunaUI.TEXT_EMDASH;
    if (!isEmptySafe && this!.isEmpty) return LunaUI.TEXT_EMDASH;
    return this!;
  }
}

extension StringExtension on String {
  /// Returns the string converted to title case.
  ///
  /// Example: "hello world" -> "Hello World"
  String toTitleCase({
    String delimiter = ' ',
  }) {
    if (isEmpty) return '';

    final split = this.split(delimiter);
    for (var i = 0; i < split.length; i++) {
      String word = split[i];
      if (word.length == 1) {
        word = word.toUpperCase();
      } else {
        word = word[0].toUpperCase() + word.substring(1);
      }
      split[i] = word;
    }
    return split.join(delimiter);
  }

  /// Set the current clipboard content to this string.
  Future<void> copyToClipboard({
    bool showSnackBar = true,
  }) async {
    await Clipboard.setData(ClipboardData(text: this));
    if (showSnackBar) {
      showLunaSuccessSnackBar(
        title: 'lunasea.Copied'.tr(),
        message: 'lunasea.CopiedContentToTheClipboard'.tr(),
      );
    }
  }

  /// Pad a string on both sides with [padding], [count] amount of times.
  ///
  /// Example "Hello World" -> " Hello World "
  String pad({
    int count = 1,
    String padding = ' ',
  }) {
    return this
        .padLeft((this.length + count), padding)
        .padRight((this.length + (count * 2)), padding);
  }

  /// Returns the string with a bullet appended to the front.
  String bulleted({
    String bullet = LunaUI.TEXT_BULLET,
    int padCount = 1,
  }) {
    return '${bullet.pad(count: padCount)}$this';
  }

  /// Returns the string without any trailing slash.
  String noTrailingSlash() {
    return this.endsWith('/') ? this.substring(0, this.length - 1) : this;
  }
}
