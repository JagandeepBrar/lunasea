import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHistoryDetailsMetadata extends StatelessWidget {
  final int ratingKey;
  final int sessionKey;
  final int referenceId;

  const TautulliHistoryDetailsMetadata({
    Key key,
    @required this.ratingKey,
    this.sessionKey,
    this.referenceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: context.watch<TautulliState>().individualHistory[ratingKey],
        builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            TautulliHistoryRecord _record =
                snapshot.data.records.firstWhere((record) {
              if (record.referenceId == (referenceId ?? -1) ||
                  record.sessionKey == (sessionKey ?? -1)) return true;
              return false;
            }, orElse: () => null);
            if (_record != null)
              return LunaIconButton(
                icon: Icons.info_outline,
                onPressed: () async => _onPressed(context, _record),
              );
          }
          return Container();
        },
      );

  Future<void> _onPressed(BuildContext context, TautulliHistoryRecord record) =>
      TautulliMediaDetailsRouter().navigateTo(
        context,
        ratingKey: record.ratingKey,
        mediaType: record.mediaType,
      );
}
