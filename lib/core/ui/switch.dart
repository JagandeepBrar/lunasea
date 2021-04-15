import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaSwitch extends Switch {
    LunaSwitch({
        Key key,
        @required bool value,
        @required void Function(bool) onChanged,
    }) : super(
        key: key,
        value: value,
        onChanged: onChanged == null ? null : (value) {
            unawaited(HapticFeedback.lightImpact());
            onChanged(value);
        },
    );
}
