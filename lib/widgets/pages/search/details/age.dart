import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchDetailsAge extends StatelessWidget {
    final String age;

    LSSearchDetailsAge(this.age);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: 'Age',
            centerText: true,
        ),
        subtitle: LSSubtitle(
            text: age ?? 'Unknown',
            centerText: true,
        ),
        reducedMargin: true,
    );
}
