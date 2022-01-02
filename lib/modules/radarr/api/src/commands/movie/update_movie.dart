part of radarr_commands;

Future<RadarrMovie> _commandUpdateMovie(Dio client, {
    required RadarrMovie movie,
}) async {
    Response response = await client.put('movie', data: movie.toJson());
    return RadarrMovie.fromJson(response.data);
}
