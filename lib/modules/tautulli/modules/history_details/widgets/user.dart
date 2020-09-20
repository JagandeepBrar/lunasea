import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsUser extends StatelessWidget {
    final int ratingKey;
    final int sessionKey;
    final int referenceId;

    TautulliHistoryDetailsUser({
        Key key,
        @required this.ratingKey,
        this.sessionKey,
        this.referenceId,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => FutureBuilder(
        future: Provider.of<TautulliLocalState>(context).history[ratingKey],
        builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
            if(snapshot.hasError) return Container();
            if(snapshot.hasData) {
                TautulliHistoryRecord _record = snapshot.data.records.firstWhere((record) {
                    if(record.referenceId == (referenceId ?? -1) || record.sessionKey == (sessionKey ?? -1)) return true;
                    return false;
                }, orElse: () => null);
                if(_record != null) return LSIconButton(
                    icon: Icons.person,
                    onPressed: () async => _onPressed(context, _record.userId),
                );
            }       
            return Container();
        },
    );

    Future<void> _onPressed(BuildContext context, int userId) => TautulliUserDetailsRouter.navigateTo(
        context,
        userId: userId,
    );
}
