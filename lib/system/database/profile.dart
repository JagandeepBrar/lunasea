import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 0, adapterName: 'ProfileAdapter')
class Profile {
    @HiveField(0)
    int id;

    @HiveField(1)
    String name;
}