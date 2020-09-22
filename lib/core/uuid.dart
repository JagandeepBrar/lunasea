import 'package:uuid/uuid.dart';

class LunaUUID {
    static final _generator = Uuid();
    static String get uuid => _generator.v4();
}
