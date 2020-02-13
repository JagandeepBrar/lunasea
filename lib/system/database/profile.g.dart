// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveObjectAdapter extends TypeAdapter<ProfileHiveObject> {
  @override
  final typeId = 0;

  @override
  ProfileHiveObject read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHiveObject(
      displayName: fields[0] as String,
      lidarrEnabled: fields[1] as bool,
      lidarrHost: fields[2] as String,
      lidarrKey: fields[3] as String,
      radarrEnabled: fields[4] as bool,
      radarrHost: fields[5] as String,
      radarrKey: fields[6] as String,
      sonarrEnabled: fields[7] as bool,
      sonarrHost: fields[8] as String,
      sonarrKey: fields[9] as String,
      sabnzbdEnabled: fields[10] as bool,
      sabnzbdHost: fields[11] as String,
      sabnzbdKey: fields[12] as String,
      nzbgetEnabled: fields[13] as bool,
      nzbgetHost: fields[14] as String,
      nzbgetUser: fields[15] as String,
      nzbgetPass: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHiveObject obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.lidarrEnabled)
      ..writeByte(2)
      ..write(obj.lidarrHost)
      ..writeByte(3)
      ..write(obj.lidarrKey)
      ..writeByte(4)
      ..write(obj.radarrEnabled)
      ..writeByte(5)
      ..write(obj.radarrHost)
      ..writeByte(6)
      ..write(obj.radarrKey)
      ..writeByte(7)
      ..write(obj.sonarrEnabled)
      ..writeByte(8)
      ..write(obj.sonarrHost)
      ..writeByte(9)
      ..write(obj.sonarrKey)
      ..writeByte(10)
      ..write(obj.sabnzbdEnabled)
      ..writeByte(11)
      ..write(obj.sabnzbdHost)
      ..writeByte(12)
      ..write(obj.sabnzbdKey)
      ..writeByte(13)
      ..write(obj.nzbgetEnabled)
      ..writeByte(14)
      ..write(obj.nzbgetHost)
      ..writeByte(15)
      ..write(obj.nzbgetUser)
      ..writeByte(16)
      ..write(obj.nzbgetPass);
  }
}
