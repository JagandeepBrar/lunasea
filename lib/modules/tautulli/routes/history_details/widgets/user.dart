import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliHistoryDetailsUser extends StatelessWidget {
  final int ratingKey;
  final int? sessionKey;
  final int? referenceId;

  const TautulliHistoryDetailsUser({
    Key? key,
    required this.ratingKey,
    this.sessionKey,
    this.referenceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: context.watch<TautulliState>().individualHistory[ratingKey],
        builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            TautulliHistoryRecord? _record =
                snapshot.data!.records!.firstWhereOrNull((record) {
              if (record.referenceId == (referenceId ?? -1) ||
                  record.sessionKey == (sessionKey ?? -1)) return true;
              return false;
            });
            if (_record != null)
              return LunaIconButton(
                icon: Icons.person_rounded,
                onPressed: () async => _onPressed(context, _record.userId!),
              );
          }
          return Container();
        },
      );

  void _onPressed(BuildContext context, int userId) {
    TautulliRoutes.USER_DETAILS.go(params: {
      'user': userId.toString(),
    });
  }
}
