import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTextInputBar extends StatefulWidget {
    final TextEditingController controller;
    final TextInputAction action;
    final TextInputType keyboardType;
    final Iterable<String> autofillHints;
    final String labelText;
    final IconData labelIcon;
    final bool autofocus;
    final bool obscureText;
    final bool isFormField;
    final void Function(String, bool) onChanged;
    final void Function(String) onSubmitted;
    final String Function(String) validator;
    final EdgeInsets margin;

    LSTextInputBar({
        @required this.controller,
        this.onChanged,
        this.onSubmitted,
        this.validator,
        this.autofillHints,
        this.action = TextInputAction.search,
        this.keyboardType = TextInputType.text,
        this.labelText = 'Search...',
        this.labelIcon = Icons.search,
        this.margin = Constants.UI_CARD_MARGIN,
        this.autofocus = false,
        this.obscureText = false,
        this.isFormField = false,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSTextInputBar> {
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
        labelText: widget.labelText,
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
                onTap: () => widget?.onChanged('', true),
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
        onChanged: widget.onChanged == null ? null : (value) => widget.onChanged(value, false),
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
        onChanged: widget.onChanged == null ? null : (value) => widget.onChanged(value, false),
        onSubmitted: widget?.onSubmitted,
    );
}