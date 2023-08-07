import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarDialogs {
  Future<Tuple2<bool, MylarGlobalSettingsType?>> globalSettings(
    BuildContext context,
  ) async {
    bool _flag = false;
    MylarGlobalSettingsType? _value;

    void _setValues(bool flag, MylarGlobalSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'lunasea.Settings'.tr(),
      content: List.generate(
        MylarGlobalSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: MylarGlobalSettingsType.values[index].name,
          icon: MylarGlobalSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, MylarGlobalSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, MylarSeriesSettingsType?>> seriesSettings(
    BuildContext context,
    MylarSeries series,
  ) async {
    bool _flag = false;
    MylarSeriesSettingsType? _value;

    void _setValues(bool flag, MylarSeriesSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: series.title,
      content: List.generate(
        MylarSeriesSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: MylarSeriesSettingsType.values[index].name(series),
          icon: MylarSeriesSettingsType.values[index].icon(series),
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, MylarSeriesSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, MylarEpisodeSettingsType?>> episodeSettings({
    required BuildContext context,
    required MylarEpisode episode,
  }) async {
    bool _flag = false;
    MylarEpisodeSettingsType? _value;

    void _setValues(bool flag, MylarEpisodeSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: episode.title,
      content: List.generate(
        episode.hasFile!
            ? MylarEpisodeSettingsType.values.length
            : MylarEpisodeSettingsType.values.length - 1,
        (index) => LunaDialog.tile(
          text: MylarEpisodeSettingsType.values[index].name(episode),
          icon: MylarEpisodeSettingsType.values[index].icon(episode),
          iconColor: LunaColours().byListIndex(index),
          onTap: () =>
              _setValues(true, MylarEpisodeSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, MylarSeasonSettingsType?>> seasonSettings(
    BuildContext context,
    int? seasonNumber,
  ) async {
    bool _flag = false;
    MylarSeasonSettingsType? _value;

    void _setValues(bool flag, MylarSeasonSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: seasonNumber == 0
          ? 'mylar.Specials'.tr()
          : 'mylar.SeasonNumber'.tr(args: [seasonNumber.toString()]),
      content: List.generate(
        MylarSeasonSettingsType.values.length,
        (index) => LunaDialog.tile(
          text: MylarSeasonSettingsType.values[index].name,
          icon: MylarSeasonSettingsType.values[index].icon,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, MylarSeasonSettingsType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _value);
  }

  Future<Tuple2<bool, MylarEpisodeMultiSettingsType?>> episodeMultiSettings(
    BuildContext context,
    int episodes,
  ) async {
    bool _flag = false;
    MylarEpisodeMultiSettingsType? _value;

    void _setValues(bool flag, MylarEpisodeMultiSettingsType value) {
      _flag = flag;
      _value = value;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: episodes > 1
          ? 'mylar.EpisodesCount'.tr(args: [episodes.toString()])
          : 'mylar.OneEpisode'.tr(),
      content: List.generate(
        MylarEpisodeMultiSettingsType.values.length,
        (idx) => LunaDialog.tile(
          text: MylarEpisodeMultiSettingsType.values[idx].name,
          icon: MylarEpisodeMultiSettingsType.values[idx].icon,
          iconColor: LunaColours().byListIndex(idx),
          onTap: () {
            _setValues(true, MylarEpisodeMultiSettingsType.values[idx]);
          },
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
        value: context.read<MylarSeriesAddDetailsState>(),
        builder: (context, _) =>
            Selector<MylarState, Future<List<MylarTag>>?>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<MylarTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const MylarTagsAppBarActionAddTag(asDialogButton: true),
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
                              .watch<MylarSeriesAddDetailsState>()
                              .tags
                              .where(
                                  (tag) => tag.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<MylarTag> _tags = context
                                .read<MylarSeriesAddDetailsState>()
                                .tags;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<MylarSeriesAddDetailsState>().tags =
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
        value: context.read<MylarSeriesEditState>(),
        builder: (context, _) =>
            Selector<MylarState, Future<List<MylarTag>>?>(
          selector: (_, state) => state.tags,
          builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<List<MylarTag>> snapshot) {
              return AlertDialog(
                actions: <Widget>[
                  const MylarTagsAppBarActionAddTag(asDialogButton: true),
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
                              .watch<MylarSeriesEditState>()
                              .tags
                              ?.where((t) => t.id == snapshot.data![index].id)
                              .isNotEmpty,
                          onChanged: (selected) {
                            List<MylarTag> _tags =
                                context.read<MylarSeriesEditState>().tags!;
                            selected!
                                ? _tags.add(snapshot.data![index])
                                : _tags.removeWhere((tag) =>
                                    tag.id == snapshot.data![index].id);
                            context.read<MylarSeriesEditState>().tags = _tags;
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
      title: 'mylar.MissingEpisodes'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'mylar.Search'.tr(),
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(
          text: 'mylar.MissingEpisodesHint1'.tr(),
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

  Future<Tuple2<bool, MylarLanguageProfile?>> editLanguageProfiles(
      BuildContext context, List<MylarLanguageProfile?> profiles) async {
    bool _flag = false;
    MylarLanguageProfile? profile;

    void _setValues(bool flag, MylarLanguageProfile? value) {
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

  Future<Tuple2<bool, MylarQualityProfile?>> editQualityProfile(
      BuildContext context, List<MylarQualityProfile?> profiles) async {
    bool _flag = false;
    MylarQualityProfile? profile;

    void _setValues(bool flag, MylarQualityProfile? value) {
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

  Future<Tuple2<bool, MylarRootFolder?>> editRootFolder(
      BuildContext context, List<MylarRootFolder> folders) async {
    bool _flag = false;
    MylarRootFolder? _folder;

    void _setValues(bool flag, MylarRootFolder value) {
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

  Future<Tuple2<bool, MylarSeriesMonitorType?>> editMonitorType(
      BuildContext context) async {
    bool _flag = false;
    MylarSeriesMonitorType? _type;

    void _setValues(bool flag, MylarSeriesMonitorType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Monitoring Options',
      content: List.generate(
        MylarSeriesMonitorType.values.length,
        (index) => LunaDialog.tile(
          text: MylarSeriesMonitorType.values[index].lunaName,
          icon: Icons.view_list_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, MylarSeriesMonitorType.values[index]),
        ),
      ),
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return Tuple2(_flag, _type);
  }

  Future<Tuple2<bool, MylarSeriesType?>> editSeriesType(
      BuildContext context) async {
    bool _flag = false;
    MylarSeriesType? _type;

    void _setValues(bool flag, MylarSeriesType type) {
      _flag = flag;
      _type = type;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'Series Type',
      content: List.generate(
        MylarSeriesType.values.length,
        (index) => LunaDialog.tile(
          text: MylarSeriesType.values[index].value!.toTitleCase(),
          icon: Icons.folder_open_rounded,
          iconColor: LunaColours().byListIndex(index),
          onTap: () => _setValues(true, MylarSeriesType.values[index]),
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
      title: 'mylar.RemoveSeries'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        MylarDatabase.REMOVE_SERIES_EXCLUSION_LIST.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.AddToExclusionList'.tr(),
            value: MylarDatabase.REMOVE_SERIES_EXCLUSION_LIST.read(),
            onChanged: (value) =>
                MylarDatabase.REMOVE_SERIES_EXCLUSION_LIST.update(value!),
          ),
        ),
        MylarDatabase.REMOVE_SERIES_DELETE_FILES.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.DeleteFiles'.tr(),
            value: MylarDatabase.REMOVE_SERIES_DELETE_FILES.read(),
            onChanged: (value) =>
                MylarDatabase.REMOVE_SERIES_DELETE_FILES.update(value!),
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
        MylarDatabase.ADD_SERIES_SEARCH_FOR_MISSING.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.StartSearchForMissingEpisodes'.tr(),
            value: MylarDatabase.ADD_SERIES_SEARCH_FOR_MISSING.read(),
            onChanged: (value) =>
                MylarDatabase.ADD_SERIES_SEARCH_FOR_MISSING.update(value!),
          ),
        ),
        MylarDatabase.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.StartSearchForCutoffUnmetEpisodes'.tr(),
            value: MylarDatabase.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.read(),
            onChanged: (value) => MylarDatabase
                .ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET
                .update(value!),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
  }

  Future<bool> deleteEpisode(BuildContext context) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await LunaDialog.dialog(
      context: context,
      title: 'mylar.DeleteEpisodeFile'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Delete'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        LunaDialog.textContent(text: 'mylar.DeleteEpisodeFileHint1'.tr()),
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
      title: 'mylar.RemoveFromQueue'.tr(),
      buttons: [
        LunaDialog.button(
          text: 'lunasea.Remove'.tr(),
          textColor: LunaColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        MylarDatabase.QUEUE_REMOVE_DOWNLOAD_CLIENT.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.RemoveFromDownloadClient'.tr(),
            value: MylarDatabase.QUEUE_REMOVE_DOWNLOAD_CLIENT.read(),
            onChanged: (value) =>
                MylarDatabase.QUEUE_REMOVE_DOWNLOAD_CLIENT.update(value!),
          ),
        ),
        MylarDatabase.QUEUE_ADD_BLOCKLIST.listenableBuilder(
          builder: (context, _) => LunaDialog.checkbox(
            title: 'mylar.AddReleaseToBlocklist'.tr(),
            value: MylarDatabase.QUEUE_ADD_BLOCKLIST.read(),
            onChanged: (value) =>
                MylarDatabase.QUEUE_ADD_BLOCKLIST.update(value!),
          ),
        ),
      ],
      contentPadding: LunaDialog.listDialogContentPadding(),
    );
    return _flag;
  }

  Future<void> showQueueStatusMessages(
    BuildContext context,
    List<MylarQueueStatusMessage> messages,
  ) async {
    if (messages.isEmpty) {
      return LunaDialogs().textPreview(
        context,
        'mylar.Messages'.tr(),
        'mylar.NoMessagesFound'.tr(),
      );
    }
    await LunaDialog.dialog(
      context: context,
      title: 'mylar.Messages'.tr(),
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
                      LunaIcons.WARNING,
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
      text: MylarDatabase.QUEUE_PAGE_SIZE.read().toString(),
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
