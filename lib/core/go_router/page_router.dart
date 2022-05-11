import 'package:flutter/material.dart';
import 'package:lunasea/vendor.dart';

abstract class LunaPageGoRouter {
  GoRoute get route;
  Future<void> go(BuildContext context);
}
