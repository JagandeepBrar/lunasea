import 'package:flutter/material.dart';

import '../../vendor.dart';

abstract class LunaPageGoRouter {
  GoRoute get route;
  Future<void> go(BuildContext context);
}
