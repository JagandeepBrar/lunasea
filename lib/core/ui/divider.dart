import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDivider extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Divider(
        thickness: 2.0,
        color: LSColors.accent.withOpacity(0.25),
    );
}
