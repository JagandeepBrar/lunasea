import 'package:hive/hive.dart';

part 'indexer.g.dart';

@HiveType(typeId: 1, adapterName: 'IndexerAdapter')
class Indexer {
    @HiveField(0)
    int id;

    @HiveField(1)
    String name;
}