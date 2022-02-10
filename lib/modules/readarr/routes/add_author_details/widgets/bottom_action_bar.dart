import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAddSeriesDetailsActionBar extends StatelessWidget {
  const ReadarrAddSeriesDetailsActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaActionBarCard(
          title: 'lunasea.Options'.tr(),
          subtitle: 'readarr.StartSearchFor'.tr(),
          onTap: () async => ReadarrDialogs().addSeriesOptions(context),
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Add'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => _onTap(context),
          loadingState: context.watch<ReadarrAuthorAddDetailsState>().state,
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) async {
    if (context.read<ReadarrAuthorAddDetailsState>().canExecuteAction) {
      context.read<ReadarrAuthorAddDetailsState>().state =
          LunaLoadingState.ACTIVE;
      ReadarrAuthorAddDetailsState _state =
          context.read<ReadarrAuthorAddDetailsState>();
      await ReadarrAPIController()
          .addAuthor(
        context: context,
        author: _state.series,
        qualityProfile: _state.qualityProfile,
        metadataProfile: _state.metadataProfile,
        rootFolder: _state.rootFolder,
        tags: _state.tags,
        monitorType: _state.monitorType,
      )
          .then((series) async {
        context.read<ReadarrState>().fetchAllAuthors();
        context.read<ReadarrAuthorAddDetailsState>().series.id = series!.id;
        Navigator.of(context)
            .popAndPushNamed(ReadarrAuthorDetailsRouter().route(series.id!));
      }).catchError((error, stack) {
        context.read<ReadarrAuthorAddDetailsState>().state =
            LunaLoadingState.ERROR;
      });
      context.read<ReadarrAuthorAddDetailsState>().state =
          LunaLoadingState.INACTIVE;
    }
  }
}
