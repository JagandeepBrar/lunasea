import 'package:lunasea/vendor.dart';
import 'package:uuid/uuid.dart';

class LunaUUID {
  const LunaUUID._();
  final Uuid _generator = const Uuid();

  String generate() {
    return _generator.v4();
  }
}

final uuidProvider = Provider((_) => const LunaUUID._());
