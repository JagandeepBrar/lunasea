import 'package:flutter/material.dart';
import './generic.dart';

class LSConnectionError extends StatelessWidget {
    final Function onTapHandler;

    LSConnectionError({
        Key key,
        @required this.onTapHandler,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: 'Connection Error',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: onTapHandler,
    );
}
