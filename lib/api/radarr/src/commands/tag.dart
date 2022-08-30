part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to tags within Radarr.
///
/// [RadarrCommandHandlerTag] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerTag {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerTag(this._client);

  /// Handler for [tag](https://radarr.video/docs/api/#/Tag/post_tag).
  ///
  /// Adds a new tag.
  ///
  /// Required Parameters:
  /// - `label`: Tag label
  Future<RadarrTag> create({
    required String label,
  }) async =>
      _commandAddTag(_client, label: label);

  /// Handler for [tag/{id}](https://radarr.video/docs/api/#/Tag/delete_tag__id_).
  ///
  /// Delete the tag with the given ID.
  ///
  /// Required Parameters:
  /// - `id`: Tag identifier
  Future<void> delete({
    required int id,
  }) async =>
      _commandDeleteTag(_client, id: id);

  /// Handler for [tag/{id}](https://radarr.video/docs/api/#/Tag/get_tag__id_).
  ///
  /// Returns the tag with the matching ID.
  ///
  /// Required Parameters:
  /// - `id`: Tag identifier
  Future<void> get({
    required int id,
  }) async =>
      _commandGetTag(_client, id: id);

  /// Handler for [tag](https://radarr.video/docs/api/#/Tag/get_tag).
  ///
  /// Returns a list of all tags.
  Future<List<RadarrTag>> getAll() async => _commandGetAllTags(_client);

  /// Handler for [tag](https://radarr.video/docs/api/#/Tag/put-tag-id).
  ///
  /// Update an existing tag.
  ///
  /// Required Parameters:
  /// - `tag`: A modified [RadarrTag] object
  Future<RadarrTag> update({
    required RadarrTag tag,
  }) async =>
      _commandUpdateTag(_client, tag: tag);
}
