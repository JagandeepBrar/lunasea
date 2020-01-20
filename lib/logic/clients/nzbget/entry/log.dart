import 'package:intl/intl.dart';

class NZBGetLogEntry {
    int id;
    String kind;
    int time;
    String text;

    NZBGetLogEntry(
        this.id,
        this.kind,
        this.time,
        this.text,
    );

    String get timestamp {
        return DateFormat('MMMM dd, y - hh:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(time*1000));
    }
}
