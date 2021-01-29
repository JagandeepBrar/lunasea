import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDialogs {
    RadarrDialogs._();

    static Future<List<dynamic>> globalSettings(BuildContext context) async {
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
        return [_flag, _value];
    }

    static Future<List<dynamic>> movieSettings(BuildContext context, RadarrMovie movie) async {
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
}
