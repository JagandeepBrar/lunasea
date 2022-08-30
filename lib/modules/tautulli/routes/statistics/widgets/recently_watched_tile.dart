import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliStatisticsRecentlyWatchedTile extends StatefulWidget {
  final Map<String, dynamic> data;

  const TautulliStatisticsRecentlyWatchedTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliStatisticsRecentlyWatchedTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.data['title'] ?? 'lunasea.Unknown'.tr(),
      body: _body(),
      onTap: _onTap,
      posterUrl: context
          .read<TautulliState>()
          .getImageURLFromPath(widget.data['thumb']),
      posterHeaders: context.watch<TautulliState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl:
          context.read<TautulliState>().getImageURLFromPath(widget.data['art']),
      backgroundHeaders: context.watch<TautulliState>().headers,
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: widget.data['friendly_name'] ?? 'Unknown User'),
      widget.data['player'] != null
          ? TextSpan(text: widget.data['player'])
          : const TextSpan(text: LunaUI.TEXT_EMDASH),
      widget.data['last_watch'] != null
          ? TextSpan(
              text:
                  'Watched ${DateTime.fromMillisecondsSinceEpoch(widget.data['last_watch'] * 1000).asAge()}',
            )
          : const TextSpan(text: LunaUI.TEXT_EMDASH)
    ];
  }

  Future<void> _onTap() async {
    TautulliRoutes.MEDIA_DETAILS.go(params: {
      'rating_key': widget.data['rating_key'].toString(),
      'media_type': TautulliMediaType.from(widget.data['media_type']).value,
    });
  }
}
