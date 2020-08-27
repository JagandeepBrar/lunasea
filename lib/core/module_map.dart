import 'package:flutter/material.dart';

class ModuleMap {
    final String name;
    final String description;
    final String settingsDescription;
    final String route;
    final IconData icon;
    final Color color;

    const ModuleMap({
        @required this.name,
        @required this.description,
        @required this.settingsDescription,
        @required this.route,
        @required this.icon,
        @required this.color,
    });
}
