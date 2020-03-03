import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LSDialogSearch {
    static Future<List> downloadNZB(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Download NZB'),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Cancel',
                        onPressed: () => Navigator.of(context).pop()
                    ),
                    LSDialog.button(
                        text: 'Download',
                        onPressed: () {
                            flag = true;
                            Navigator.of(context).pop();
                        },
                        textColor: LSColors.accent,
                    )
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(
                            text: 'Are you sure you want to download this NZB to your device?',
                        ),
                    ],
                ),
            ),
        );
        return [flag];
    }
}