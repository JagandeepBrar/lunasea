import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaHeader extends StatelessWidget {
  final String text;
  final String subtitle;

  const LunaHeader({
    Key key,
    @required this.text,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              fontSize: LunaUI.FONT_SIZE_HEADER,
              color: Colors.white,
            ),
          ),
          Padding(
            child: Container(
              height: 2.0,
              width: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                color: LunaColours.accent,
              ),
            ),
            padding: EdgeInsets.only(
              top: 4.0,
              left: 1.0,
              bottom: subtitle != null ? 6.0 : 0.0,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: LunaUI.FONT_SIZE_SUBHEADER,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
    );
  }
}
