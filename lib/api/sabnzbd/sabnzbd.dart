import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:lunasea/api/sabnzbd/types/post_processing.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lunasea/api/sabnzbd/models.dart';
import 'package:lunasea/api/sabnzbd/types.dart';

part 'sabnzbd.g.dart';

@RestApi()
abstract class SABnzbdAPI {
  factory SABnzbdAPI({
    required String host,
    required String apiKey,
    Map<String, dynamic> headers = const {},
  }) {
    String baseUrl = host.endsWith('/') ? '${host}api/' : '$host/api/';
    Dio dio = Dio(BaseOptions(
      headers: headers,
      followRedirects: true,
      maxRedirects: 5,
      queryParameters: {
        if (apiKey.isNotEmpty) 'apikey': apiKey,
        'output': 'json',
      },
    ));
    return _SABnzbdAPI(dio, baseUrl: baseUrl);
  }

  @GET('')
  Future<SABnzbdActionResult> clearHistory(
    @Query('value') SABnzbdClearHistory clear, {
    @Query('del_files') SABnzbdAction? deleteFiles,
    @Query('mode') String mode = 'history',
    @Query('name') String action = 'delete',
  });

  @GET('')
  Future<SABnzbdActionResult> deleteHistory(
    @Query('value') String nzoId, {
    @Query('del_files') SABnzbdAction? deleteFiles,
    @Query('mode') String mode = 'history',
    @Query('name') String action = 'delete',
  });

  @GET('')
  Future<SABnzbdActionResult> deleteJob(
    @Query('value') String nzoId, {
    @Query('del_files') SABnzbdAction? deleteFiles,
    @Query('mode') String mode = 'queue',
    @Query('name') String action = 'delete',
  });

  @GET('')
  Future<SABnzbdCategories> getCategories({
    @Query('mode') String mode = 'get_cats',
  });

  @GET('')
  Future<SABnzbdHistory> getHistory({
    @Query('start') int? start,
    @Query('limit') int? limit,
    @Query('cat') String? category,
    @Query('search') String? search,
    @Query('nzo_ids') List<String>? nzoIds,
    @Query('failed_only') SABnzbdAction? failedOnly,
    @Query('mode') String mode = 'history',
  });

  @GET('')
  Future<SABnzbdQueue> getQueue({
    @Query('start') int? start,
    @Query('limit') int? limit,
    @Query('search') String? search,
    @Query('nzo_ids') List<String>? nzoIds,
    @Query('mode') String mode = 'queue',
  });

  @GET('')
  Future<SABnzbdServerStats> getServerStats({
    @Query('mode') String mode = 'server_stats',
  });

  @GET('')
  Future<SABnzbdStatus> getStatus({
    @Query('mode') String mode = 'status',
  });

  @GET('')
  Future<SABnzbdVersion> getVersion({
    @Query('mode') String mode = 'version',
  });

  @GET('')
  Future<void> moveQueue(
    @Query('value') String nzoId,
    @Query('value2') int index, {
    @Query('mode') String mode = 'switch',
  });

  @GET('')
  Future<SABnzbdActionResult> pauseJob(
    @Query('value') String nzoId, {
    @Query('mode') String mode = 'queue',
    @Query('name') String action = 'pause',
  });

  @GET('')
  Future<SABnzbdActionResult> pauseQueue({
    @Query('mode') String mode = 'pause',
  });

  @GET('')
  Future<SABnzbdActionResult> pauseQueueFor(
    @Query('value') int minutes, {
    @Query('mode') String mode = 'config',
    @Query('name') String action = 'set_pause',
  });

  @GET('')
  Future<SABnzbdActionResult> renameJob(
    @Query('value') String nzoId,
    @Query('value2') String name, {
    @Query('value3') String? password,
    @Query('mode') String mode = 'queue',
    @Query('name') String action = 'rename',
  });

  @GET('')
  Future<SABnzbdActionResult> resumeJob(
    @Query('value') String nzoId, {
    @Query('mode') String mode = 'queue',
    @Query('name') String action = 'resume',
  });

  @GET('')
  Future<SABnzbdActionResult> resumeQueue({
    @Query('mode') String mode = 'resume',
  });

  @GET('')
  Future<SABnzbdActionResult> retryFailedJob(
    @Query('value') String nzoId, {
    @Query('password') String? password,
    @Query('mode') String mode = 'retry',
  });

  @GET('')
  Future<SABnzbdActionResult> setCategory(
    @Query('value') String nzoId,
    @Query('value2') String category, {
    @Query('mode') String mode = 'change_cat',
  });

  @GET('')
  Future<void> setJobPriority(
    @Query('value') String nzoId,
    @Query('value2') SABnzbdPriority priority, {
    @Query('mode') String mode = 'queue',
    @Query('name') String name = 'priority',
  });

  @GET('')
  Future<void> setOnCompleteAction(
    @Query('value') SABnzbdOnCompleteAction action, {
    @Query('mode') String mode = 'queue',
    @Query('name') String name = 'change_complete_action',
  });

  @GET('')
  Future<SABnzbdActionResult> setSpeedLimit(
    @Query('value') int limit, {
    @Query('mode') String mode = 'config',
    @Query('name') String name = 'speedlimit',
  });

  @GET('')
  Future<SABnzbdActionResult> sortQueue(
    @Query('sort') SABnzbdSortCategory category,
    @Query('dir') SABnzbdSortDirection direction, {
    @Query('mode') String mode = 'queue',
    @Query('name') String action = 'sort',
  });

  @GET('')
  Future<SABnzbdActionResult> uploadByFile(
    @Part(name: 'name') List<int> data,
    @Query('nzbname') String? nzbName, {
    @Query('password') String? password,
    @Query('cat') String? category,
    @Query('script') String? script,
    @Query('priority') SABnzbdPriority? priority,
    @Query('pp') SABnzbdPostProcessing? postProcessing,
    @Query('mode') String mode = 'addurl',
  });

  @GET('')
  Future<SABnzbdActionResult> uploadByURL(
    @Query('url') String url, {
    @Query('nzbname') String? nzbName,
    @Query('password') String? password,
    @Query('cat') String? category,
    @Query('script') String? script,
    @Query('priority') SABnzbdPriority? priority,
    @Query('pp') SABnzbdPostProcessing? postProcessing,
    @Query('mode') String mode = 'addurl',
  });
}
