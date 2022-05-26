import 'package:envify/envify.dart';

part 'environment.g.dart';

@Envify(path: '.env')
class LunaEnvironment {
  static const flavor = 'stable';
  static const commit = _LunaEnvironment.commit;
  static const build = _LunaEnvironment.build;
}
