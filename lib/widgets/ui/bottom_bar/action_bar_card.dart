import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaActionBarCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color color;
  final IconData icon;
  final Function? onTap;
  final Function? onLongPress;
  final bool? checkboxState;
  final void Function(bool?)? checkboxOnChanged;

  const LunaActionBarCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.color = LunaColours.accent,
    this.icon = LunaIcons.ARROW_RIGHT,
    this.checkboxState,
    this.checkboxOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: InkWell(
        child: SizedBox(
          child: Padding(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LunaText(
                        text: title,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: LunaUI.FONT_SIZE_BUTTON,
                          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                          color: color,
                        ),
                      ),
                      if (subtitle != null)
                        LunaText(
                          text: subtitle!,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: LunaUI.FONT_SIZE_SUBHEADER,
                            color: LunaColours.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                if (checkboxState != null)
                  Container(
                    width: 30.0,
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 20.0,
                      child: Checkbox(
                        value: checkboxState,
                        onChanged: checkboxOnChanged,
                      ),
                    ),
                  ),
                if (checkboxState == null)
                  Container(
                    width: 30.0,
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 20.0,
                      child: Icon(
                        icon,
                        size: 20.0,
                      ),
                    ),
                  ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          height: LunaButton.DEFAULT_HEIGHT,
        ),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        onTap: _onTapHandler() as void Function()?,
        onLongPress: _onLongPressHandler() as void Function()?,
      ),
      margin: LunaUI.MARGIN_HALF,
      color: backgroundColor != null
          ? backgroundColor!.withOpacity(LunaUI.OPACITY_DIMMED)
          : LunaTheme.isAMOLEDTheme
              ? Colors.black.withOpacity(LunaUI.OPACITY_DIMMED)
              : LunaColours.primary.withOpacity(LunaUI.OPACITY_DIMMED),
    );
  }

  Function? _onTapHandler() {
    if (onTap != null) {
      return () async {
        HapticFeedback.lightImpact();
        onTap!();
      };
    }
    if (checkboxState != null && checkboxOnChanged != null) {
      return () async => checkboxOnChanged!(!checkboxState!);
    }
    return null;
  }

  Function? _onLongPressHandler() {
    if (onLongPress != null) {
      return () async {
        HapticFeedback.heavyImpact();
        onLongPress!();
      };
    }
    return null;
  }
}
