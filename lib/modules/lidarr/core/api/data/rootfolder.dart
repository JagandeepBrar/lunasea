import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'rootfolder.g.dart';

@HiveType(typeId: 8, adapterName: 'LidarrRootFolderAdapter')
class LidarrRootFolder {
    @HiveField(0)
    int id;
    @HiveField(1)
    String path;
    @HiveField(2)
    int freeSpace;

    factory LidarrRootFolder.empty() => LidarrRootFolder(
        id: -1,
        path: '',
        freeSpace: 0,
    );

    LidarrRootFolder({
        @required this.id,
        @required this.path,
        @required this.freeSpace,
    });
}
