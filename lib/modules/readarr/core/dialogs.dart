import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrDialogs {
  Future<Tuple2<bool, ReadarrGlobalSettingsType?>> globalSettings(
    BuildContext context,
  ) async {
    bool _flag = false;
    ReadarrGlobalSettingsType? _value;

    void _setValues(bool flag, ReadarrGlobalSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Settings'.tr(),
      content: List.generate(
        ReadarrGlobalSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: ReadarrGlobalSettingsType.values[index].name,
          icon: ReadarrGlobalSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () =>
              _setValues(true, ReadarrGlobalSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, ReadarrAuthorSettingsType?>> authorSettings(
    BuildContext context,
    ReadarrAuthor series,
  ) async {
    bool _flag = false;
    ReadarrAuthorSettingsType? _value;

    void _setValues(bool flag, ReadarrAuthorSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: series.title,
      content: List.generate(
        ReadarrAuthorSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: ReadarrAuthorSettingsType.values[index].name(series),
          icon: ReadarrAuthorSettingsType.values[index].icon(series),
          iconColor: LunaColours().byListIndex(index),
          onTap: () =>
              _setValues(true, ReadarrAuthorSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, ReadarrBookSettingsType?>> bookSettings(
    BuildContext context,
    ReadarrBook book,
  ) async {
    bool _flag = false;
    ReadarrBookSettingsType? _value;

    void _setValues(bool flag, ReadarrBookSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: book.title,
      content: List.generate(
        ReadarrBookSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: ReadarrBookSettingsType.values[index].name(book),
          icon: ReadarrBookSettingsType.values[index].icon(book),
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, ReadarrBookSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  static Future<List<dynamic>> setDefaultPage(
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

    return [_flag, _index];
  }

  Future<void> setAddTags(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dContext) => ChangeNotifierProvider.value(
        value: context.read<ReadarrAuthorAddDetailsState>(),
        builder: (context, _) =>
            Selector<ReadarrState, Future<List<ReadarrTag>>?>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<ReadarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const ReadarrTagsAppBarActionAddTag(asDialogButton: true),
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
                              .watch<ReadarrAuthorAddDetailsState>()
                              .tags
                              .where(
                                  (tag) => tag.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<ReadarrTag> _tags = context
                                .read<ReadarrAuthorAddDetailsState>()
                                .tags;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<ReadarrAuthorAddDetailsState>().tags =
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
        value: context.read<ReadarrAuthorEditState>(),
        builder: (context, _) =>
            Selector<ReadarrState, Future<List<ReadarrTag>>?>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<ReadarrTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const ReadarrTagsAppBarActionAddTag(asDialogButton: true),
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
                              .watch<ReadarrAuthorEditState>()
                              .tags
                              ?.where((t) => t.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<ReadarrTag> _tags =
                                context.read<ReadarrAuthorEditState>().tags!;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<ReadarrAuthorEditState>().tags = _tags;
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
              if (value?.isEmpty ?? true) return 'Label cannot be empty';
              return null;
            },
          ),
        ),
      ],
      contentPadding: LunaDialog.inputDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
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
      title: 'readarr.MissingEpisodes'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'readarr.Search'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'readarr.MissingEpisodesHint1'.tr(),
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

  Future<Tuple2<bool, ReadarrMetadataProfile?>> editMetadataProfiles(
      BuildContext context, List<ReadarrMetadataProfile?> profiles) async {
    bool _flag = false;
    ReadarrMetadataProfile? profile;

    void _setValues(bool flag, ReadarrMetadataProfile? value) {
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

  Future<Tuple2<bool, ReadarrQualityProfile?>> editQualityProfile(
      BuildContext context, List<ReadarrQualityProfile?> profiles) async {
    bool _flag = false;
    ReadarrQualityProfile? profile;

    void _setValues(bool flag, ReadarrQualityProfile? value) {
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

  Future<Tuple2<bool, ReadarrRootFolder?>> editRootFolder(
      BuildContext context, List<ReadarrRootFolder> folders) async {
    bool _flag = false;
    ReadarrRootFolder? _folder;

    void _setValues(bool flag, ReadarrRootFolder value) {
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
          text: folders[index].path!,
          subtitle: LunaDialog.richText(
            children: [
              LunaDialog.bolded(
                text: folders[index].freeSpace.lunaBytesToString(),
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

  Future<Tuple2<bool, ReadarrAuthorMonitorType?>> editMonitorType(
      BuildContext context) async {
    bool _flag = false;
    ReadarrAuthorMonitorType? _type;

    void _setValues(bool flag, ReadarrAuthorMonitorType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Monitoring Options',
      content: List.generate(
        ReadarrAuthorMonitorType.values.length,
        (index) => LunaDialog.tile(
          text: ReadarrAuthorMonitorType.values[index].lunaName,
          icon: Icons.view_list_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, ReadarrAuthorMonitorType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _type);
  }

  Future<bool> removeAuthor(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'readarr.RemoveAuthor'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.AddToExclusionList'.tr(),
            value: ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.put(value),
          ),
        ),
        ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.DeleteFiles'.tr(),
            value: ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.put(value),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> removeBook(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'readarr.RemoveBook'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.AddToExclusionList'.tr(),
            value: ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST.put(value),
          ),
        ),
        ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.DeleteFiles'.tr(),
            value: ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES.put(value),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<void> addSeriesOptions(BuildContext context) async {
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
        ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.StartSearchForMissingEpisodes'.tr(),
            value: ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING.put(value),
          ),
        ),
        ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.StartSearchForCutoffUnmetEpisodes'.tr(),
            value: ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.data,
            onChanged: (value) => ReadarrDatabaseValue
                .ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET
                .put(value),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
  }

  Future<bool> deleteBookFile(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'readarr.DeleteBookFile'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'readarr.DeleteEpisodeFileHint1'.tr()),
      ],
      contentPadding: LunaDialog.textDialogContentPadding(),
    );
    return _flag;
  }

  Future<bool> confirmSeasonSearch(
    BuildContext context,
    int seasonNumber,
  ) async {
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
    return _flag;
  }

  Future<bool> removeFromQueue(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'readarr.RemoveFromQueue'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        ReadarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.RemoveFromDownloadClient'.tr(),
            value: ReadarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT.put(value),
          ),
        ),
        ReadarrDatabaseValue.QUEUE_ADD_BLOCKLIST.listen(
          builder: (context, value, _) => LunaDialog.checkbox(
            title: 'readarr.AddReleaseToBlocklist'.tr(),
            value: ReadarrDatabaseValue.QUEUE_ADD_BLOCKLIST.data,
            onChanged: (value) =>
                ReadarrDatabaseValue.QUEUE_ADD_BLOCKLIST.put(value),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<void> showQueueStatusMessages(
    BuildContext context,
    List<ReadarrQueueStatusMessage> messages,
  ) async {
    if (messages.isEmpty) {
      return LunaDialogs().textPreview(
        context,
        'readarr.Messages'.tr(),
        'readarr.NoMessagesFound'.tr(),
      );
    }
    await LunaDialog.dialog(
      context: context,
      title: 'readarr.Messages'.tr(),
      cancelButtonText: 'lunasea.Close'.tr(),
      contentPadding: LunaDialog.listDialogContentPadding(),
      content: List.generate(
        messages.length,
        (index) => Padding(
          padding: LunaDialog.tileContentPadding(),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 32.0),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: LunaColours.orange,
                      size: 24.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      messages[index].title!,
                      style: const TextStyle(
                        fontSize: LunaDialog.BODY_SIZE,
                        color: LunaColours.orange,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: LunaUI.DEFAULT_MARGIN_SIZE / 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (messages[index].messages!.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 32.0 + LunaUI.ICON_SIZE,
                              ),
                              child: LunaDialog.richText(
                                children: [
                                  TextSpan(
                                    text: messages[index]
                                        .messages!
                                        .map((s) => '${LunaUI.TEXT_BULLET} $s')
                                        .join('\n'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Tuple2<bool, int>> setQueuePageSize(BuildContext context) async {
    bool _flag = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _textController = TextEditingController(
      text: ReadarrDatabaseValue.QUEUE_PAGE_SIZE.data.toString(),
    );

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
}
