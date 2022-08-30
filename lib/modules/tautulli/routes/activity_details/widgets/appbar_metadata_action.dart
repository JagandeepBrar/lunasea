import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliActivityDetailsMetadataAction extends StatelessWidget {
  final String? sessionId;

  const TautulliActivityDetailsMetadataAction({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.select<TautulliState, Future<TautulliActivity?>>(
          (state) => state.activity!),
      builder: (context, AsyncSnapshot<TautulliActivity?> snapshot) {
        if (snapshot.hasError) return Container();
        if (snapshot.hasData) {
          TautulliSession? session = snapshot.data!.sessions!
              .firstWhereOrNull((element) => element.sessionId == sessionId);
          if (session != null)
            return LunaIconButton(
              icon: Icons.info_outline_rounded,
              onPressed: () async => _onPressed(context, session),
            );
        }
        return Container();
      },
    );
  }

  void _onPressed(BuildContext context, TautulliSession session) {
    TautulliRoutes.MEDIA_DETAILS.go(params: {
      'rating_key': session.ratingKey.toString(),
      'media_type': session.mediaType!.value,
    });
  }
}
