import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import './generic.dart';

class LSNotEnabled extends StatelessWidget {
    final String service;
    final bool showButton;

    LSNotEnabled(
        this.service,
        { this.showButton = true }
    );

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: service == Constants.NO_SERVICES_ENABLED
            ? 'No Modules Enabled'
            : '$service Is Not Enabled',
        showButton: showButton,
        buttonText: 'Return Home',
        onTapHandler: () async => await Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
    );
}
