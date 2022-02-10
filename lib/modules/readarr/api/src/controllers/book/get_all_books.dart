part of readarr_commands;

Future<List<ReadarrBook>> _commandGetAllBooks(Dio client) async {
  Response response = await client.get('book');
  return (response.data as List)
      .map((book) => ReadarrBook.fromJson(book))
      .toList();
}
