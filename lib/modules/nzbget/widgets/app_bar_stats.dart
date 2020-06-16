import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetAppBarStats extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<NZBGetModel, Tuple5<bool, String, String, String, String>>(
        selector: (_, model) => Tuple5(
            model.paused,           //item1
            model.currentSpeed,     //item2
            model.queueTimeLeft,    //item3
            model.queueSizeLeft,    //item4
            model.speedLimit,       //item5
        ),
        builder: (context, data, widget) => GestureDetector(
            onTap: () async => _onTap(context, data.item5),
            child: Center(
                child:  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                        children: [
                            TextSpan(
                                text: _status(data.item1, data.item2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.UI_FONT_SIZE_HEADER,
                                    color: LSColors.accent,
                                ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(text: data.item3 == '0:00:00' ? '―' : data.item3),
                            TextSpan(text: '\t\t•\t\t'),
                            TextSpan(text: data.item4 == '0.0 B' ? '―' : data.item4)
                        ],
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: false,
                    textAlign: TextAlign.right,
                ),
            ),
        ),
    );

    String _status(bool paused, String speed) => paused
        ? 'Paused'
        : speed == '0.0 B/s'
            ? 'Idle'
            : speed;

    Future<void> _onTap(BuildContext context, String speed) async {
        List values = await NZBGetDialogs.speedLimit(context, speed);
        if(values[0]) switch(values[1]) {
            case -1: {
                values = await NZBGetDialogs.customSpeedLimit(context);
                if(values[0]) NZBGetAPI.from(Database.currentProfileObject).setSpeedLimit(values[1])
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Speed Limit Set',
                    message: 'Set to ${(values[1] as int).lsBytes_KilobytesToString(decimals: 0)}/s',
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Set Speed Limit',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
                break;
            }
            default: NZBGetAPI.from(Database.currentProfileObject).setSpeedLimit(values[1])
            .then((_) => LSSnackBar(
                context: context,
                title: 'Speed Limit Set',
                message: 'Set to ${(values[1] as int).lsBytes_KilobytesToString(decimals: 0)}/s',
                type: SNACKBAR_TYPE.success,
            ))
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Set Speed Limit',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }
}