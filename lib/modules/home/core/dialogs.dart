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
            Navigator.of(context).pop();
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
}