import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDialogSettings {
    static Future<List> deleteIndexer(BuildContext context) async {
        bool flag = false;
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: 'Delete Indexer'),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Cancel',
                        onPressed: () => Navigator.of(context).pop()
                    ),
                    LSDialog.button(
                        text: 'Delete',
                        onPressed: () {
                            flag = true;
                            Navigator.of(context).pop();
                        },
                        textColor: Colors.red,
                    ),
                ],
                content: LSDialog.content(children: [
                    LSDialog.textContent(
                        text: 'Are you sure you want to delete this indexer?'
                    ),
                ]),
            ),
        );
        return [flag];
    }
}