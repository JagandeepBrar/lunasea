import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
  Future<Tuple2<bool, RadarrGlobalSettingsType?>> globalSettings(
    BuildContext context,
  ) async {
    bool _flag = false;
    RadarrGlobalSettingsType? _value;

    void _setValues(bool flag, RadarrGlobalSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Settings'.tr(),
      content: List.generate(
        RadarrGlobalSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: RadarrGlobalSettingsType.values[index].name,
          icon: RadarrGlobalSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, RadarrGlobalSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, RadarrMovieSettingsType?>> movieSettings(
    BuildContext context,
    RadarrMovie movie,
  ) async {
    bool _flag = false;
    RadarrMovieSettingsType? _value;

    void _setValues(bool flag, RadarrMovieSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: movie.title,
      content: List.generate(
        RadarrMovieSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: RadarrMovieSettingsType.values[index].name(movie),
          icon: RadarrMovieSettingsType.values[index].icon(movie),
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, RadarrMovieSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, int>> setDefaultPage(
    BuildContext context, {
    required List<String> titles,
    required List<IconData> icons,
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

    return Tuple2(_flag, _index);
  }

  Future<Tuple2<bool, RadarrImportMode?>> setManualImportMode(
      BuildContext context) async {
    bool _flag = false;
    RadarrImportMode? _mode;

    void _setValues(bool flag, RadarrImportMode mode) {
      _flag = flag;
      _mode = mode;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'radarr.ImportMode'.tr(),
      content: List.generate(
        RadarrImportMode.values.length,
        (index) => LunaDialog.tile(
          text: RadarrImportMode.values[index].lunaReadable,
          icon: RadarrImportMode.values[index].lunaIcon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, RadarrImportMode.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );

    return Tuple2(_flag, _mode);
  }

  Future<Tuple2<bool, String>> addNewTag(BuildContext context) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController();

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
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

  Future<bool> searchAllMissingMovies(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Missing Movies',
      buttons: [
        LunaDialog.button(
          text: 'Search',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to search for all missing movies?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> deleteMovieFile(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Delete File',
      buttons: [
        LunaDialog.button(
          text: 'Delete',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Are you sure you want to delete this movie file?'),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, RadarrAvailability?>> editMinimumAvailability(
      BuildContext context) async {
    bool _flag = false;
    RadarrAvailability? availability;

    void _setValues(bool flag, RadarrAvailability value) {
      _flag = flag;
      availability = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    List<RadarrAvailability> _values = RadarrAvailability.values.where((a) {
      if (a == RadarrAvailability.PREDB) return false;
      if (a == RadarrAvailability.TBA) return false;
      return true;
    }).toList();

    await LunaDialog.dialog(
      context: context,
      title: 'radarr.MinimumAvailability'.tr(),
      content: List.generate(
        _values.length,
        (index) => LunaDialog.tile(
          text: _values[index].readable,
          icon: Icons.folder_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, _values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, availability);
  }

  Future<Tuple2<bool, RadarrQualityProfile?>> editQualityProfile(
      BuildContext context, List<RadarrQualityProfile?> profiles) async {
    bool _flag = false;
    RadarrQualityProfile? profile;

    void _setValues(bool flag, RadarrQualityProfile? value) {
      _flag = flag;
      profile = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'radarr.QualityProfile'.tr(),
      content: List.generate(
        profiles.length,
        (index) => LunaDialog.tile(
          text: profiles[index]!.name!,
          icon: Icons.portrait_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, profiles[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, profile);
  }

  Future<Tuple2<bool, RadarrQualityDefinition?>> selectQualityDefinition(
      BuildContext context, List<RadarrQualityDefinition> definitions) async {
    bool _flag = false;
    RadarrQualityDefinition? profile;

    void _setValues(bool flag, RadarrQualityDefinition value) {
      _flag = flag;
      profile = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'radarr.Quality'.tr(),
      content: List.generate(
        definitions.length,
        (index) => LunaDialog.tile(
          text: definitions[index].title!,
          icon: Icons.portrait_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, definitions[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, profile);
  }

  Future<void> setManualImportLanguages(
      BuildContext context, List<RadarrLanguage> languages) async {
    List<RadarrLanguage> filteredLanguages =
        languages.where((lang) => lang.id! >= 0).toList();
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrManualImportDetailsTileState>(),
        builder: (context, _) => AlertDialog(
          actions: <Widget>[
            LunaDialog.button(
              text: 'Close',
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ],
          title: LunaDialog.title(text: 'radarr.Languages'.tr()),
          content: Consumer<RadarrManualImportDetailsTileState>(
            builder: (context, manualImport, _) => LunaDialog.content(
              children: List.generate(
                filteredLanguages.length,
                (index) => LunaDialog.checkbox(
                    title: filteredLanguages[index].name!,
                    value: context
                            .read<RadarrManualImportDetailsTileState>()
                            .manualImport
                            .languages
                            ?.indexWhere((lang) =>
                                lang.id == filteredLanguages[index].id) !=
                        -1,
                    onChanged: (value) => value!
                        ? context
                            .read<RadarrManualImportDetailsTileState>()
                            .addLanguage(filteredLanguages[index])
                        : context
                            .read<RadarrManualImportDetailsTileState>()
                            .removeLanguage(filteredLanguages[index])),
              ),
            ),
          ),
          contentPadding: LunaDialog.listDialogContentPadding(),
          shape: LunaUI.shapeBorder,
        ),
      ),
    );
  }

  Future<void> setEditTags(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrMoviesEditState>(),
        builder: (context, _) => Selector<RadarrState, Future<List<RadarrTag>>>(
          selector: (_, state) => state.tags!,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const RadarrTagsAppBarActionAddTag(asDialogButton: true),
                  LunaDialog.button(
                    text: 'Close',
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                  ),
                ],
                title: LunaDialog.title(text: 'radarr.Tags'.tr()),
                content: Builder(
                  builder: (context) {
                    if (snapshot.data?.isEmpty ?? true)
                      return LunaDialog.content(
                        children: [
                          LunaDialog.textContent(
                            text: 'radarr.NoTagsFound'.tr(),
                          ),
                        ],
                      );
                    return LunaDialog.content(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => LunaDialog.checkbox(
                          title: snapshot.data![index].label!,
                          value: context
                              .watch<RadarrMoviesEditState>()
                              .tags
                              .where(
                                  (tag) => tag.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<RadarrTag> _tags =
                                context.read<RadarrMoviesEditState>().tags;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<RadarrMoviesEditState>().tags = _tags;
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

  Future<bool> confirmDeleteQueue(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Remove From Queue',
      buttons: [
        LunaDialog.button(
          text: 'Remove',
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        RadarrDatabase.QUEUE_REMOVE_FROM_CLIENT.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'Remove From Client',
            value: RadarrDatabase.QUEUE_REMOVE_FROM_CLIENT.read(),
            onChanged: (selected) =>
                RadarrDatabase.QUEUE_REMOVE_FROM_CLIENT.update(selected!),
          ),
        ),
        RadarrDatabase.QUEUE_BLACKLIST.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'Blacklist Release',
            value: RadarrDatabase.QUEUE_BLACKLIST.read(),
            onChanged: (selected) =>
                RadarrDatabase.QUEUE_BLACKLIST.update(selected!),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<void> setAddTags(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<RadarrAddMovieDetailsState>(),
        builder: (context, _) => Selector<RadarrState, Future<List<RadarrTag>>>(
          selector: (_, state) => state.tags!,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const RadarrTagsAppBarActionAddTag(asDialogButton: true),
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
                        snapshot.data!.length,
                        (index) => LunaDialog.checkbox(
                          title: snapshot.data![index].label!,
                          value: context
                              .watch<RadarrAddMovieDetailsState>()
                              .tags
                              .where(
                                  (tag) => tag.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<RadarrTag> _tags =
                                context.read<RadarrAddMovieDetailsState>().tags;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<RadarrAddMovieDetailsState>().tags =
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

  Future<Tuple2<bool, RadarrRootFolder?>> editRootFolder(
      BuildContext context, List<RadarrRootFolder> folders) async {
    bool _flag = false;
    RadarrRootFolder? _folder;

    void _setValues(bool flag, RadarrRootFolder value) {
      _flag = flag;
      _folder = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'radarr.RootFolder'.tr(),
      content: List.generate(
        folders.length,
        (index) => LunaDialog.tile(
          text: folders[index].path!,
          subtitle: LunaDialog.richText(
            children: [
              LunaDialog.bolded(
                text: folders[index].freeSpace.asBytes(),
                fontSize: LunaDialog.BUTTON_SIZE,
              ),
            ],
          ) as RichText?,
          icon: Icons.folder_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, folders[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _folder);
  }

  Future<bool> removeMovie(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Remove Movie',
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        RadarrDatabase.REMOVE_MOVIE_IMPORT_LIST.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'Add to Exclusion List',
            value: RadarrDatabase.REMOVE_MOVIE_IMPORT_LIST.read(),
            onChanged: (value) =>
                RadarrDatabase.REMOVE_MOVIE_IMPORT_LIST.update(value!),
          ),
        ),
        RadarrDatabase.REMOVE_MOVIE_DELETE_FILES.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'Delete Files',
            value: RadarrDatabase.REMOVE_MOVIE_DELETE_FILES.read(),
            onChanged: (value) =>
                RadarrDatabase.REMOVE_MOVIE_DELETE_FILES.update(value!),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<Tuple2<bool, int>> setQueuePageSize(BuildContext context) async {
    bool _flag = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _textController = TextEditingController(
        text: RadarrDatabase.QUEUE_PAGE_SIZE.read().toString());

    void _setValues(bool flag) {
      if (_formKey.currentState!.validate()) {
        _flag = flag;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Queue Size',
      buttons: [
        LunaDialog.button(
          text: 'Set',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
            text: 'Set the amount of items fetched for the queue.'),
        Form(
          key: _formKey,
          child: LunaDialog.textFormInput(
            controller: _textController,
            title: 'Queue Page Size',
            onSubmitted: (_) => _setValues(true),
            validator: (value) {
              int? _value = int.tryParse(value!);
              if (_value != null && _value >= 1) return null;
              return 'Minimum of 1 Item';
            },
            keyboardType: TextInputType.number,
          ),
        ),
      ],
      contentPadding: LunaDialog.inputTextDialogContentPadding(),
    );

    return Tuple2(_flag, int.tryParse(_textController.text) ?? 50);
  }

  Future<void> addMovieOptions(BuildContext context) async {
    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Options'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Close'.tr(),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
      showCancelButton: false,
      content: [
        RadarrDatabase.ADD_MOVIE_SEARCH_FOR_MISSING.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'radarr.StartSearchForMissingMovie'.tr(),
            value: RadarrDatabase.ADD_MOVIE_SEARCH_FOR_MISSING.read(),
            onChanged: (value) =>
                RadarrDatabase.ADD_MOVIE_SEARCH_FOR_MISSING.update(value!),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
  }

  Future<bool> moveFiles() async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(LunaState.context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: LunaState.context,
      title: 'radarr.MoveFiles'.tr(),
      contentPadding: LunaDialog.textDialogContentPadding(),
      cancelButtonText: 'lunasea.No'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Yes'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'radarr.MoveFilesDescription'.tr()),
      ],
    );

    return _flag;
  }
}
