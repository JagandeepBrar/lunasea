import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify(path: '.env.public')
abstract class LunaPublicEnv {
  static const flavor = _LunaPublicEnv.flavor;
}
