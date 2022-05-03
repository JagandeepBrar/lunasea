import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTableCard extends StatelessWidget {
  final String? title;
  final List<LunaTableContent>? content;
  final List<LunaButton>? buttons;

  const LunaTableCard({
    Key? key,
    this.content,
    this.buttons,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Padding(
        child: _body(),
        padding: EdgeInsets.only(
          left: LunaUI.DEFAULT_MARGIN_SIZE / 2,
          right: LunaUI.DEFAULT_MARGIN_SIZE / 2,
          top: LunaUI.DEFAULT_MARGIN_SIZE - LunaUI.DEFAULT_MARGIN_SIZE / 4,
          bottom: buttons?.isEmpty ?? true
              ? LunaUI.DEFAULT_MARGIN_SIZE - LunaUI.DEFAULT_MARGIN_SIZE / 4
              : 0,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        if (title?.isNotEmpty ?? false) _title(),
        ..._content(),
        _buttons(),
      ],
    );
  }

  Widget _title() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LunaUI.DEFAULT_MARGIN_SIZE),
          child: LunaText.title(text: title!),
        ),
      ],
    );
  }

  List<Widget> _content() {
    return content!
        .map((child) => Padding(
              child: child,
              padding: const EdgeInsets.symmetric(
                horizontal: LunaUI.DEFAULT_MARGIN_SIZE / 2,
              ),
            ))
        .toList();
  }

  Widget _buttons() {
    if (buttons == null) return Container(height: 0.0);
    return Padding(
      child: Row(
        children:
            buttons!.map<Widget>((button) => Expanded(child: button)).toList(),
      ),
      padding: const EdgeInsets.only(
        top: LunaUI.DEFAULT_MARGIN_SIZE / 2 - LunaUI.DEFAULT_MARGIN_SIZE / 4,
        bottom: LunaUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }
}
