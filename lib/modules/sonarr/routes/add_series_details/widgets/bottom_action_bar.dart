import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/sonarr.dart';

class SonarrAddSeriesDetailsActionBar extends StatelessWidget {
  const SonarrAddSeriesDetailsActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaActionBarCard(
          title: 'lunasea.Options'.tr(),
          subtitle: 'sonarr.StartSearchFor'.tr(),
          onTap: () async => SonarrDialogs().addSeriesOptions(context),
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Add'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => _onTap(context),
          loadingState: context.watch<SonarrSeriesAddDetailsState>().state,
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) async {
    if (context.read<SonarrSeriesAddDetailsState>().canExecuteAction) {
      context.read<SonarrSeriesAddDetailsState>().state =
          LunaLoadingState.ACTIVE;
      SonarrSeriesAddDetailsState _state =
          context.read<SonarrSeriesAddDetailsState>();
      await SonarrAPIController()
          .addSeries(
        context: context,
        series: _state.series,
        qualityProfile: _state.qualityProfile,
        languageProfile: _state.languageProfile,
        rootFolder: _state.rootFolder,
        seasonFolder: _state.useSeasonFolders,
        tags: _state.tags,
        seriesType: _state.seriesType,
        monitorType: _state.monitorType,
      )
          .then((series) async {
        context.read<SonarrState>().fetchAllSeries();
        context.read<SonarrSeriesAddDetailsState>().series.id = series!.id;

        LunaRouter.router.pop();
        SonarrRoutes.SERIES.go(params: {
          'series': series.id!.toString(),
        });
      }).catchError((error, stack) {
        context.read<SonarrSeriesAddDetailsState>().state =
            LunaLoadingState.ERROR;
      });
      context.read<SonarrSeriesAddDetailsState>().state =
          LunaLoadingState.INACTIVE;
    }
  }
}
