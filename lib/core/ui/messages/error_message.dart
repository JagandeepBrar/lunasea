import 'package:flutter/material.dart';
import './generic.dart';

class LSErrorMessage extends StatelessWidget {
    final Function onTapHandler;
    final bool hideButton;
    final String message;
    final String btnMessage;

    LSErrorMessage({
        Key key,
        @required this.onTapHandler,
        this.message = 'An Error Has Occurred',
        this.btnMessage = 'Try Again',
        this.hideButton = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: message,
        showButton: !hideButton,
        buttonText: btnMessage,
        onTapHandler: onTapHandler,
    );
}
