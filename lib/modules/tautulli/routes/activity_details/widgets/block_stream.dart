import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliActivityDetailsStreamBlock extends StatelessWidget {
    final TautulliSession session;

    TautulliActivityDetailsStreamBlock({
        Key key,
        @required this.session,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaTableCard(
            content: [
                LunaTableContent(title: 'tautulli.Bandwidth'.tr(), body: session.lunaBandwidth),
                LunaTableContent(title: 'tautulli.Stream'.tr(), body: session.lunaTranscodeDecision),
                LunaTableContent(title: 'tautulli.Container'.tr(), body: session.lunaContainer),
                LunaTableContent(title: 'tautulli.Video'.tr(), body: session.lunaVideo),
                LunaTableContent(title: 'tautulli.Audio'.tr(), body: session.lunaAudio),
                LunaTableContent(title: 'tautulli.Subtitle'.tr(), body: session.lunaSubtitle),
            ],
        );
    }
}
