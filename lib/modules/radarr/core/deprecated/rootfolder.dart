import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'rootfolder.g.dart';

@HiveType(typeId: 5, adapterName: 'RadarrRootFolderAdapter')
class RadarrRootFolder extends HiveObject {
    @HiveField(0)
    int id;
    @HiveField(1)
    String path;
    @HiveField(2)
    int freeSpace;

    factory RadarrRootFolder.empty() => RadarrRootFolder(
        id: -1,
        path: '',
        freeSpace: 0,
    );

    RadarrRootFolder({
        @required this.id,
        @required this.path,
        @required this.freeSpace,
    });
}
