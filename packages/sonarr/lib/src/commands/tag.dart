part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to tags within Sonarr.
/// 
/// [SonarrCommandHandler_Tag] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Tag {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_Tag(this._client);

    /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#post).
    /// 
    /// Adds a new tag.
    /// 
    /// Required Parameters:
    /// - `label`: Tag label
    Future<SonarrTag> addTag({
        required String label,
    }) async => _commandAddTag(_client, label: label);

    /// Handler for [tag/{id}](https://github.com/Sonarr/Sonarr/wiki/Tag#deleteid).
    /// 
    /// Delete the tag with the given ID.
    /// 
    /// Required Parameters:
    /// - `id`: Tag identifier
    Future<void> deleteTag({
        required int id,
    }) async => _commandDeleteTag(_client, id: id);

    /// Handler for [tag/{id}](https://github.com/Sonarr/Sonarr/wiki/Tag#getid).
    /// 
    /// Returns the tag with the matching ID.
    /// 
    /// Required Parameters:
    /// - `id`: Tag identifier
    Future<void> getTag({
        required int id,
    }) async => _commandGetTag(_client, id: id);

    /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#get).
    /// 
    /// Returns a list of all tags.
    Future<List<SonarrTag>> getAllTags() async => _commandGetAllTags(_client);

    /// Handler for [tag](https://github.com/Sonarr/Sonarr/wiki/Tag#put).
    /// 
    /// Update an existing tag.
    /// 
    /// Required Parameters:
    /// - `tag`: A modified [SonarrTag] object
    Future<SonarrTag> updateTag({
        required SonarrTag tag,
    }) async => _commandUpdateTag(_client, tag: tag);
}
