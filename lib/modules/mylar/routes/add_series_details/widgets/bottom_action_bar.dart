import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/mylar.dart';

class MylarAddSeriesDetailsActionBar extends StatelessWidget {
  const MylarAddSeriesDetailsActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaActionBarCard(
          title: 'lunasea.Options'.tr(),
          subtitle: 'mylar.StartSearchFor'.tr(),
          onTap: () async => MylarDialogs().addSeriesOptions(context),
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Add'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => _onTap(context),
          loadingState: context.watch<MylarSeriesAddDetailsState>().state,
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) async {
    if (context.read<MylarSeriesAddDetailsState>().canExecuteAction) {
      context.read<MylarSeriesAddDetailsState>().state =
          LunaLoadingState.ACTIVE;
      MylarSeriesAddDetailsState _state =
          context.read<MylarSeriesAddDetailsState>();
      await MylarAPIController()
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
        context.read<MylarState>().fetchAllSeries();
        context.read<MylarSeriesAddDetailsState>().series.id = series!.id;

        LunaRouter.router.pop();
        MylarRoutes.SERIES.go(params: {
          'series': series.id!.toString(),
        });
      }).catchError((error, stack) {
        context.read<MylarSeriesAddDetailsState>().state =
            LunaLoadingState.ERROR;
      });
      context.read<MylarSeriesAddDetailsState>().state =
          LunaLoadingState.INACTIVE;
    }
  }
}
