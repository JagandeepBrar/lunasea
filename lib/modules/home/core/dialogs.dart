import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class HomeDialogs {
    HomeDialogs._();

    static Future<List<dynamic>> defaultPage(BuildContext context) async {
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
                HomeNavigationBar.titles.length,
                (index) => LSDialog.tile(
                    text: HomeNavigationBar.titles[index],
                    icon: HomeNavigationBar.icons[index],
                    iconColor: LSColors.list(index),
                    onTap: () => _setValues(true, index),
                ),
            ),
            contentPadding: LSDialog.listDialogContentPadding(),
        );

        return [_flag, _index];
    }

    static Future<List<dynamic>> setPastDays(BuildContext context) async {
        bool _flag = false;
        GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        TextEditingController _textController = TextEditingController(text: HomeDatabaseValue.CALENDAR_DAYS_PAST.data.toString());

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Past Days',
            buttons: [
                LSDialog.button(
                    text: 'Set',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Set the number of days in the past to fetch calendar entries for.'),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Past Days',
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            int _value = int.tryParse(value);
                            if(_value != null && _value >= 1) return null;
                            return 'Minimum of 1 Day';
                        },
                        keyboardType: TextInputType.number,
                    ),
                ),              
            ],
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );

        return [_flag, int.tryParse(_textController.text) ?? 14];
    }

    static Future<List<dynamic>> setFutureDays(BuildContext context) async {
        bool _flag = false;
        GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        TextEditingController _textController = TextEditingController(text: HomeDatabaseValue.CALENDAR_DAYS_FUTURE.data.toString());

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: 'Future Days',
            buttons: [
                LSDialog.button(
                    text: 'Set',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Set the number of days in the future to fetch calendar entries for.'),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: 'Future Days',
                        onSubmitted: (_) => _setValues(true),
                        validator: (value) {
                            int _value = int.tryParse(value);
                            if(_value != null && _value >= 1) return null;
                            return 'Minimum of 1 Day';
                        },
                        keyboardType: TextInputType.number,
                    ),
                ),              
            ],
            contentPadding: LSDialog.inputTextDialogContentPadding(),
        );

        return [_flag, int.tryParse(_textController.text) ?? 14];
    }
}