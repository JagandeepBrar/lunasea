import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsTerminateSessionButton extends StatelessWidget {
    final TautulliSession session;

    TautulliActivityDetailsTerminateSessionButton({
        Key key,
        @required this.session,
    }): super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaButtonContainer(
            children: [
                LunaButton.text(
                    text: 'tautulli.TerminateSession'.tr(),
                    backgroundColor: LunaColours.red,
                    onTap: () async {
                        Tuple2<bool, String> _result = await TautulliDialogs().terminateSession(context);
                        if(_result.item1) TautulliAPIHelper().terminateSession(context: context, session: session, terminationMessage: _result.item2)
                        .then((value) {
                            if(value) Navigator.of(context).pop();
                        });
                    },
                ),
            ],
        );
    }
}
