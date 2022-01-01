// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUsersTable _$TautulliUsersTableFromJson(Map<String, dynamic> json) {
  return TautulliUsersTable(
    users: TautulliUsersTable._usersFromJson(json['data'] as List),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
  );
}

Map<String, dynamic> _$TautulliUsersTableToJson(TautulliUsersTable instance) =>
    <String, dynamic>{
      'data': TautulliUsersTable._usersToJson(instance.users),
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
    };
