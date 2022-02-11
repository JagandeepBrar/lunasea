part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to tags within Readarr.
///
/// [ReadarrControllerTag] internally handles routing the HTTP client to the API calls.
class ReadarrControllerTag {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerTag(this._client);

  /// Handler for [tag](https://github.com/Readarr/Readarr/wiki/Tag#post).
  ///
  /// Adds a new tag.
  Future<ReadarrTag> create({
    required String label,
  }) async =>
      _commandAddTag(_client, label: label);

  /// Handler for [tag/{id}](https://github.com/Readarr/Readarr/wiki/Tag#deleteid).
  ///
  /// Delete the tag with the given ID.
  Future<void> delete({
    required int id,
  }) async =>
      _commandDeleteTag(_client, id: id);

  /// Handler for [tag/{id}](https://github.com/Readarr/Readarr/wiki/Tag#getid).
  ///
  /// Returns the tag with the matching ID.
  Future<ReadarrTag> get({
    required int id,
  }) async =>
      _commandGetTag(_client, id: id);

  /// Handler for [tag](https://github.com/Readarr/Readarr/wiki/Tag#get).
  ///
  /// Returns a list of all tags.
  Future<List<ReadarrTag>> getAll() async => _commandGetAllTags(_client);

  /// Handler for [tag](https://github.com/Readarr/Readarr/wiki/Tag#put).
  ///
  /// Update an existing tag.
  Future<ReadarrTag> update({
    required ReadarrTag tag,
  }) async =>
      _commandUpdateTag(_client, tag: tag);
}
