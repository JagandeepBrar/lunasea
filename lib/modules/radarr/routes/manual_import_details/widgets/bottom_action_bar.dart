import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsBottomActionBar extends StatelessWidget {
  const RadarrManualImportDetailsBottomActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.listen(
          builder: (context, _, __) => LunaActionBarCard(
            title: 'radarr.ImportMode'.tr(),
            subtitle: RadarrImportMode.COPY
                .from((RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.data))
                .lunaReadable,
            //checkboxState: true,
            onTap: () async => _importModeOnTap(context),
          ),
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'radarr.Import'.tr(),
          icon: Icons.download_done_rounded,
          loadingState:
              context.watch<RadarrManualImportDetailsState>().loadingState,
          onTap: () async => _importOnTap(context),
        ),
      ],
    );
  }

  Future<void> _importModeOnTap(BuildContext context) async {
    Tuple2<bool, RadarrImportMode?> result =
        await RadarrDialogs().setManualImportMode(context);
    if (result.item1)
      RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.put(result.item2!.value);
  }

  Future<void> _importOnTap(BuildContext context) async {
    if (context.read<RadarrManualImportDetailsState>().canExecuteAction &&
        context.read<RadarrManualImportDetailsState>().loadingState ==
            LunaLoadingState.INACTIVE) {
      List<RadarrManualImport> _imports =
          await context.read<RadarrManualImportDetailsState>().manualImport!;
      _imports = _imports
          .where((import) => context
              .read<RadarrManualImportDetailsState>()
              .selectedFiles
              .contains(import.id))
          .toList();
      if ((_imports?.length ?? 0) == 0) {
        showLunaInfoSnackBar(
            title: 'Nothing Selected',
            message: 'Please select at least one file to import');
        return;
      }
      bool _allValid = true;
      List<RadarrManualImportFile?> _files = [];
      _imports.forEach((import) {
        if (_allValid) {
          Tuple2<RadarrManualImportFile?, String?> _file =
              RadarrAPIHelper().buildManualImportFile(import: import);
          if (_file.item1 != null) {
            _files.add(_file.item1);
          } else {
            showLunaInfoSnackBar(title: 'Invalid Inputs', message: _file.item2);
            _allValid = false;
          }
        }
      });
      if (_allValid) {
        context.read<RadarrManualImportDetailsState>().loadingState =
            LunaLoadingState.ACTIVE;
        await RadarrAPIHelper()
            .triggerManualImport(
              context: context,
              files: _files,
              importMode: RadarrImportMode.COPY
                  .from((RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.data)),
            )
            .then((result) => result
                ? Navigator.of(context).pop()
                : context.read<RadarrManualImportDetailsState>().loadingState =
                    LunaLoadingState.INACTIVE)
            .catchError((_) => context
                .read<RadarrManualImportDetailsState>()
                .loadingState = LunaLoadingState.ERROR);
      }
    }
  }
}
