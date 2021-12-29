import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrReleasesHideButton extends StatefulWidget {
  final ScrollController controller;

  const LidarrReleasesHideButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LidarrReleasesHideButton> createState() => _State();
}

class _State extends State<LidarrReleasesHideButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<LidarrState>(
          builder: (context, model, widget) => LunaIconButton(
            icon: model.hideRejectedReleases
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            onPressed: () =>
                model.hideRejectedReleases = !model.hideRejectedReleases,
          ),
        ),
        height: LunaTextInputBar.defaultHeight,
        width: LunaTextInputBar.defaultHeight,
        margin: LunaTextInputBar.appBarMargin
            .subtract(const EdgeInsets.only(left: 12.0)) as EdgeInsets,
        color: Theme.of(context).canvasColor,
      );
}
