import 'dart:io';

void main(List<String> args) {
  _setVersion(args[0]);
  _copyBuild();
  _determineMD5Sums();
  _buildDebian();
}

void _setVersion(String version) {
  final control = File('debian/DEBIAN/control');
  control.writeAsStringSync('Version:$version\n', mode: FileMode.append);
}

void _copyBuild() {
  const path = 'debian/usr/share';

  final directory = Directory('$path/lunasea');
  if (directory.existsSync()) directory.deleteSync(recursive: true);

  Process.runSync('cp', [
    '-r',
    'build/linux/x64/release/bundle',
    path,
  ]);
  Process.runSync('mv', [
    '$path/bundle',
    '$path/lunasea',
  ]);
}

void _determineMD5Sums() {
  final find = Process.runSync(
    'find',
    [".", "-type", "f", "-not", "-path", "'./DEBIAN/*'"],
    workingDirectory: 'debian',
  ).stdout as String;

  final files = find
      .split('\n')
      .where((file) => !file.startsWith('./DEBIAN'))
      .map((file) => file.replaceAll('./', ''))
      .toList();

  final md5 = Process.runSync(
    'md5sum',
    files,
    workingDirectory: 'debian',
  ).stdout as String;

  File('debian/DEBIAN/md5sums').writeAsStringSync(md5);
}

void _buildDebian() {
  if (!Directory('output').existsSync()) {
    Directory('output').createSync(recursive: true);
  }

  Process.runSync('dpkg-deb', [
    '--build',
    'debian',
  ]);
  Process.runSync('mv', [
    'debian.deb',
    'output/lunasea-linux-amd64.deb',
  ]);
}
