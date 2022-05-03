import 'package:flutter/material.dart';

import '../../../../../core/system/profile.dart';
import '../../../../../ui/ui.dart';
import '../../../core/api/data/abstract.dart';
import '../../../core/api/data/lidarr.dart';
import '../../../core/api/data/radarr.dart';
import '../../../core/api/data/sonarr.dart';

class ContentBlock extends StatelessWidget {
  final CalendarData data;
  const ContentBlock(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headers = getHeaders();
    return LunaBlock(
      title: data.title,
      body: data.body,
      posterHeaders: headers,
      backgroundHeaders: headers,
      posterUrl: data.posterUrl(context),
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl: data.backgroundUrl(context),
      trailing: data.trailing(context),
      onTap: () async => data.enterContent(context),
    );
  }

  Map getHeaders() {
    switch (data.runtimeType) {
      case CalendarLidarrData:
        return LunaProfile.current.getLidarr()['headers'];
      case CalendarRadarrData:
        return LunaProfile.current.getRadarr()['headers'];
      case CalendarSonarrData:
        return LunaProfile.current.getSonarr()['headers'];
      default:
        return const {};
    }
  }
}
