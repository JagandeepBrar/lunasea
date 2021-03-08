import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTextInputBar extends StatefulWidget {
    final TextEditingController controller;
    final TextInputAction action;
    final TextInputType keyboardType;
    final Iterable<String> autofillHints;
    final String labelText;
    final IconData labelIcon;
    final bool autofocus;
    final bool obscureText;
    final bool isFormField;
    final void Function(String) onChanged;
    final void Function(String) onSubmitted;
    final String Function(String) validator;
    final EdgeInsets margin;

    LunaTextInputBar({
        @required this.controller,
        this.onChanged,
        this.onSubmitted,
        this.validator,
        this.autofillHints,
        this.action = TextInputAction.search,
        this.keyboardType = TextInputType.text,
        this.labelText,
        this.labelIcon = Icons.search,
        this.margin = LunaUI.MARGIN_CARD,
        this.autofocus = false,
        this.obscureText = false,
        this.isFormField = false,
    }) {
        assert(controller != null);
    }

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaTextInputBar> {
    bool _isFocused = false;

    @override
    Widget build(BuildContext context) => LSCard(
        margin: widget.margin,
        child: FocusScope(
            child: Focus(
                onFocusChange: (value) => setState(() => _isFocused = value),
                child: widget.isFormField ? _isForm : _isNotForm,
            ),
        ),
        color: Theme.of(context).canvasColor,
    );

    TextStyle get _sharedTextStyle => TextStyle(
        color: Colors.white,
        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
    );

    InputDecoration get _sharedInputDecoration => InputDecoration(
        labelText: widget.labelText ?? 'lunasea.SearchTextBar'.tr(),
        labelStyle: TextStyle(
            color: Colors.white54,
            decoration: TextDecoration.none,
            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
        ),
        suffixIcon: AnimatedOpacity(
            child: GestureDetector(
                child: Icon(
                    Icons.close,
                    color: LunaColours.accent,
                    size: 24.0,
                ),
                onTap: widget.onChanged == null ? null : () {
                    widget.controller.text = '';
                    widget.onChanged('');
                }
            ),
            opacity: !_isFocused || widget.controller.text == '' ? 0.0 : 1.0,
            duration: Duration(milliseconds: 200),
        ),
        icon: Padding(
            child: Icon(
                widget.labelIcon,
                color: LunaColours.accent,
            ),
            padding: EdgeInsets.only(left: 16.0),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
    );

    TextFormField get _isForm => TextFormField(
        autofillHints: widget.autofillHints,
        autofocus: widget.autofocus,
        controller: widget.controller,
        decoration: _sharedInputDecoration,
        style: _sharedTextStyle,
        cursorColor: LunaColours.accent,
        textInputAction: widget.action,
        obscureText: widget.obscureText,
        autocorrect: false,
        keyboardType: widget.keyboardType,
        validator: widget?.validator,
        onChanged: widget.onChanged == null ? null : widget.onChanged,
        onFieldSubmitted: widget?.onSubmitted,
    );

    TextField get _isNotForm => TextField(
        autofillHints: widget.autofillHints,
        autofocus: widget.autofocus,
        controller: widget.controller,
        decoration: _sharedInputDecoration,
        style: _sharedTextStyle,
        cursorColor: LunaColours.accent,
        textInputAction: widget.action,
        obscureText: widget.obscureText,
        autocorrect: false,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged == null ? null : widget.onChanged,
        onSubmitted: widget?.onSubmitted,
    );
}
