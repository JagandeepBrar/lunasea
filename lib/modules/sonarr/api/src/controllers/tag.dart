part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to tags within Sonarr.
///
/// [SonarrControllerTag] internally handles routing the HTTP client to the API calls.
class SonarrControllerTag {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerTag(this._client);

  /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#post).
  ///
  /// Adds a new tag.
  Future<SonarrTag> create({
    required String label,
  }) async =>
      _commandAddTag(_client, label: label);

  /// Handler for [tag/{id}](https://github.com/Sonarr/Sonarr/wiki/Tag#deleteid).
  ///
  /// Delete the tag with the given ID.
  Future<void> delete({
    required int id,
  }) async =>
      _commandDeleteTag(_client, id: id);

  /// Handler for [tag/{id}](https://github.com/Sonarr/Sonarr/wiki/Tag#getid).
  ///
  /// Returns the tag with the matching ID.
  Future<SonarrTag> get({
    required int id,
  }) async =>
      _commandGetTag(_client, id: id);

  /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#get).
  ///
  /// Returns a list of all tags.
  Future<List<SonarrTag>> getAll() async => _commandGetAllTags(_client);

  /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#put).
  ///
  /// Update an existing tag.
  Future<SonarrTag> update({
    required SonarrTag tag,
  }) async =>
      _commandUpdateTag(_client, tag: tag);
}
