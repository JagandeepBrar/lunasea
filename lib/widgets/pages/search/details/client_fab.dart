import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchDetailsClientFAB extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSFloatingActionButton(
        icon: Icons.screen_share,
        onPressed: _sendToClient,
    );

    Future<void> _sendToClient() async {

    }
}
