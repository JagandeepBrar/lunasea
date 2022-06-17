import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';

class NewznabResultData {
  String title;
  String category;
  int size;
  String linkDownload;
  String linkComments;
  String date;

  NewznabResultData({
    required this.title,
    required this.category,
    required this.size,
    required this.linkComments,
    required this.linkDownload,
    required this.date,
  });

  DateTime? get dateObject {
    try {
      DateFormat _format = DateFormat('EEE, dd MMM yyyy hh:mm:ss', 'en');
      int? _offset = int.tryParse(date.substring(date.length - 5));
      DateTime _date = _format.parseUtc(date);
      if (_offset != null)
        _date = _date.add(Duration(hours: (-(_offset / 100).round())));
      return _date.toLocal().isAfter(DateTime.now())
          ? DateTime.now()
          : _date.toLocal();
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  String get age => dateObject?.asAge() ?? 'lunasea.Unknown'.tr();

  int get posix => dateObject?.millisecondsSinceEpoch ?? 0;
}
