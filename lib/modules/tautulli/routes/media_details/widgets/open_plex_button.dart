import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/utils/links.dart';

class TautulliMediaDetailsOpenPlexButton extends StatelessWidget {
  final TautulliMediaType mediaType;
  final int ratingKey;

  const TautulliMediaDetailsOpenPlexButton({
    Key? key,
    required this.mediaType,
    required this.ratingKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<TautulliState>().serverIdentity,
      builder: (context, snapshot) {
        if (_isValidMediaType() && snapshot.hasData) {
          return LunaIconButton.appBar(
            icon: LunaIcons.PLEX,
            onPressed: () => _openPlex(snapshot.data as TautulliServerIdentity),
          );
        }
        return const SizedBox();
      },
    );
  }

  bool _isValidMediaType() {
    const invalidTypes = [
      TautulliMediaType.TRACK,
      TautulliMediaType.PHOTO,
    ];
    return !invalidTypes.contains(mediaType);
  }

  Future<void> _openPlex(TautulliServerIdentity identity) async {
    final mobile = LunaLinkedContent.plexMobile(
      identity.machineIdentifier!,
      ratingKey,
    );

    if (await mobile.canOpenUrl()) {
      mobile.openLink();
      return;
    }

    final web = LunaLinkedContent.plexWeb(
      identity.machineIdentifier!,
      ratingKey,
      mediaType == TautulliMediaType.CLIP,
    );
    web.openLink();
  }
}
