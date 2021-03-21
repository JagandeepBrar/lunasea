import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportBottomActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            child: SafeArea(
                child: Padding(
                    child: LunaButtonContainer(
                        children: [
                            LunaButton.text(
                                text: 'radarr.Quick'.tr(),
                                onTap: () async {
                                    String path = context.read<RadarrManualImportState>().currentPathTextController.text;
                                    RadarrAPIHelper().quickImport(context: context, path: path);
                                },
                            ),
                            LunaButton.text(
                                text: 'radarr.Interactive'.tr(),
                                backgroundColor: LunaColours.orange,
                                onTap: () async {
                                    String path = context.read<RadarrManualImportState>().currentPathTextController.text;
                                    RadarrManualImportDetailsRouter().navigateTo(context, path: path);
                                },
                            ),
                        ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        );
    }
}
