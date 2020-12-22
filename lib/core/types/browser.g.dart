// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaBrowserAdapter extends TypeAdapter<LunaBrowser> {
  @override
  final int typeId = 11;

  @override
  LunaBrowser read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LunaBrowser.APPLE_SAFARI;
      case 1:
        return LunaBrowser.BRAVE_BROWSER;
      case 2:
        return LunaBrowser.GOOGLE_CHROME;
      case 3:
        return LunaBrowser.MICROSOFT_EDGE;
      case 4:
        return LunaBrowser.MOZILLA_FIREFOX;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, LunaBrowser obj) {
    switch (obj) {
      case LunaBrowser.APPLE_SAFARI:
        writer.writeByte(0);
        break;
      case LunaBrowser.BRAVE_BROWSER:
        writer.writeByte(1);
        break;
      case LunaBrowser.GOOGLE_CHROME:
        writer.writeByte(2);
        break;
      case LunaBrowser.MICROSOFT_EDGE:
        writer.writeByte(3);
        break;
      case LunaBrowser.MOZILLA_FIREFOX:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaBrowserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
