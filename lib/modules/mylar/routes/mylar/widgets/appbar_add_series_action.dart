import 'package:flutter/material.dart';
import 'package:lunasea/router/routes/mylar.dart';
import 'package:lunasea/widgets/ui.dart';

class MylarAppBarAddSeriesAction extends StatelessWidget {
  const MylarAppBarAddSeriesAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.add_rounded,
      onPressed: MylarRoutes.ADD_SERIES.go,
    );
  }
}
