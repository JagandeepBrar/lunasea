import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsTile extends StatelessWidget {
  final RadarrManualImport manualImport;

  const RadarrManualImportDetailsTile({
    Key? key,
    required this.manualImport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RadarrManualImportDetailsTileState(context, manualImport),
      builder: (context, _) => LunaExpandableListTile(
        key: ObjectKey(manualImport),
        title: context
            .watch<RadarrManualImportDetailsTileState>()
            .manualImport
            .relativePath!,
        collapsedTrailing: _trailing(context),
        collapsedSubtitles: [
          _subtitle1(context),
          _subtitle2(context),
        ],
        expandedTableButtons: _buttons(context),
        expandedTableContent: _table(context),
        backgroundColor: context
                .watch<RadarrManualImportDetailsState>()
                .selectedFiles
                .contains(manualImport.id)
            ? LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH)
            : null,
      ),
    );
  }

  TextSpan _subtitle1(BuildContext context) {
    return TextSpan(
      children: [
        TextSpan(
            text: context
                .watch<RadarrManualImportDetailsTileState>()
                .manualImport
                .lunaQualityProfile),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(
            text: context
                .watch<RadarrManualImportDetailsTileState>()
                .manualImport
                .lunaLanguage),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(
            text: context
                .watch<RadarrManualImportDetailsTileState>()
                .manualImport
                .lunaSize),
      ],
    );
  }

  TextSpan _subtitle2(BuildContext context) {
    return TextSpan(
      text: context
          .watch<RadarrManualImportDetailsTileState>()
          .manualImport
          .lunaMovie,
      style: const TextStyle(
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        color: LunaColours.accent,
      ),
    );
  }

  Widget _trailing(BuildContext context) {
    return Consumer<RadarrManualImportDetailsState>(
      builder: (context, state, _) => Checkbox(
        value: state.selectedFiles.contains(manualImport.id),
        onChanged: (value) => state.setSelectedFile(manualImport.id!, value!),
      ),
    );
  }

  List<LunaTableContent> _table(BuildContext context) {
    return [
      LunaTableContent(
        title: 'radarr.Movie'.tr(),
        body: context
            .watch<RadarrManualImportDetailsTileState>()
            .manualImport
            .lunaMovie,
      ),
      LunaTableContent(
        title: 'radarr.Quality'.tr(),
        body: context
            .watch<RadarrManualImportDetailsTileState>()
            .manualImport
            .lunaQualityProfile,
      ),
      LunaTableContent(
        title: 'radarr.Languages'.tr(),
        body: context
            .watch<RadarrManualImportDetailsTileState>()
            .manualImport
            .lunaLanguage,
      ),
      LunaTableContent(
        title: 'radarr.Size'.tr(),
        body: context
            .watch<RadarrManualImportDetailsTileState>()
            .manualImport
            .lunaSize,
      ),
    ];
  }

  List<LunaButton> _buttons(BuildContext context) {
    return [
      _configureButton(context),
      if ((context
                  .read<RadarrManualImportDetailsTileState>()
                  .manualImport
                  .rejections
                  ?.length ??
              0) >
          0)
        _rejectionsButton(context),
    ];
  }

  LunaButton _configureButton(BuildContext context) {
    return LunaButton.text(
        text: 'radarr.Configure'.tr(),
        icon: Icons.edit_rounded,
        onTap: () async {
          await RadarrBottomModalSheets().configureManualImport(context);
          Future.microtask(() => context
              .read<RadarrManualImportDetailsTileState>()
              .checkIfShouldSelect(context));
        });
  }

  LunaButton _rejectionsButton(BuildContext context) {
    return LunaButton.text(
      text: 'radarr.Rejected'.tr(),
      icon: Icons.report_outlined,
      color: LunaColours.red,
      onTap: () async => LunaDialogs().showRejections(
        context,
        context
                .read<RadarrManualImportDetailsTileState>()
                .manualImport
                .rejections
                ?.map<String>((rejection) => rejection.reason!)
                .toList() ??
            [],
      ),
    );
  }
}

class RadarrManualImportDetailsTileState extends ChangeNotifier {
  RadarrManualImportDetailsTileState(BuildContext context, this._manualImport) {
    checkIfShouldSelect(context);
  }

  String _configureMoviesSearchQuery = '';
  String get configureMoviesSearchQuery => _configureMoviesSearchQuery;
  set configureMoviesSearchQuery(String configureMoviesSearchQuery) {
    _configureMoviesSearchQuery = configureMoviesSearchQuery;
    notifyListeners();
  }

  RadarrManualImport _manualImport;
  RadarrManualImport get manualImport => _manualImport;
  set manualImport(RadarrManualImport manualImport) {
    _manualImport = manualImport;
    notifyListeners();
  }

  void addLanguage(RadarrLanguage language) {
    if ((_manualImport.languages ?? [])
            .indexWhere((lang) => lang.id == language.id) >=
        0) return;
    _manualImport.languages!.add(language);
    notifyListeners();
  }

  void removeLanguage(RadarrLanguage language) {
    int index = (_manualImport.languages ?? [])
        .indexWhere((lang) => lang.id == language.id);
    if (index == -1) return;
    _manualImport.languages!.removeAt(index);
    notifyListeners();
  }

  void checkIfShouldSelect(BuildContext context) {
    if (_manualImport.movie != null &&
        _manualImport.quality != null &&
        (_manualImport.languages?.length ?? 0) > 0 &&
        _manualImport.languages![0].id! >= 0)
      Future.microtask(() => context
          .read<RadarrManualImportDetailsState>()
          .addSelectedFile(_manualImport.id!));
  }

  Future<void> fetchUpdates(BuildContext context, int? movieId) async {
    if (context.read<RadarrState>().enabled) {
      RadarrManualImportUpdateData data = RadarrManualImportUpdateData(
        id: manualImport.id,
        path: manualImport.path,
        movieId: movieId,
        quality: manualImport.quality,
        languages: manualImport.languages,
      );
      context
          .read<RadarrState>()
          .api!
          .manualImport
          .update(data: [data]).then((value) {
        if (value.isNotEmpty) {
          RadarrManualImport _import = _manualImport;
          _import.movie = value[0].movie;
          _import.id = value[0].id;
          _import.path = value[0].path;
          _import.rejections = value[0].rejections;
          manualImport = _import;
        }
      });
    }
  }

  void updateQuality(RadarrQuality quality) {
    _manualImport.quality!.quality = quality;
    notifyListeners();
  }
}
