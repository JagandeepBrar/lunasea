import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class GlobalDialogs {
    GlobalDialogs._();

    static Future<List<dynamic>> editText(BuildContext context, String title, { String prefill = '' }) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = prefill;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: title,
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: title,
                        onSubmitted: (_) => _setValues(true),
                        validator: (_) => null,
                    ),
                ),
            ],
            contentPadding: LSDialog.inputDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    static Future<void> textPreview(BuildContext context, String title, String text, { bool alignLeft = false }) async {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Close',
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
                title: LSDialog.title(text: title),
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(
                            text: text,
                            textAlign: alignLeft
                                ? TextAlign.left
                                : TextAlign.center,
                        ),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
            ),
        );
    }

    static Future<List<dynamic>> deleteCatalogueWithFiles(BuildContext context, String title) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete All Files',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LSColors.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete all the files and folders for $title?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }
}
