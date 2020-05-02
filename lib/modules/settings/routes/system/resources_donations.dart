import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsSystemDonations extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/donations';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemDonations> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Donations'),
    );
}
