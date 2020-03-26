import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import '../../nzbget.dart';

class NZBGetQueueFAB extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<NZBGetModel, Tuple2<bool, bool>>(
        selector: (_, model) => Tuple2(model.error, model.paused),
        builder: (context, data, _) => data.item1
            ? Container()
            : LSFloatingActionButton(
                icon: data.item2 ? Icons.play_arrow : Icons.pause,
                onPressed: () => _toggle(context, data.item2),
            ),
    );

    Future<void> _toggle(BuildContext context, bool paused) async {
        NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);
        paused
            ? _resume(context, _api)
            : _pause(context, _api);
    }

    Future<void> _pause(BuildContext context, NZBGetAPI api) async {
        await api.pauseQueue()
        .then((_) {
            Provider.of<NZBGetModel>(context, listen: false).paused = true;
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Pause Queue',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _resume(BuildContext context, NZBGetAPI api) async {
        return await api.resumeQueue()
        .then((_) {
            Provider.of<NZBGetModel>(context, listen: false).paused = false;
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Resume Queue',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }
}
