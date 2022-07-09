// ignore_for_file: avoid_relative_lib_imports

import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

Future<void> main(List<String> args) async {
  final results = <String, dynamic>{};
  loadCommitTypes(results);

  final changes = await getChanges(args[0]);
  for (final change in changes) {
    final commit = change.substring(0, 40);
    final message = change.substring(41);

    final type = parseCommitType(message);
    final parsed = parseCommitMessage(message, type);

    if (type.isNotEmpty && results[type] != null) {
      results[type]!.add({
        "commit": commit,
        "message": parsed,
      });
    }
  }

  export(args[0], results);
}

void export(String flavor, Map<String, dynamic> results) {
  const encoder = JsonEncoder.withIndent('  ');
  final asset = flavor == 'stable'
      ? 'assets/changelog_stable.json'
      : 'assets/changelog.json';
  final file = File(asset);
  file.writeAsStringSync(encoder.convert(results));
}

void loadCommitTypes(Map<String, dynamic> results) {
  final file = File('.czrc');
  final config = json.decode(file.readAsStringSync());

  results['motd'] = '';
  for (final key in (config['types'] as Map).keys) {
    results[key] = [];
  }
}

String parseCommitType(String commit) {
  final type = commit.split(':')[0];
  return type.split('(')[0];
}

String parseCommitMessage(String commit, String type) {
  final index = type.length;
  final endIndex = commit.indexOf(':');

  if (commit[index] == '(') {
    final feature = commit.substring(index + 1, endIndex - 1);
    final message = commit.substring(endIndex + 2);
    return '$feature: $message';
  }
  return commit.substring(endIndex + 2);
}

Future<List<String>> getChanges(String flavor) async {
  // Get current commit count
  final git = await Process.run('git', [
    'rev-list',
    'HEAD',
    '--count',
  ]);
  final currentVersion = int.parse(git.stdout) + 1000000000;

  // Get latest released version of this flavor
  const base = 'https://downloads.lunasea.app/latest/';
  final endpoint = '$base/$flavor/VERSION.txt';
  final result = await Dio().get(endpoint);
  final lastVersion = int.parse(result.data as String);

  // Retrieve the last [lastCommits - currentCommits] commits
  final messages = await Process.run('git', [
    'log',
    '--pretty=oneline',
    '-n ${(currentVersion - lastVersion).toString()}',
  ]);

  return (messages.stdout as String).trim().split('\n');
}
