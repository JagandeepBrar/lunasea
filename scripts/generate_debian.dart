import 'dart:io';

void main(List<String> args) {
  _createSkeleton();

  _generateControl(args[0]);
  _generateDesktopEntry();
  _copyIcon();
  _copyBuild();

  _buildDebian();
}

Future<void> _createSkeleton() async {
  if (Directory('debian').existsSync()) {
    Directory('debian').deleteSync(recursive: true);
  }

  Directory('debian/DEBIAN').createSync(recursive: true);
  Directory('debian/usr/local/lib').createSync(recursive: true);
  Directory('debian/usr/share/applications').createSync(recursive: true);
  Directory('debian/usr/share/icons').createSync(recursive: true);
}

void _generateControl(String version) {
  final control = File('debian/DEBIAN/control');

  String data = '';
  data += 'Version:$version\n';
  data += 'Architecture:amd64\n';
  data += 'Package:LunaSea\n';
  data += 'Essential:no\n';
  data += 'Priority:optional\n';
  data += 'Maintainer:LunaSea Support <hello@lunasea.app>\n';
  data += 'Description:Self-hosted software controller built using Flutter\n';

  control.writeAsStringSync(data);
}

void _generateDesktopEntry() {
  final entry = File('debian/usr/share/applications/lunasea.desktop');

  String data = '';
  data += '[Desktop Entry]\n';
  data += 'Name=LunaSea\n';
  data += 'Comment=Self-hosted software controller built using Flutter\n';
  data += 'Icon=/usr/share/icons/lunasea.png\n';
  data += 'Terminal=false\n';
  data += 'Type=Application\n';
  data += 'Categories=Utilities;Entertainment;\n';
  data += 'Exec=/usr/local/lib/LunaSea/lunasea\n';
  data += 'TryExec=/usr/local/lib/LunaSea/lunasea\n';

  entry.writeAsStringSync(data);
}

void _copyIcon() {
  final icon = File('assets/icon/icon_linux.png');
  icon.copySync('debian/usr/share/icons/lunasea.png');
}

void _copyBuild() {
  Process.runSync(
    'cp',
    ['-r', 'build/linux/x64/release/bundle', 'debian/usr/local/lib'],
  );
  Process.runSync(
    'mv',
    ['debian/usr/local/lib/bundle', 'debian/usr/local/lib/LunaSea'],
  );
}

void _buildDebian() {
  if (!Directory('output').existsSync()) {
    Directory('output').createSync(recursive: true);
  }

  Process.runSync(
    'dpkg-deb',
    ['--build', 'debian'],
  );
  Process.runSync('mv', [
    'debian.deb',
    'output/lunasea-linux-amd64.deb',
  ]);
}
