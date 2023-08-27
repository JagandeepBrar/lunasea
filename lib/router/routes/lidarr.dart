import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/lidarr/core/api.dart';
import 'package:lunasea/modules/lidarr/routes/add_details.dart';
import 'package:lunasea/modules/lidarr/routes/add_search.dart';
import 'package:lunasea/modules/lidarr/routes/details_album.dart';
import 'package:lunasea/modules/lidarr/routes/details_artist.dart';
import 'package:lunasea/modules/lidarr/routes/edit_artist.dart';
import 'package:lunasea/modules/lidarr/routes/lidarr.dart';
import 'package:lunasea/modules/lidarr/routes/search_results.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum LidarrRoutes with LunaRoutesMixin {
  HOME('/lidarr'),
  ADD_ARTIST('add_artist'),
  ADD_ARTIST_DETAILS('details'),
  ARTIST('artist/:artist'),
  ARTIST_ALBUM('album/:album'),
  ARTIST_ALBUM_RELEASES('releases'),
  ARTIST_EDIT('edit');

  @override
  final String path;

  const LidarrRoutes(this.path);

  @override
  LunaModule get module => LunaModule.LIDARR;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case LidarrRoutes.HOME:
        return route(widget: const LidarrRoute());
      case LidarrRoutes.ADD_ARTIST:
        return route(widget: const AddArtistRoute());
      case LidarrRoutes.ADD_ARTIST_DETAILS:
        return route(builder: (_, state) {
          return AddArtistDetailsRoute(
            data: state.extra as LidarrSearchData?,
          );
        });
      case LidarrRoutes.ARTIST:
        return route(builder: (_, state) {
          return ArtistDetailsRoute(
            data: state.extra as LidarrCatalogueData?,
            artistId: int.tryParse(state.pathParameters['artist'] ?? '') ?? -1,
          );
        });
      case LidarrRoutes.ARTIST_ALBUM:
        return route(builder: (_, state) {
          return ArtistAlbumDetailsRoute(
            artistId: int.tryParse(state.pathParameters['artist'] ?? '') ?? -1,
            albumId: int.tryParse(state.pathParameters['album'] ?? '') ?? -1,
            monitored:
                state.uri.queryParameters['monitored']?.toLowerCase() == 'true',
          );
        });
      case LidarrRoutes.ARTIST_ALBUM_RELEASES:
        return route(builder: (_, state) {
          return ArtistAlbumReleasesRoute(
            albumId: int.tryParse(state.pathParameters['album'] ?? '') ?? -1,
          );
        });
      case LidarrRoutes.ARTIST_EDIT:
        return route(builder: (_, state) {
          return ArtistEditRoute(
            data: state.extra as LidarrCatalogueData?,
            artistId: int.tryParse(state.pathParameters['artist'] ?? '') ?? -1,
          );
        });
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case LidarrRoutes.HOME:
        return [
          LidarrRoutes.ADD_ARTIST.routes,
          LidarrRoutes.ARTIST.routes,
        ];
      case LidarrRoutes.ADD_ARTIST:
        return [
          LidarrRoutes.ADD_ARTIST_DETAILS.routes,
        ];
      case LidarrRoutes.ARTIST:
        return [
          LidarrRoutes.ARTIST_ALBUM.routes,
          LidarrRoutes.ARTIST_EDIT.routes,
        ];
      case LidarrRoutes.ARTIST_ALBUM:
        return [
          LidarrRoutes.ARTIST_ALBUM_RELEASES.routes,
        ];
      default:
        return const [];
    }
  }
}
