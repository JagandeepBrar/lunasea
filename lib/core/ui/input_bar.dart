import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTextInputBar extends StatefulWidget {
  static const double appBarHeight = 62.0;
  static const double appBarInnerHeight = 62.0 - 13.0;
  static const EdgeInsets appBarMargin = EdgeInsets.fromLTRB(
    12.0,
    1.0,
    12.0,
    12.0,
  );

  final TextEditingController controller;
  final ScrollController scrollController;
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
    Key key,
    @required this.controller,
    this.scrollController,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autofillHints,
    this.action = TextInputAction.search,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.labelIcon = Icons.search_rounded,
    this.margin = LunaUI.MARGIN_CARD,
    this.autofocus = false,
    this.obscureText = false,
    this.isFormField = false,
  }) : super(key: key) {
    assert(controller != null);
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaTextInputBar> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_controllerListener);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerListener);
    super.dispose();
  }

  void _controllerListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        margin: widget.margin,
        child: FocusScope(
          child: Focus(
            onFocusChange: (value) => setState(() => _isFocused = value),
            child: widget.isFormField ? _isForm : _isNotForm,
          ),
        ),
        height: LunaTextInputBar.appBarInnerHeight,
        color: Theme.of(context).canvasColor,
      );

  TextStyle get _sharedTextStyle => const TextStyle(
        color: Colors.white,
        fontSize: LunaUI.FONT_SIZE_H3,
      );

  InputDecoration get _sharedInputDecoration => InputDecoration(
        labelText: widget.labelText ?? 'lunasea.SearchTextBar'.tr(),
        labelStyle: const TextStyle(
          color: Colors.white54,
          decoration: TextDecoration.none,
          fontSize: LunaUI.FONT_SIZE_H3,
        ),
        suffixIcon: AnimatedOpacity(
          child: InkWell(
            child: const Icon(
              Icons.close_rounded,
              color: LunaColours.accent,
              size: 24.0,
            ),
            onTap: !_isFocused || widget.controller.text == ''
                ? null
                : () {
                    widget.scrollController?.lunaAnimateToStart();
                    widget.controller.text = '';
                    if (widget.onChanged != null) widget.onChanged('');
                  },
            mouseCursor: !_isFocused || widget.controller.text == ''
                ? SystemMouseCursors.text
                : SystemMouseCursors.click,
            borderRadius: BorderRadius.circular(24.0),
            hoverColor: Colors.transparent,
          ),
          opacity: !_isFocused || widget.controller.text == '' ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
        ),
        icon: Padding(
          child: Icon(
            widget.labelIcon,
            color: LunaColours.accent,
          ),
          padding: const EdgeInsets.only(left: 16.0),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
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
        onTap: widget.scrollController?.lunaAnimateToStart,
        onChanged: widget.onChanged,
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
        onTap: widget.scrollController?.lunaAnimateToStart,
        onChanged: widget.onChanged,
        onSubmitted: widget?.onSubmitted,
      );
}
