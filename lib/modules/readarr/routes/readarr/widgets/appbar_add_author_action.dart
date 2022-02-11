import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAppBarAddSeriesAction extends StatelessWidget {
  const ReadarrAppBarAddSeriesAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.add_rounded,
      onPressed: () async => ReadarrAddSeriesRouter().navigateTo(context),
    );
  }
}
