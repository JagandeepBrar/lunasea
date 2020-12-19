import 'package:flutter/material.dart';

/// [LunaModuleMetadata] stores general information about a module, including:
/// - Name
/// - Descrption
/// - Base/home route
/// - Links
/// - Icon
/// - Brand colour
/// - etc.
class LunaModuleMetadata {
    final String name;
    final String description;
    final String settingsDescription;
    final String helpMessage;
    final String route;
    final String website;
    final String github;
    final IconData icon;
    final Color color;

    const LunaModuleMetadata({
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
