export './providers/search.dart';
export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:lunasea/core/providers.dart';
import 'package:provider/provider.dart';

MultiProvider providers({ @required Widget child }) => MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => SearchModel()),
    ],
    child: child,
);