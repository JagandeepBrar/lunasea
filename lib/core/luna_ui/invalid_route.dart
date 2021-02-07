import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaInvalidRoute extends StatelessWidget {
    final String title;
    final String message;

    LunaInvalidRoute({
        Key key,
        this.title = 'Unknown', 
        this.message = 'Unknown Route',
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: LunaAppBar(context: context, title: title),
            body: LSGenericMessage(
                text: message,
                showButton: Navigator.of(context).canPop(),
                buttonText: 'Go Back',
                onTapHandler: () => Navigator.of(context).pop(),
            ),
        );
    }
}
