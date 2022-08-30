part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to languages within Radarr.
///
/// [RadarrCommandHandlerLanguage] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerLanguage {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerLanguage(this._client);

  /// Handler for `language/{id}`.
  ///
  /// Returns a single language.
  ///
  /// Required Parameters:
  /// - `languageId`: Language identifier
  Future<RadarrLanguage> get({required int languageId}) async =>
      _commandGetLanguage(_client, languageId: languageId);

  /// Handler for `language`.
  ///
  /// Returns all languages.
  Future<List<RadarrLanguage>> getAll() async =>
      _commandGetAllLanguages(_client);
}
