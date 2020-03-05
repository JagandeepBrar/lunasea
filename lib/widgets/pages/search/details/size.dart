import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchDetailsSize extends StatelessWidget {
    final String size;

    LSSearchDetailsSize(this.size);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: 'Size',
            centerText: true,
        ),
        subtitle: LSSubtitle(
            text: size ?? 'Unknown',
            centerText: true,
        ),
        reducedMargin: true,
    );
}
