import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsUser extends StatelessWidget {
    final String sessionId;

    TautulliActivityDetailsUser({
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
                        icon: Icons.person,
                        onPressed: () async => _onPressed(context, session.userId),
                    );
                }       
                return Container();
            },
        ),
    );

    Future<void> _onPressed(BuildContext context, int userId) => TautulliUserDetailsRouter.navigateTo(
        context,
        userId: userId,
    );
}
