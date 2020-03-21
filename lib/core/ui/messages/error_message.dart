import 'package:flutter/material.dart';
import './generic.dart';

class LSErrorMessage extends StatelessWidget {
    final Function onTapHandler;
    final String message;
    final String btnMessage;

    LSErrorMessage({
        Key key,
        @required this.onTapHandler,
        this.message = 'An Error Has Occurred',
        this.btnMessage = 'Try Again',
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: message,
        showButton: true,
        buttonText: btnMessage,
        onTapHandler: onTapHandler,
    );
}
