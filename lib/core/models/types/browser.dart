import 'package:lunasea/core.dart';

part 'browser.g.dart';

@HiveType(typeId: 11, adapterName: 'DeprecatedLunaBrowserAdapter')
enum DeprecatedLunaBrowser {
  @HiveField(0)
  APPLE_SAFARI,
  @HiveField(1)
  BRAVE_BROWSER,
  @HiveField(2)
  GOOGLE_CHROME,
  @HiveField(3)
  MICROSOFT_EDGE,
  @HiveField(4)
  MOZILLA_FIREFOX,
}
