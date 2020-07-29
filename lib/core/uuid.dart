import 'package:uuid/uuid.dart';

class UUID {
    static final _generator = Uuid();
    static String get uuid => _generator.v4();
}
