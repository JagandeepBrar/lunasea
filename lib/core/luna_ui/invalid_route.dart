import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaInvalidRoute extends StatelessWidget {
    final String title;
    final String message;

    LunaInvalidRoute({
        Key key,
        this.title = 'LunaSea', 
        this.message = '404: Not Found',
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: LunaAppBar(title: title),
            body: LunaMessage(
                text: message,
                buttonText: Navigator.of(context).canPop() ? 'Go Back' : null,
                onTap: () => Navigator.of(context).pop(),
            ),
        );
    }
}
