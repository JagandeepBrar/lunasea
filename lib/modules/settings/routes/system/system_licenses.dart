import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsSystemLicenses extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/licenses';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemLicenses> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Licenses'),
    );
}
