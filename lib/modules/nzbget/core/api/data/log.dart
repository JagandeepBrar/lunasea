import 'package:lunasea/core.dart';

class NZBGetLogData {
  int? id;
  String? kind;
  int? time;
  String? text;

  NZBGetLogData({
    required this.id,
    required this.kind,
    required this.time,
    required this.text,
  });

  String get timestamp {
    return LunaSeaDatabase.USE_24_HOUR_TIME.read()
        ? DateFormat('MMMM dd, y - HH:mm')
            .format(DateTime.fromMillisecondsSinceEpoch(time! * 1000))
        : DateFormat('MMMM dd, y - hh:mm:ss a')
            .format(DateTime.fromMillisecondsSinceEpoch(time! * 1000));
  }
}
