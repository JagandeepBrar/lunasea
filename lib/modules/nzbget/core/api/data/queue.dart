import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/extensions/string/string.dart';

class NZBGetQueueData {
  int id;
  String name;
  String status;
  String category;
  int remaining;
  int downloaded;
  int sizeTotal;
  int speed;
  int queueSeconds;

  NZBGetQueueData({
    required this.id,
    required this.name,
    required this.status,
    required this.remaining,
    required this.downloaded,
    required this.sizeTotal,
    required this.category,
    required this.speed,
    required this.queueSeconds,
  });

  int get percentageDone {
    return sizeTotal == 0 ? 0 : ((downloaded / sizeTotal) * 100).round();
  }

  bool get paused {
    return status == 'PAUSED';
  }

  double get speedMB {
    return speed / (1024 * 1024);
  }

  int get remainingTime {
    return speedMB == 0 ? 0 : (remaining / speedMB).floor();
  }

  String get timestamp {
    return (queueSeconds + remainingTime).asTrackDuration() == '00:00'
        ? '―'
        : (queueSeconds + remainingTime).asTrackDuration();
  }

  String get statusString {
    switch (status) {
      case 'DOWNLOADING':
      case 'QUEUED':
        {
          return speed == -1 ? 'Downloading' : timestamp;
        }
      case 'PAUSED':
        {
          return 'Paused';
        }
      default:
        {
          return status;
        }
    }
  }

  String get formattedCategory {
    if (category.isEmpty) return 'No Category';
    return category;
  }

  String get subtitle {
    String size = '$downloaded/$sizeTotal MB';
    String paddedBullet = LunaUI.TEXT_BULLET.pad();
    return '$statusString$paddedBullet$size$paddedBullet$percentageDone%$paddedBullet$formattedCategory';
  }
}
