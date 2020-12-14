import 'package:flutter/material.dart';

class LunaModuleMap {
    final String name;
    final String description;
    final String settingsDescription;
    final String helpMessage;
    final String route;
    final String website;
    final String github;
    final IconData icon;
    final Color color;

    const LunaModuleMap({
        @required this.name,
        @required this.description,
        @required this.settingsDescription,
        @required this.helpMessage,
        @required this.route,
        @required this.website,
        @required this.github,
        @required this.icon,
        @required this.color,
    });
}
