import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDialogs {
    SonarrDialogs._();

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
        bool _flag = false;
        SonarrGlobalSettingsType _value;
        
        void _setValues(bool flag, SonarrGlobalSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Sonarr Settings',
            content: List.generate(
                SonarrGlobalSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrGlobalSettingsType.values[index].name,
                    icon: SonarrGlobalSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrGlobalSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> seriesSettings(BuildContext context, SonarrSeries series) async {
        bool _flag = false;
        SonarrSeriesSettingsType _value;
        
        void _setValues(bool flag, SonarrSeriesSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: series.title,
            content: List.generate(
                SonarrSeriesSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrSeriesSettingsType.values[index].name(series),
                    icon: SonarrSeriesSettingsType.values[index].icon(series),
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrSeriesSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> episodeSettings(BuildContext context, SonarrEpisode episode) async {
        bool _flag = false;
        SonarrEpisodeSettingsType _value;
        
        void _setValues(bool flag, SonarrEpisodeSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: episode.title,
            content: List.generate(
                episode.hasFile
                    ? SonarrEpisodeSettingsType.values.length
                    : SonarrEpisodeSettingsType.values.length-1,
                (index) => LSDialog.tile(
                    text: SonarrEpisodeSettingsType.values[index].name(episode),
                    icon: SonarrEpisodeSettingsType.values[index].icon(episode),
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrEpisodeSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> seasonSettings(BuildContext context, int seasonNumber) async {
        bool _flag = false;
        SonarrSeasonSettingsType _value;
        
        void _setValues(bool flag, SonarrSeasonSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: seasonNumber == 0 ? 'Specials' : 'Season $seasonNumber',
            content: List.generate(
                context.read<SonarrState>().enableVersion3
                    ? SonarrSeasonSettingsType.values.length
                    : SonarrSeasonSettingsType.values.length-1,
                (index) => LSDialog.tile(
                    text: SonarrSeasonSettingsType.values[index].name,
                    icon: SonarrSeasonSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrSeasonSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _value];
    }

    static Future<List<dynamic>> setDefaultPage(BuildContext context, {
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

        await LSDialog.dialog(
            context: context,
            title: 'Default Page',
            content: List.generate(
                titles.length,
                (index) => LSDialog.tile(
                    text: titles[index],
                    icon: icons[index],
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        
        return [_flag, _index];
    }

    static Future<void> setAddTags(BuildContext context) async {
        await showDialog(
            context: context,
            builder: (dContext) => ChangeNotifierProvider.value(
                value: context.read<SonarrSeriesAddDetailsState>(),
                builder: (context, _) => AlertDialog(
                    actions: <Widget>[
                        SonarrTagsAppBarActionAddTag(asDialogButton: true),
                        LSDialog.button(
                            text: 'Close',
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                        
                    ],
                    title: LSDialog.title(text: 'Tags'),
                    content: Selector<SonarrState, Future<List<SonarrTag>>>(
                        selector: (_, state) => state.tags,
                        builder: (context, future, _) => FutureBuilder(
                            future: future,
                            builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) => LSDialog.content(
                                children: (snapshot.data?.length ?? 0) == 0
                                ? [ LSDialog.textContent(text: 'No Tags Found') ]
                                : List.generate(
                                    snapshot.data.length,
                                    (index) => CheckboxListTile(
                                        title: Text(
                                            snapshot.data[index].label,
                                            style: TextStyle(
                                                fontSize: LSDialog.BODY_SIZE,
                                                color: Colors.white,
                                            ),
                                        ),
                                        value: context.watch<SonarrSeriesAddDetailsState>().tags.where((tag) => tag.id == snapshot.data[index].id).length != 0,
                                        onChanged: (selected) {
                                            List<SonarrTag> _tags = context.read<SonarrSeriesAddDetailsState>().tags;
                                            selected ? _tags.add(snapshot.data[index]) : _tags.removeWhere((tag) => tag.id == snapshot.data[index].id);
                                            context.read<SonarrSeriesAddDetailsState>().tags = _tags;
                                        },
                                        contentPadding: LSDialog.tileContentPadding(),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
                    shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                        ? LSRoundedShapeWithBorder()
                        : LSRoundedShape(),
                ),
            ),
        );
    }

    static Future<void> setEditTags(BuildContext context) async {
        await showDialog(
            context: context,
            builder: (dContext) => ChangeNotifierProvider.value(
                value: context.read<SonarrSeriesEditState>(),
                builder: (context, _) => AlertDialog(
                    actions: <Widget>[
                        SonarrTagsAppBarActionAddTag(asDialogButton: true),
                        LSDialog.button(
                            text: 'Close',
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                        
                    ],
                    title: LSDialog.title(text: 'Tags'),
                    content: Selector<SonarrState, Future<List<SonarrTag>>>(
                        selector: (_, state) => state.tags,
                        builder: (context, future, _) => FutureBuilder(
                            future: future,
                            builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) => LSDialog.content(
                                children: (snapshot.data?.length ?? 0) == 0
                                ? [ LSDialog.textContent(text: 'No Tags Found') ]
                                : List.generate(
                                    snapshot.data.length,
                                    (index) => CheckboxListTile(
                                        title: Text(
                                            snapshot.data[index].label,
                                            style: TextStyle(
                                                fontSize: LSDialog.BODY_SIZE,
                                                color: Colors.white,
                                            ),
                                        ),
                                        value: context.watch<SonarrSeriesEditState>().tags.where((tag) => tag.id == snapshot.data[index].id).length != 0,
                                        onChanged: (selected) {
                                            List<SonarrTag> _tags = context.read<SonarrSeriesEditState>().tags;
                                            selected ? _tags.add(snapshot.data[index]) : _tags.removeWhere((tag) => tag.id == snapshot.data[index].id);
                                            context.read<SonarrSeriesEditState>().tags = _tags;
                                        },
                                        contentPadding: LSDialog.tileContentPadding(),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
                    shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                        ? LSRoundedShapeWithBorder()
                        : LSRoundedShape(),
                ),
            ),
        );
    }

    static Future<List<dynamic>> addNewTag(BuildContext context) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController();

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Add Tag',
            buttons: [
                LSDialog.button(
                    text: 'Add',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Tag Label',
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            if(value == null || value.isEmpty) return 'Label cannot be empty';
                            return null;
                        },
                    ),
                ),
            ],
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<List<dynamic>> setDefaultSorting(BuildContext context, {
        @required List<String> titles,
    }) async {
        bool _flag = false;
        int _index = 0;

        void _setValues(bool flag, int index) {
            _flag = flag;
            _index = index;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Default Sorting',
            content: List.generate(
                titles.length,
                (index) => LSDialog.tile(
                    text: titles[index],
                    icon: Icons.sort,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        
        return [_flag, _index];
    }

    static Future<List<dynamic>> searchAllMissingEpisodes(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Missing Episodes',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing episodes?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> deleteTag(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete Tag',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this tag?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> editLanguageProfiles(BuildContext context, List<SonarrLanguageProfile> profiles) async {
        bool _flag = false;
        SonarrLanguageProfile profile;

        void _setValues(bool flag, SonarrLanguageProfile value) {
            _flag = flag;
            profile = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Language Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    text: profiles[index].name,
                    icon: Icons.portrait,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, profile];
    }

    static Future<List<dynamic>> editQualityProfile(BuildContext context, List<SonarrQualityProfile> profiles) async {
        bool _flag = false;
        SonarrQualityProfile profile;

        void _setValues(bool flag, SonarrQualityProfile value) {
            _flag = flag;
            profile = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Quality Profile',
            content: List.generate(
                profiles.length,
                (index) => LSDialog.tile(
                    text: profiles[index].name,
                    icon: Icons.portrait,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, profiles[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, profile];
    }

    static Future<List<dynamic>> editRootFolder(BuildContext context, List<SonarrRootFolder> folders) async {
        bool _flag = false;
        SonarrRootFolder _folder;

        void _setValues(bool flag, SonarrRootFolder value) {
            _flag = flag;
            _folder = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Root Folder',
            content: List.generate(
                folders.length,
                (index) => LSDialog.tile(
                    text: folders[index].path,
                    subtitle: LSDialog.richText(
                        children: [
                            LSDialog.bolded(text: folders[index].freeSpace.lsBytes_BytesToString())
                        ],
                    ),
                    icon: Icons.folder,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, folders[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _folder];
    }

    static Future<List<dynamic>> editMonitorStatus(BuildContext context) async {
        bool _flag = false;
        SonarrMonitorStatus _status;

        void _setValues(bool flag, SonarrMonitorStatus status) {
            _flag = flag;
            _status = status;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Monitor Status',
            content: List.generate(
                SonarrMonitorStatus.values.length,
                (index) => LSDialog.tile(
                    text: SonarrMonitorStatus.values[index].name,
                    icon: Icons.view_list,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrMonitorStatus.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _status];
    }

    static Future<List<dynamic>> editSeriesType(BuildContext context) async {
        bool _flag = false;
        SonarrSeriesType _type;

        void _setValues(bool flag, SonarrSeriesType type) {
            _flag = flag;
            _type = type;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Series Type',
            content: List.generate(
                SonarrSeriesType.values.length,
                (index) => LSDialog.tile(
                    text: SonarrSeriesType.values[index].value.lsLanguage_Capitalize(),
                    icon: Icons.folder_open,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, SonarrSeriesType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return [_flag, _type];
    }

    static Future<List<dynamic>> confirmDeleteSeries(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }
        
        await LSDialog.dialog(
            context: context,
            title: 'Remove Series',
            buttons: [
                LSDialog.button(
                    text: 'Remove',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to remove the series from Sonarr?\n'),
                Selector<SonarrState, bool>(
                    selector: (_, state) => state.removeSeriesDeleteFiles,
                    builder: (context, value, text) => CheckboxListTile(
                        title: text,
                        value: value,
                        onChanged: (selected) => Provider.of<SonarrState>(context, listen: false).removeSeriesDeleteFiles = selected,
                        contentPadding: LSDialog.tileContentPadding(),
                    ),
                    child: Text(
                        'Delete Files',
                        style: TextStyle(
                            fontSize: LSDialog.BODY_SIZE,
                            color: Colors.white,
                        ),
                    ),
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> confirmDeleteEpisodeFile(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }
        
        await LSDialog.dialog(
            context: context,
            title: 'Delete Episode File',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this episode file?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }

    static Future<List<dynamic>> confirmSeasonSearch(BuildContext context, int seasonNumber) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Season Search',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(
                    text: seasonNumber == 0
                        ? 'Search for all episodes in specials?'
                        : 'Search for all episodes in season $seasonNumber?',
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }
}
