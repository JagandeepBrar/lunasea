import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'rootfolder.g.dart';

@HiveType(typeId: 3, adapterName: 'SonarrRootFolderAdapter')
class SonarrRootFolder extends HiveObject {
    @HiveField(0)
    int id;
    @HiveField(1)
    String path;
    @HiveField(2)
    int freeSpace;

    factory SonarrRootFolder.empty() => SonarrRootFolder(
        id: -1,
        path: '',
        freeSpace: 0,
    );

    SonarrRootFolder({
        @required this.id,
        @required this.path,
        @required this.freeSpace,
    });
}
