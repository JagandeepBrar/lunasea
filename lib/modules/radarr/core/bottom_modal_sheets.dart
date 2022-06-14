import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrBottomModalSheets {
  Future<void> configureManualImport(BuildContext context) async {
    await LunaBottomModalSheet().show(
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrManualImportDetailsTileState>(),
        builder: (context, _) => LunaListViewModal(
          children: [
            LunaHeader(
              text: 'radarr.Configure'.tr(),
              subtitle: context
                  .read<RadarrManualImportDetailsTileState>()
                  .manualImport
                  .relativePath,
            ),
            LunaBlock(
              title: 'radarr.SelectMovie'.tr(),
              body: [
                TextSpan(
                  text: context
                      .watch<RadarrManualImportDetailsTileState>()
                      .manualImport
                      .lunaMovie,
                ),
              ],
              trailing: const LunaIconButton.arrow(),
              onTap: () async {
                Tuple2<bool, RadarrMovie?> result = await selectMovie(context);
                if (result.item1)
                  context
                      .read<RadarrManualImportDetailsTileState>()
                      .fetchUpdates(context, result.item2!.id);
              },
            ),
            LunaBlock(
              title: 'radarr.SelectQuality'.tr(),
              body: [
                TextSpan(
                  text: context
                      .watch<RadarrManualImportDetailsTileState>()
                      .manualImport
                      .lunaQualityProfile,
                ),
              ],
              trailing: const LunaIconButton.arrow(),
              onTap: () async => selectQuality(context),
            ),
            LunaBlock(
              title: 'radarr.SelectLanguage'.tr(),
              body: [
                TextSpan(
                  text: context
                      .watch<RadarrManualImportDetailsTileState>()
                      .manualImport
                      .lunaLanguage,
                ),
              ],
              trailing: const LunaIconButton.arrow(),
              onTap: () async {
                List<RadarrLanguage> languages =
                    await context.read<RadarrState>().languages!;
                await RadarrDialogs()
                    .setManualImportLanguages(context, languages);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectQuality(BuildContext context) async {
    await LunaBottomModalSheet().show(
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrManualImportDetailsTileState>(),
        builder: (context, _) => LunaListViewModal(
          children: [
            LunaHeader(text: 'radarr.SelectQuality'.tr()),
            LunaBlock(
              title: 'radarr.Quality'.tr(),
              body: [
                TextSpan(
                  text: context
                      .watch<RadarrManualImportDetailsTileState>()
                      .manualImport
                      .lunaQualityProfile,
                ),
              ],
              trailing: const LunaIconButton.arrow(),
              onTap: () async {
                List<RadarrQualityDefinition> profiles =
                    await context.read<RadarrState>().qualityDefinitions!;
                Tuple2<bool, RadarrQualityDefinition?> result =
                    await RadarrDialogs()
                        .selectQualityDefinition(context, profiles);
                if (result.item1)
                  context
                      .read<RadarrManualImportDetailsTileState>()
                      .updateQuality(result.item2!.quality!);
              },
            ),
            LunaBlock(
              title: 'Proper',
              trailing: Switch(
                value: context
                        .watch<RadarrManualImportDetailsTileState>()
                        .manualImport
                        .quality
                        ?.revision
                        ?.version ==
                    2,
                onChanged: (value) async {
                  RadarrManualImport _import = context
                      .read<RadarrManualImportDetailsTileState>()
                      .manualImport;
                  _import.quality?.revision?.version = value ? 2 : 1;
                  context
                      .read<RadarrManualImportDetailsTileState>()
                      .manualImport = _import;
                },
              ),
            ),
            LunaBlock(
              title: 'Real',
              trailing: Switch(
                value: context
                        .watch<RadarrManualImportDetailsTileState>()
                        .manualImport
                        .quality
                        ?.revision
                        ?.real ==
                    1,
                onChanged: (value) async {
                  RadarrManualImport _import = context
                      .read<RadarrManualImportDetailsTileState>()
                      .manualImport;
                  _import.quality?.revision?.real = value ? 1 : 0;
                  context
                      .read<RadarrManualImportDetailsTileState>()
                      .manualImport = _import;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Tuple2<bool, RadarrMovie?>> selectMovie(BuildContext context) async {
    bool result = false;
    RadarrMovie? movie;
    context
        .read<RadarrManualImportDetailsTileState>()
        .configureMoviesSearchQuery = '';

    List<RadarrMovie> _sortAndFilter(List<RadarrMovie> movies, String query) {
      List<RadarrMovie> _filtered = movies
        ..sort((a, b) =>
            a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()));
      _filtered = _filtered
          .where((movie) => movie.title!.toLowerCase().contains(query))
          .toList();
      return _filtered;
    }

    await LunaBottomModalSheet().show(
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrManualImportDetailsTileState>(),
        builder: (context, _) => FutureBuilder(
          future: context.watch<RadarrState>().movies,
          builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to fetch Radarr movies',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage(text: 'lunasea.AnErrorHasOccurred'.tr());
            }
            if (snapshot.hasData) {
              if ((snapshot.data?.length ?? 0) == 0)
                return LunaMessage(text: 'radarr.NoMoviesFound'.tr());
              String _query = context
                  .watch<RadarrManualImportDetailsTileState>()
                  .configureMoviesSearchQuery;
              List<RadarrMovie> movies = _sortAndFilter(snapshot.data!, _query);
              // Return the final movie list
              return LunaListViewModalBuilder(
                itemCount: movies.isEmpty ? 1 : movies.length,
                itemBuilder: (context, index) {
                  if (movies.isEmpty) {
                    return LunaMessage.inList(
                      text: 'radarr.NoMoviesFound'.tr(),
                    );
                  }
                  String title = movies[index].title ?? LunaUI.TEXT_EMDASH;
                  if (movies[index].year != null && movies[index].year != 0)
                    title += ' (${movies[index].year})';
                  String? overview = movies[index].overview;
                  if (overview?.isEmpty ?? true)
                    overview = 'radarr.NoSummaryIsAvailable'.tr();
                  return LunaBlock(
                    title: title,
                    body: [
                      TextSpan(
                        text: overview,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    onTap: () {
                      result = true;
                      movie = movies[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
                appBar: LunaAppBar(
                  title: 'radarr.SelectMovie'.tr(),
                  bottom:
                      const RadarrManualImportDetailsConfigureMoviesSearchBar(),
                  hideLeading: true,
                ),
                appBarHeight: LunaAppBar.APPBAR_HEIGHT +
                    LunaTextInputBar.defaultAppBarHeight,
              );
            }
            return const LunaLoader();
          },
        ),
      ),
    );
    return Tuple2(result, movie);
  }
}
