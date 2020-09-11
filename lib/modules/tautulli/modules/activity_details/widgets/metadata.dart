import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsMetadata extends StatelessWidget {
    final String sessionId;

    TautulliActivityDetailsMetadata({
        Key key,
        @required this.sessionId,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => Selector<TautulliState, Future<TautulliActivity>>(
        selector: (_, state) => state.activity,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliActivity> snapshot) {
                if(snapshot.hasError) return Container();
                if(snapshot.hasData) {
                    TautulliSession session = snapshot.data.sessions.firstWhere((element) => element.sessionId == sessionId, orElse: () => null);
                    if(session != null) return LSIconButton(
                        icon: Icons.info_outline,
                        onPressed: () async => _onPressed(context),
                    );
                }       
                return Container();
            },
        ),
    );

    Future<void> _onPressed(BuildContext context) => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'Library data has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}
