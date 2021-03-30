import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrBottomModalSheets {
    Future<void> configureManualImport(BuildContext context) async {
        await LunaBottomModalSheet().showModal(
            context: context,
            expand: false,
            builder: (_) => ChangeNotifierProvider.value(
                value: context.read<RadarrManualImportDetailsTileState>(),
                builder: (context, _) => LunaListViewModal(
                    children: [
                        LunaHeader(
                            text: 'radarr.Configure'.tr(),
                            subtitle: context.read<RadarrManualImportDetailsTileState>().manualImport.relativePath,
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectMovie'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaMovie),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                Tuple2<bool, RadarrMovie> result = await selectMovie(context);
                                if(result.item1) context.read<RadarrManualImportDetailsTileState>().fetchUpdates(context, result.item2.id);
                            },
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectQuality'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaQualityProfile),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                List<RadarrQualityDefinition> profiles = await context.read<RadarrState>().qualityDefinitions;
                                Tuple2<bool, RadarrQualityDefinition> result = await RadarrDialogs().selectQualityDefinition(context, profiles);
                                if(result.item1) context.read<RadarrManualImportDetailsTileState>().updateQuality(result.item2.quality);
                            },
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectLanguage'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaLanguage),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                List<RadarrLanguage> languages = await context.read<RadarrState>().languages;
                                await RadarrDialogs().setManualImportLanguages(context, languages);
                            },
                        ),
                    ],
                ),
            ),
        );
    }

    Future<Tuple2<bool, RadarrMovie>> selectMovie(BuildContext context) async {
        bool result = false;
        RadarrMovie movie;
        TextEditingController _textController = TextEditingController();
        await LunaBottomModalSheet().showModal(
            context: context,
            builder: (_) => ChangeNotifierProvider.value(
                value: context.read<RadarrManualImportDetailsTileState>(),
                builder: (context, _) => Scaffold(
                    appBar: LunaAppBar.empty(
                        child: LunaTextInputBar(
                            controller: _textController,
                            autofocus: false,
                            // onChanged: (value) => context.read<RadarrAddMovieState>().searchQuery = value,
                            // onSubmitted: (value) {
                            //     if(value.isNotEmpty) context.read<RadarrAddMovieState>().fetchLookup(context);
                            // },
                            margin: EdgeInsets.only(top: 12.0),
                        ),
                        height: 76.0,
                    ),
                    body: FutureBuilder(
                        future: context.read<RadarrState>().movies,
                        builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
                            if(snapshot.hasError) {
                                if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                                    'Unable to fetch Radarr movies',
                                    snapshot.error,
                                    snapshot.stackTrace,
                                );
                                return LunaMessage(text: 'lunasea.AnErrorHasOccurred'.tr());
                            }
                            if(snapshot.hasData) {
                                if((snapshot.data?.length ?? 0) == 0) return LunaMessage(text: 'radarr.NoMoviesFound'.tr());
                                List<RadarrMovie> movies = snapshot.data..sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()));
                                return LunaListViewModalBuilder(
                                    itemCount: movies.length,
                                    itemBuilder: (context, index) => LunaListTile(
                                        context: context,
                                        title: LunaText.title(text: [
                                            movies[index].title,
                                            if(movies[index].year != null && movies[index].year != 0) '(${movies[index].year})',
                                        ].join(' ')),
                                        subtitle: LunaText.subtitle(text: movies[index].overview),
                                        contentPadding: false,
                                        onTap: () {
                                            result = true;
                                            movie = movies[index];
                                            Navigator.of(context).pop();
                                        },
                                    ),
                                    shrinkWrap: false,
                                );
                            }
                            return LunaLoader();
                        },
                    ),
                ),
            ),
        );
        return Tuple2(result, movie);
    }
}
