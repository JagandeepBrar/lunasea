import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Widget LSDrawer({
    @required String page,
}) => LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.data
    ? LSDrawerCategories(page: page)
    : LSDrawerNoCategories(page: page);
