import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class GlobalDialogs {
    GlobalDialogs._();

    static Future<List> editText(BuildContext context, String title, {String prefill = '', bool showHostHint = false}) async {
        //Returns
        bool _flag = false;
        final _formKey = GlobalKey<FormState>();
        TextEditingController _controller = TextEditingController()..text = prefill;
        //Setter
        void _setValues(bool flag) {
            if(_formKey.currentState.validate()) {
                _flag = flag;
                Navigator.of(context).pop();
            }
        }
        //Dialog
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Save',
                        textColor: LSColors.accent,
                        onPressed: () => _setValues(true)),
                ],
                content: LSDialog.content(
                    children: [
                        if(showHostHint) RichText(
                            text: TextSpan(
                                children: [
                                    LSDialog.textSpanContent(text: '•\tThis is the URL in which you access the web GUI for the service\n'),
                                    LSDialog.textSpanContent(text: '•\tYou must include either '),
                                    LSDialog.bolded(title: 'http://'),
                                    LSDialog.textSpanContent(text: ' or '),
                                    LSDialog.bolded(title: 'https://\n'),
                                    LSDialog.textSpanContent(text: '•\tWhen not using a reverse proxy, please include the port: '),
                                    LSDialog.bolded(title: 'url:port\n'),
                                    LSDialog.textSpanContent(text: '•\tTo add basic authentication, please set a custom header in the advanced section'),
                                ],
                            ),
                        ),
                        Form(
                            key: _formKey,
                            child: LSDialog.textFormInput(
                                controller: _controller,
                                title: title,
                                onSubmitted: (_) => _setValues(true),
                                validator: (_) => null,
                            ),
                        ),
                    ],
                ),
                contentPadding: showHostHint
                    ? LSDialog.inputTextDialogContentPadding()
                    : LSDialog.inputDialogContentPadding(),
            ),
        );
        return [_flag, _controller.text];
    }

    static Future<void> textPreview(BuildContext context, String title, String text, {bool alignLeft = false}) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.button(
                        text: 'Close',
                        onPressed: () => Navigator.of(context).pop(),
                        textColor: LSColors.accent,
                    ),
                ],
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
            ),
        );
    }

    static Future<List> deleteCatalogueWithFiles(BuildContext context, String title) async {
        //Returns
        bool _flag = false;
        //Setter
        void _setValues(bool flag) {
            _flag = flag;
            Navigator.of(context).pop();
        }
        await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: LSDialog.title(text: title),
                actions: <Widget>[
                    LSDialog.cancel(context),
                    LSDialog.button(
                        text: 'Delete',
                        textColor: LSColors.red,
                        onPressed: () => _setValues(true),
                    ),
                ],
                content: LSDialog.content(
                    children: [
                        LSDialog.textContent(text: 'Are you sure you want to delete all the files and folders for $title?'),
                    ],
                ),
                contentPadding: LSDialog.textDialogContentPadding(),
            ),
        );
        return [_flag];
    }
}
