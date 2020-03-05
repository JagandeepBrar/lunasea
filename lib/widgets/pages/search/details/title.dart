import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchDetailsTitle extends StatelessWidget {
    final String title;

    LSSearchDetailsTitle(this.title);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Release Title'),
        subtitle: LSSubtitle(text: title ?? 'Unknown'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => SystemDialogs.showTextPreviewPrompt(context, 'Release Title', title ?? 'Unknown'),
    );
}
