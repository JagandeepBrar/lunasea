import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsHideButton extends StatelessWidget {
  const LidarrDetailsHideButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<LidarrState>(
        builder: (context, model, widget) => LunaIconButton(
          icon: model.hideUnmonitoredAlbums
              ? Icons.visibility_off_rounded
              : Icons.visibility_rounded,
          onPressed: () =>
              model.hideUnmonitoredAlbums = !model.hideUnmonitoredAlbums,
        ),
      );
}
