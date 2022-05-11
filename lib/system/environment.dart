import 'package:envify/envify.dart';
import 'package:lunasea/extensions/string_links.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/system/flavor.dart';

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
    return '$_base/$commit'.openLink();
  }

  /// Returns if the given flavor is "lower" than the given environment.
  /// For example, `beta` is lower than `candidate` but is not lower than `edge`.
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
