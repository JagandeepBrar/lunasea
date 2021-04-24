import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsHideButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<LidarrState>(
        builder: (context, model, widget) => LunaIconButton(
          icon: model.hideUnmonitoredAlbums
              ? Icons.visibility_off
              : Icons.visibility,
          onPressed: () =>
              model.hideUnmonitoredAlbums = !model.hideUnmonitoredAlbums,
        ),
      );
}
