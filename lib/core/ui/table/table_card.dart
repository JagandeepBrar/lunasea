import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTableCard extends StatelessWidget {
  final String title;
  final List<LunaTableContent> content;
  final List<LunaButton> buttons;

  const LunaTableCard({
    Key key,
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
        padding: buttons == null
            ? const EdgeInsets.symmetric(vertical: 8.0)
            : const EdgeInsets.only(top: 8.0, bottom: 6.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: LunaText.title(text: title),
        ),
      ],
    );
  }

  List<Widget> _content() {
    return content
            ?.map<Widget>((content) => Padding(
                  child: content,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                ))
            ?.toList() ??
        [];
  }

  Widget _buttons() {
    if (buttons == null) return Container(height: 0.0);
    return Padding(
      child: Row(
        children:
            buttons.map<Widget>((button) => Expanded(child: button)).toList(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
    );
  }
}
