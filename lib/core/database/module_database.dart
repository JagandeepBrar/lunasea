abstract class LunaModuleDatabase {
  /// Register all adapters necessary for this module
  void registerAdapters();

  /// Export the current module's database into a [Map] object
  Map<String, dynamic> export();

  /// Receiving a map object, import a configuration
  void import(Map<String, dynamic> config);

  /// Return the Database enumerator value given the key
  dynamic valueFromKey(String value);
}
