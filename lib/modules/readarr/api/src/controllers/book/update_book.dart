part of readarr_commands;

Future<ReadarrBook> _commandUpdateBook(
  Dio client, {
  required ReadarrBook book,
}) async {
  Response response = await client.put('book', data: book.toJson());
  return ReadarrBook.fromJson(response.data);
}
