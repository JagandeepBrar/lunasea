import 'package:device_preview/device_preview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/system/cache/image/image_cache.dart';
import 'package:lunasea/system/cache/memory/memory_store.dart';
import 'package:lunasea/system/in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/system/network/network.dart';
import 'package:lunasea/system/sentry.dart';
import 'package:lunasea/system/window_manager/window_manager.dart';
import 'package:lunasea/system/platform.dart';

/// LunaSea Entry Point: Initialize & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      //LunaSea initialization
      await LunaSentry().initialize();
      await LunaDatabase().initialize();
      LunaLogger().initialize();
      if (LunaFirebase.isSupported) await LunaFirebase().initialize();
      LunaTheme().initialize();
      if (LunaWindowManager.isSupported) await LunaWindowManager().initialize();
      if (LunaNetwork.isSupported) LunaNetwork().initialize();
      if (LunaImageCache.isSupported) LunaImageCache().initialize();
      LunaRouter().initialize();
      if (LunaInAppPurchase.isSupported) LunaInAppPurchase().initialize();
      await LunaLocalization().initialize();
      await LunaMemoryStore().initialize();
      // Run application
      return runApp(const LunaBIOS());
    },
    (error, stack) => LunaLogger().critical(error, stack),
  );
}

class LunaBIOS extends StatelessWidget {
  const LunaBIOS({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LunaTheme();
    final router = LunaRouter.router;

    return LunaState.providers(
      child: DevicePreview(
        enabled: kDebugMode && LunaPlatform.isDesktop,
        builder: (context) => EasyLocalization(
          supportedLocales: LunaLocalization().supportedLocales(),
          path: LunaLocalization.fileDirectory,
          fallbackLocale: LunaLocalization.fallbackLocale,
          startLocale: LunaLocalization.fallbackLocale,
          useFallbackTranslations: true,
          child: LunaBox.lunasea.listenableBuilder(
            selectItems: [
              LunaSeaDatabase.THEME_AMOLED,
              LunaSeaDatabase.THEME_AMOLED_BORDER,
            ],
            builder: (context, _) {
              return MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: DevicePreview.appBuilder,
                useInheritedMediaQuery: true,
                darkTheme: theme.activeTheme(),
                theme: theme.activeTheme(),
                title: 'LunaSea',
                routeInformationProvider: router.routeInformationProvider,
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
              );
            },
          ),
        ),
      ),
    );
  }
}
