import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
    Future<Tuple2<bool, RadarrGlobalSettingsType>> globalSettings(BuildContext context) async {
        bool _flag = false;
        RadarrGlobalSettingsType _value;
        
        void _setValues(bool flag, RadarrGlobalSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Radarr Settings',
            content: List.generate(
                RadarrGlobalSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: RadarrGlobalSettingsType.values[index].name,
                    icon: RadarrGlobalSettingsType.values[index].icon,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, RadarrGlobalSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _value);
    }

    Future<Tuple2<bool, RadarrMovieSettingsType>> movieSettings(BuildContext context, RadarrMovie movie) async {
        bool _flag = false;
        RadarrMovieSettingsType _value;
        
        void _setValues(bool flag, RadarrMovieSettingsType value) {
            _flag = flag;
            _value = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: movie.title,
            content: List.generate(
                RadarrMovieSettingsType.values.length,
                (index) => LSDialog.tile(
                    text: RadarrMovieSettingsType.values[index].name(movie),
                    icon: RadarrMovieSettingsType.values[index].icon(movie),
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, RadarrMovieSettingsType.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _value);
    }

    Future<Tuple2<bool, int>> setDefaultPage(BuildContext context, {
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
            title: 'Page',
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
        
        return Tuple2(_flag, _index);
    }

    Future<Tuple2<bool, int>> setDefaultSortingOrFiltering(BuildContext context, {
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
            title: 'Sorting & Filtering',
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
        
        return Tuple2(_flag, _index);
    }

    Future<Tuple2<bool, String>> addNewTag(BuildContext context) async {
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
        return Tuple2(_flag, _textController.text);
    }

    Future<bool> deleteTag(BuildContext context) async {
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
        return _flag;
    }

    Future<bool> searchAllMissingMovies(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Missing Movies',
            buttons: [
                LSDialog.button(
                    text: 'Search',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to search for all missing movies?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    Future<bool> deleteMovieFile(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete File',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete this movie file?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return _flag;
    }

    Future<Tuple2<bool, RadarrAvailability>> editMinimumAvailability(BuildContext context) async {
        bool _flag = false;
        RadarrAvailability availability;

        void _setValues(bool flag, RadarrAvailability value) {
            _flag = flag;
            availability = value;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Minimum Availability',
            content: List.generate(
                RadarrAvailability.values.length,
                (index) => LSDialog.tile(
                    text: RadarrAvailability.values[index].readable,
                    icon: Icons.folder,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, RadarrAvailability.values[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, availability);
    }

    Future<Tuple2<bool, RadarrQualityProfile>> editQualityProfile(BuildContext context, List<RadarrQualityProfile> profiles) async {
        bool _flag = false;
        RadarrQualityProfile profile;

        void _setValues(bool flag, RadarrQualityProfile value) {
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
        return Tuple2(_flag, profile);
    }

    Future<void> setEditTags(BuildContext context) async {
        await showDialog(
            context: context,
            builder: (dContext) => ChangeNotifierProvider.value(
                value: context.read<RadarrMoviesEditState>(),
                builder: (context, _) => AlertDialog(
                    actions: <Widget>[
                        RadarrTagsAppBarActionAddTag(asDialogButton: true),
                        LSDialog.button(
                            text: 'Close',
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                        
                    ],
                    title: LSDialog.title(text: 'Tags'),
                    content: Selector<RadarrState, Future<List<RadarrTag>>>(
                        selector: (_, state) => state.tags,
                        builder: (context, future, _) => FutureBuilder(
                            future: future,
                            builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) => LSDialog.content(
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
                                        value: context.watch<RadarrMoviesEditState>().tags.where((tag) => tag.id == snapshot.data[index].id).length != 0,
                                        onChanged: (selected) {
                                            List<RadarrTag> _tags = context.read<RadarrMoviesEditState>().tags;
                                            selected ? _tags.add(snapshot.data[index]) : _tags.removeWhere((tag) => tag.id == snapshot.data[index].id);
                                            context.read<RadarrMoviesEditState>().tags = _tags;
                                        },
                                        contentPadding: LSDialog.tileContentPadding(),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
                    shape: LunaUI.shapeBorder,
                ),
            ),
        );
    }

    Future<void> setAddTags(BuildContext context) async {
        await showDialog(
            context: context,
            builder: (dContext) => ChangeNotifierProvider.value(
                value: context.read<RadarrAddMovieDetailsState>(),
                builder: (context, _) => AlertDialog(
                    actions: <Widget>[
                        RadarrTagsAppBarActionAddTag(asDialogButton: true),
                        LSDialog.button(
                            text: 'Close',
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                        
                    ],
                    title: LSDialog.title(text: 'Tags'),
                    content: Selector<RadarrState, Future<List<RadarrTag>>>(
                        selector: (_, state) => state.tags,
                        builder: (context, future, _) => FutureBuilder(
                            future: future,
                            builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) => LSDialog.content(
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
                                        value: context.watch<RadarrAddMovieDetailsState>().tags.where((tag) => tag.id == snapshot.data[index].id).length != 0,
                                        onChanged: (selected) {
                                            List<RadarrTag> _tags = context.read<RadarrAddMovieDetailsState>().tags;
                                            selected ? _tags.add(snapshot.data[index]) : _tags.removeWhere((tag) => tag.id == snapshot.data[index].id);
                                            context.read<RadarrAddMovieDetailsState>().tags = _tags;
                                        },
                                        contentPadding: LSDialog.tileContentPadding(),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    contentPadding: LSDialog.textDialogContentPadding(),
                    shape: LunaUI.shapeBorder,
                ),
            ),
        );
    }

    Future<Tuple2<bool, RadarrRootFolder>> editRootFolder(BuildContext context, List<RadarrRootFolder> folders) async {
        bool _flag = false;
        RadarrRootFolder _folder;

        void _setValues(bool flag, RadarrRootFolder value) {
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
                            LSDialog.bolded(text: folders[index].freeSpace.lunaBytesToString())
                        ],
                    ),
                    icon: Icons.folder,
                    iconColor: LunaColours.list(index),
                    onTap: () => _setValues(true, folders[index]),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );
        return Tuple2(_flag, _folder);
    }

    Future<bool> removeMovie(BuildContext context) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }
        
        await LSDialog.dialog(
            context: context,
            title: 'Remove Movie',
            buttons: [
                LSDialog.button(
                    text: 'Remove',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to remove the movie from Radarr?\n'),
                RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST.listen(
                    builder: (context, value, _) => LSDialog.checkbox(
                        title: 'Add to Exclusion List',
                        value: RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST.data,
                        onChanged: (value) => RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST.put(value),
                    ),
                ),
                RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES.listen(
                    builder: (context, value, _) => LSDialog.checkbox(
                        title: 'Delete Files',
                        value: RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES.data,
                        onChanged: (value) => RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES.put(value),
                    ),
                ),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return _flag;
    }
}
