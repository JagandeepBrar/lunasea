import 'package:lunasea/system/logger.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringAsLinksExtension on String {
  Future<bool> _launchUniversal(Uri uri, Map<String, String>? headers) async {
    print(await canLaunchUrl(uri));
    return await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
  }

  Future<void> openLink({
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(this);
      if (await _launchUniversal(uri, headers)) return;
    } catch (error, stack) {
      LunaLogger().error(
        'Unable to open URL',
        error,
        stack,
      );
    }
  }

  Future<void> openYouTube() async {
    await 'https://www.youtube.com/watch?v=$this'.openLink();
  }
}
