import 'package:envify/envify.dart';

import '../../core/extensions.dart';
import '../../vendor.dart';
import 'flavor.dart';

part 'environment.g.dart';

@Envify(path: '.env')
class LunaEnvironment {
  static const flavor = _LunaEnvironment.flavor;
  static const commit = _LunaEnvironment.commit;

  String getShortCommit() {
    return commit.substring(0, min(7, commit.length));
  }

  Future<void> openCommitHistory() async {
    String _base = 'https://github.com/JagandeepBrar/LunaSea/commits';
    return '$_base/$commit'.lunaOpenGenericLink();
  }

  /// Returns if the given flavor is "lower" than the given environment.
  /// For example, `alpha` is lower than `beta` but is not lower than `develop`.
  bool isFlavorSupported(LunaFlavor env) {
    LunaFlavor _flavor = LunaFlavor.EDGE.from(flavor);
    if (_flavor == env) return true;
    switch (env) {
      case LunaFlavor.EDGE:
        return false;
      case LunaFlavor.BETA:
        return _flavor == LunaFlavor.EDGE;
      case LunaFlavor.CANDIDATE:
        return _flavor == LunaFlavor.EDGE || _flavor == LunaFlavor.BETA;
      case LunaFlavor.STABLE:
        return true;
    }
  }
}
