part of readarr_commands;

Future<void> _commandDeleteBookFile(
  Dio client, {
  required int bookFileId,
}) async {
  await client.delete('bookFile/$bookFileId');
}
