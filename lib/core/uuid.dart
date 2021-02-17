import 'package:uuid/uuid.dart';

class LunaUUID {
    final Uuid _generator = Uuid();
    
    /// Generate a new v4 UUID with the base configuration.
    String get uuid => _generator.v4();

    /// Return the [Uuid] instance.
    Uuid get generator => _generator;
}
