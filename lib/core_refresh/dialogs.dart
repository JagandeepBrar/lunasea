import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaDialogs {
    /// Show an an edit text prompt.
    /// 
    /// Can pass in [prefill] String to prefill the [TextFormField]. Can also pass in a list of [TextSpan] tp show text above the field.
    /// 
    /// Returns list containing:
    /// - 0: Flag (true if they hit save, false if they cancelled the prompt)
    /// - 1: Value from the [TextEditingController].
    Future<List<dynamic>> editText(BuildContext context, String dialogTitle, { String prefill = '', List<TextSpan> extraText }) async {
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        final _textController = TextEditingController()..text = prefill;

        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context, rootNavigator: true).pop();
            }
        }

        await LSDialog.dialog(
            context: context,
            title: dialogTitle,
            buttons: [
                LSDialog.button(
                    text: 'Save',
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                if((extraText?.length ?? 0) != 0) LSDialog.richText(children: extraText),
                Form(
                    key: _formKey,
                    child: LSDialog.textFormInput(
                        controller: _textController,
                        title: dialogTitle,
                        onSubmitted: (_) => _setValues(true),
                        validator: (_) => null,
                    ),
                ),
            ],
            contentPadding: (extraText?.length ?? 0) == 0 ? LSDialog.inputDialogContentPadding() : LSDialog.inputTextDialogContentPadding(),
        );
        return [_flag, _textController.text];
    }

    /// Show a text preview dialog.
    /// 
    /// Can pass in boolean [alignLeft] to left align the text in the dialog (useful for bulleted lists)
    Future<void> textPreview(BuildContext context, String dialogTitle, String text, { bool alignLeft = false }) async {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Copy',
                        onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: text));
                            LSSnackBar(
                                context: context,
                                title: 'Copied Content',
                                message: 'Copied text to the clipboard',
                                type: SNACKBAR_TYPE.info,
                            );
                            Navigator.of(context, rootNavigator: true).pop();
                        },
                    ),
                ],
                title: LSDialog.title(text: dialogTitle),
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

    /// **Will be removed in future**
    /// 
    /// Show a delete catalogue with all files warning dialog.
    Future<List<dynamic>> deleteCatalogueWithFiles(BuildContext context, String moduleTitle) async {
        bool _flag = false;

        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context, rootNavigator: true).pop();
        }

        await LSDialog.dialog(
            context: context,
            title: 'Delete All Files',
            buttons: [
                LSDialog.button(
                    text: 'Delete',
                    textColor: LunaColours.red,
                    onPressed: () => _setValues(true),
                ),
            ],
            content: [
                LSDialog.textContent(text: 'Are you sure you want to delete all the files and folders for $moduleTitle?'),
            ],
            contentPadding: LSDialog.textDialogContentPadding(),
        );
        return [_flag];
    }
}
