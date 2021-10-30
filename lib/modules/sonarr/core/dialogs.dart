import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDialogs {
  Future<Tuple2<bool, SonarrGlobalSettingsType>> globalSettings(
    BuildContext context,
  ) async {
    bool _flag = false;
    SonarrGlobalSettingsType _value;

    void _setValues(bool flag, SonarrGlobalSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Settings'.tr(),
      content: List.generate(
        SonarrGlobalSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: SonarrGlobalSettingsType.values[index].name,
          icon: SonarrGlobalSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, SonarrGlobalSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, SonarrSeriesSettingsType>> seriesSettings(
    BuildContext context,
    SonarrSeries series,
  ) async {
    bool _flag = false;
    SonarrSeriesSettingsType _value;

    void _setValues(bool flag, SonarrSeriesSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: series.title,
      content: List.generate(
        SonarrSeriesSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: SonarrSeriesSettingsType.values[index].name(series),
          icon: SonarrSeriesSettingsType.values[index].icon(series),
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, SonarrSeriesSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  static Future<List<dynamic>> episodeSettings(
      BuildContext context, SonarrEpisode episode) async {
    bool _flag = false;
    SonarrEpisodeSettingsType _value;

    void _setValues(bool flag, SonarrEpisodeSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: episode.title,
      content: List.generate(
        episode.hasFile
            ? SonarrEpisodeSettingsType.values.length
            : SonarrEpisodeSettingsType.values.length - 1,
        (index) => LunaDialog.tile(
          text: SonarrEpisodeSettingsType.values[index].name(episode),
          icon: SonarrEpisodeSettingsType.values[index].icon(episode),
          iconColor: LunaColours().byListIndex(index),
          onTap: () =>
              _setValues(true, SonarrEpisodeSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> seasonSettings(
      BuildContext context, int seasonNumber) async {
    bool _flag = false;
    SonarrSeasonSettingsType _value;

    void _setValues(bool flag, SonarrSeasonSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: seasonNumber == 0 ? 'Specials' : 'Season $seasonNumber',
      content: List.generate(
        SonarrSeasonSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: SonarrSeasonSettingsType.values[index].name,
          icon: SonarrSeasonSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, SonarrSeasonSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return [_flag, _value];
  }

  static Future<List<dynamic>> setDefaultPage(
    BuildContext context, {
    @required List<String> titles,
    @required List<IconData> icons,
  }) async {
    bool _flag = false;
    int _index = 0;

    void _setValues(bool flag, int index) {
      _flag = flag;
      _index = index;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Page',
      content: List.generate(
        titles.length,
        (index) => LunaDialog.tile(
          text: titles[index],
          icon: icons[index],
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, index),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );

    return [_flag, _index];
  }

  Future<void> setAddTags(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dContext) => ChangeNotifierProvider.value(
        value: context.read<SonarrSeriesAddDetailsState>(),
        builder: (context, _) => Selector<SonarrState, Future<List<SonarrTag>>>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const SonarrTagsAppBarActionAddTag(asDialogButton: true),
                  LunaDialog.button(
                    text: 'Close',
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                  ),
                ],
                title: LunaDialog.title(text: 'Tags'),
                content: Builder(
                  builder: (context) {
                    if ((snapshot.data?.length ?? 0) == 0)
                      return LunaDialog.content(
                        children: [
                          LunaDialog.textContent(text: 'No Tags Found'),
                        ],
                      );
                    return LunaDialog.content(
                      children: List.generate(
                        snapshot.data.length,
                        (index) => LunaDialog.checkbox(
                          title: snapshot.data[index].label,
                          value: context
                              .watch<SonarrSeriesAddDetailsState>()
                              .tags
                              .where((tag) => tag.id == snapshot.data[index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<SonarrTag> _tags = context
                                .read<SonarrSeriesAddDetailsState>()
                                .tags;
                            selected
                                ? _tags.add(snapshot.data[index])
                                : _tags.removeWhere(
                                    (tag) => tag.id == snapshot.data[index].id);
                            context.read<SonarrSeriesAddDetailsState>().tags =
                                _tags;
                          },
                        ),
                      ),
                    );
                  },
                ),
                contentPadding: (snapshot.data?.length ?? 0) == 0
                    ? LunaDialog.textDialogContentPadding()
                    : LunaDialog.listDialogContentPadding(),
                shape: LunaUI.shapeBorder,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> setEditTags(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dContext) => ChangeNotifierProvider.value(
        value: context.read<SonarrSeriesEditState>(),
        builder: (context, _) => Selector<SonarrState, Future<List<SonarrTag>>>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const SonarrTagsAppBarActionAddTag(asDialogButton: true),
                  LunaDialog.button(
                    text: 'Close',
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                  ),
                ],
                title: LunaDialog.title(text: 'Tags'),
                content: Builder(
                  builder: (context) {
                    if ((snapshot.data?.length ?? 0) == 0)
                      return LunaDialog.content(
                        children: [
                          LunaDialog.textContent(text: 'No Tags Found'),
                        ],
                      );
                    return LunaDialog.content(
                      children: List.generate(
                        snapshot.data.length,
                        (index) => LunaDialog.checkbox(
                          title: snapshot.data[index].label,
                          value: context
                              .watch<SonarrSeriesEditState>()
                              .tags
                              .where((tag) => tag.id == snapshot.data[index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<SonarrTag> _tags =
                                context.read<SonarrSeriesEditState>().tags;
                            selected
                                ? _tags.add(snapshot.data[index])
                                : _tags.removeWhere(
                                    (tag) => tag.id == snapshot.data[index].id);
                            context.read<SonarrSeriesEditState>().tags = _tags;
                          },
                        ),
                      ),
                    );
                  },
                ),
                contentPadding: (snapshot.data?.length ?? 0) == 0
                    ? LunaDialog.textDialogContentPadding()
                    : LunaDialog.listDialogContentPadding(),
                shape: LunaUI.shapeBorder,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<Tuple2<bool, String>> addNewTag(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState.validate()) {
        _flag = flag;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Add Tag',
      buttons: [
        LunaDialog.button(
          text: 'Add',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'Tag Label',
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Label cannot be empty';
              return null;
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  Future<Tuple2<bool, int>> setDefaultSortingOrFiltering(
    BuildContext context, {
    @required List<String> titles,
  }) async {
    bool _flag = false;
    int _index = 0;

    void _setValues(bool flag, int index) {
      _flag = flag;
      _index = index;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Sorting & Filtering',
      content: List.generate(
        titles.length,
        (index) => LunaDialog.tile(
          text: titles[index],
          icon: Icons.sort,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, index),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );

    return Tuple2(_flag, _index);
  }

  Future<bool> searchAllMissingEpisodes(
    BuildContext context,
  ) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'sonarr.MissingEpisodes'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'sonarr.Search'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'sonarr.MissingEpisodesHint1'.tr(),
        ),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> deleteTag(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Delete Tag',
      buttons: [
        LunaDialog.button(
          text: 'Delete',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to delete this tag?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, SonarrLanguageProfile>> editLanguageProfiles(
      BuildContext context, List<SonarrLanguageProfile> profiles) async {
    bool _flag = false;
    SonarrLanguageProfile profile;

    void _setValues(bool flag, SonarrLanguageProfile value) {
      _flag = flag;
      profile = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Language Profile',
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          text: profiles[index].name,
          icon: Icons.portrait,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, profile);
  }

  Future<Tuple2<bool, SonarrQualityProfile>> editQualityProfile(
      BuildContext context, List<SonarrQualityProfile> profiles) async {
    bool _flag = false;
    SonarrQualityProfile profile;

    void _setValues(bool flag, SonarrQualityProfile value) {
      _flag = flag;
      profile = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Quality Profile',
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          text: profiles[index].name,
          icon: Icons.portrait,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, profile);
  }

  Future<Tuple2<bool, SonarrRootFolder>> editRootFolder(
      BuildContext context, List<SonarrRootFolder> folders) async {
    bool _flag = false;
    SonarrRootFolder _folder;

    void _setValues(bool flag, SonarrRootFolder value) {
      _flag = flag;
      _folder = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Root Folder',
      content: List.generate(
        folders.length,
        (index) => LunaDialog.tile(
          text: folders[index].path,
          subtitle: LunaDialog.richText(
            children: [
              LunaDialog.bolded(
                  text: folders[index].freeSpace.lunaBytesToString())
            ],
          ),
          icon: Icons.folder,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, folders[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _folder);
  }

  Future<Tuple2<bool, SonarrMonitorStatus>> editMonitorStatus(
      BuildContext context) async {
    bool _flag = false;
    SonarrMonitorStatus _status;

    void _setValues(bool flag, SonarrMonitorStatus status) {
      _flag = flag;
      _status = status;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Monitor Status',
      content: List.generate(
        SonarrMonitorStatus.values.length,
        (index) => LunaDialog.tile(
          text: SonarrMonitorStatus.values[index].name,
          icon: Icons.view_list,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, SonarrMonitorStatus.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _status);
  }

  Future<Tuple2<bool, SonarrSeriesType>> editSeriesType(
      BuildContext context) async {
    bool _flag = false;
    SonarrSeriesType _type;

    void _setValues(bool flag, SonarrSeriesType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Series Type',
      content: List.generate(
        SonarrSeriesType.values.length,
        (index) => LunaDialog.tile(
          text:
              SonarrSeriesType.values[index].value.lunaCapitalizeFirstLetters(),
          icon: Icons.folder_open,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, SonarrSeriesType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _type);
  }

  Future<bool> removeSeries(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'sonarr.RemoveSeries'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'sonarr.AddToExclusionList'.tr(),
            value: SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.data,
            onChanged: (value) =>
                SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.put(value),
          ),
        ),
        SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'sonarr.DeleteFiles'.tr(),
            value: SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.data,
            onChanged: (value) =>
                SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.put(value),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  static Future<List<dynamic>> confirmDeleteEpisodeFile(
      BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Delete Episode File',
      buttons: [
        LunaDialog.button(
          text: 'Delete',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to delete this episode file?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return [_flag];
  }

  static Future<List<dynamic>> confirmSeasonSearch(
      BuildContext context, int seasonNumber) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Season Search',
      buttons: [
        LunaDialog.button(
          text: 'Search',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: seasonNumber == 0
              ? 'Search for all episodes in specials?'
              : 'Search for all episodes in season $seasonNumber?',
        ),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return [_flag];
  }
}
