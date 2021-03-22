import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                RadarrAddMovieDetailsAddButton(searchOnAdd: false),
                RadarrAddMovieDetailsAddButton(searchOnAdd: true),
            ],
        );
    }
}
