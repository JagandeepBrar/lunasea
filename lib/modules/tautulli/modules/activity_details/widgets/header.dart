import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsHeader extends StatelessWidget {
    final TautulliSession session;

    TautulliActivityDetailsHeader({
        Key key,
        @required this.session,
    }): super(key: key);

    @override build(BuildContext context) => ShaderMask(
        shaderCallback: (rect) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LSColors.secondary, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
        blendMode: BlendMode.dstIn,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.width)*0.56267,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(session.art),
                        headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
                    ),
                    fit: BoxFit.cover,
                ),
                color: LSColors.secondary,
            ),
        ),
    );
}
