// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LSBrowsersAdapter extends TypeAdapter<LSBrowsers> {
  @override
  final typeId = 11;

  @override
  LSBrowsers read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LSBrowsers.APPLE_SAFARI;
      case 1:
        return LSBrowsers.BRAVE_BROWSER;
      case 2:
        return LSBrowsers.GOOGLE_CHROME;
      case 3:
        return LSBrowsers.MICROSOFT_EDGE;
      case 4:
        return LSBrowsers.MOZILLA_FIREFOX;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, LSBrowsers obj) {
    switch (obj) {
      case LSBrowsers.APPLE_SAFARI:
        writer.writeByte(0);
        break;
      case LSBrowsers.BRAVE_BROWSER:
        writer.writeByte(1);
        break;
      case LSBrowsers.GOOGLE_CHROME:
        writer.writeByte(2);
        break;
      case LSBrowsers.MICROSOFT_EDGE:
        writer.writeByte(3);
        break;
      case LSBrowsers.MOZILLA_FIREFOX:
        writer.writeByte(4);
        break;
    }
  }
}
