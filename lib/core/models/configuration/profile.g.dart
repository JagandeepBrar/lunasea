// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveObjectAdapter extends TypeAdapter<ProfileHiveObject> {
  @override
  final int typeId = 0;

  @override
  ProfileHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHiveObject(
      lidarrEnabled: fields[0] as bool?,
      lidarrHost: fields[1] as String?,
      lidarrKey: fields[2] as String?,
      lidarrHeaders: (fields[26] as Map?)?.cast<dynamic, dynamic>(),
      radarrEnabled: fields[3] as bool?,
      radarrHost: fields[4] as String?,
      radarrKey: fields[5] as String?,
      radarrHeaders: (fields[27] as Map?)?.cast<dynamic, dynamic>(),
      sonarrEnabled: fields[6] as bool?,
      sonarrHost: fields[7] as String?,
      sonarrKey: fields[8] as String?,
      sonarrHeaders: (fields[28] as Map?)?.cast<dynamic, dynamic>(),
      sabnzbdEnabled: fields[9] as bool?,
      sabnzbdHost: fields[10] as String?,
      sabnzbdKey: fields[11] as String?,
      sabnzbdHeaders: (fields[29] as Map?)?.cast<dynamic, dynamic>(),
      nzbgetEnabled: fields[12] as bool?,
      nzbgetHost: fields[13] as String?,
      nzbgetUser: fields[14] as String?,
      nzbgetPass: fields[15] as String?,
      nzbgetHeaders: (fields[30] as Map?)?.cast<dynamic, dynamic>(),
      wakeOnLANEnabled: fields[23] as bool?,
      wakeOnLANBroadcastAddress: fields[24] as String?,
      wakeOnLANMACAddress: fields[25] as String?,
      tautulliEnabled: fields[31] as bool?,
      tautulliHost: fields[32] as String?,
      tautulliKey: fields[33] as String?,
      tautulliHeaders: (fields[35] as Map?)?.cast<dynamic, dynamic>(),
      ombiEnabled: fields[36] as bool?,
      ombiHost: fields[37] as String?,
      ombiKey: fields[38] as String?,
      ombiHeaders: (fields[39] as Map?)?.cast<dynamic, dynamic>(),
      overseerrEnabled: fields[40] as bool?,
      overseerrHost: fields[41] as String?,
      overseerrKey: fields[42] as String?,
      overseerrHeaders: (fields[43] as Map?)?.cast<dynamic, dynamic>(),
    )
      ..sonarrVersion3 = fields[21] as bool?
      ..nzbgetBasicAuth = fields[22] as bool?;
  }

  @override
  void write(BinaryWriter writer, ProfileHiveObject obj) {
    writer
      ..writeByte(38)
      ..writeByte(0)
      ..write(obj.lidarrEnabled)
      ..writeByte(1)
      ..write(obj.lidarrHost)
      ..writeByte(2)
      ..write(obj.lidarrKey)
      ..writeByte(26)
      ..write(obj.lidarrHeaders)
      ..writeByte(3)
      ..write(obj.radarrEnabled)
      ..writeByte(4)
      ..write(obj.radarrHost)
      ..writeByte(5)
      ..write(obj.radarrKey)
      ..writeByte(27)
      ..write(obj.radarrHeaders)
      ..writeByte(6)
      ..write(obj.sonarrEnabled)
      ..writeByte(7)
      ..write(obj.sonarrHost)
      ..writeByte(8)
      ..write(obj.sonarrKey)
      ..writeByte(21)
      ..write(obj.sonarrVersion3)
      ..writeByte(28)
      ..write(obj.sonarrHeaders)
      ..writeByte(9)
      ..write(obj.sabnzbdEnabled)
      ..writeByte(10)
      ..write(obj.sabnzbdHost)
      ..writeByte(11)
      ..write(obj.sabnzbdKey)
      ..writeByte(29)
      ..write(obj.sabnzbdHeaders)
      ..writeByte(12)
      ..write(obj.nzbgetEnabled)
      ..writeByte(13)
      ..write(obj.nzbgetHost)
      ..writeByte(14)
      ..write(obj.nzbgetUser)
      ..writeByte(15)
      ..write(obj.nzbgetPass)
      ..writeByte(22)
      ..write(obj.nzbgetBasicAuth)
      ..writeByte(30)
      ..write(obj.nzbgetHeaders)
      ..writeByte(23)
      ..write(obj.wakeOnLANEnabled)
      ..writeByte(24)
      ..write(obj.wakeOnLANBroadcastAddress)
      ..writeByte(25)
      ..write(obj.wakeOnLANMACAddress)
      ..writeByte(31)
      ..write(obj.tautulliEnabled)
      ..writeByte(32)
      ..write(obj.tautulliHost)
      ..writeByte(33)
      ..write(obj.tautulliKey)
      ..writeByte(35)
      ..write(obj.tautulliHeaders)
      ..writeByte(36)
      ..write(obj.ombiEnabled)
      ..writeByte(37)
      ..write(obj.ombiHost)
      ..writeByte(38)
      ..write(obj.ombiKey)
      ..writeByte(39)
      ..write(obj.ombiHeaders)
      ..writeByte(40)
      ..write(obj.overseerrEnabled)
      ..writeByte(41)
      ..write(obj.overseerrHost)
      ..writeByte(42)
      ..write(obj.overseerrKey)
      ..writeByte(43)
      ..write(obj.overseerrHeaders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
