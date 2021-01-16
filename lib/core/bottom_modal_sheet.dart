import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet {
    /// Show a bottom modal sheet modal using the supplied builder to show the content.
    Future<dynamic> showModal({
        @required BuildContext context,
        @required Widget Function(BuildContext) builder,
        bool expand = true,
        bool useRootNavigator = true,
    }) async => showBarModalBottomSheet(
        context: context,
        useRootNavigator: useRootNavigator,
        expand: expand,
        backgroundColor: LunaDatabaseValue.THEME_AMOLED.data ? Colors.black : LunaColours.secondary,
        shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data ? LSRoundedShapeWithBorder() : LSRoundedShape(),
        builder: builder,
    );

    /// Show the changelog screen using a bottom modal sheet.
    Future<void> showChangelog(BuildContext context, String buildNumber) async {
        await DefaultAssetBundle.of(context).loadString("assets/changelog.json")
        .then((data) {
            Map<String, dynamic> changelog = json.decode(data);
            Database.alertsBox.put('ALERTS_CHANGELOG', buildNumber);
            showModal(
                context: context,
                builder: (context) => LSListView(
                    children: [
                        LSHeader(text: '${changelog['version']} (${changelog['build']})', subtitle: changelog['motd']),
                        if((changelog['new'] as List<dynamic>).length != 0) LSTableBlock(
                            title: 'New',
                            children: List.generate(
                                (changelog['new'] as List<dynamic>).length,
                                (index) => LSTableContent(
                                    title: changelog['new'][index]['module'],
                                    body: (changelog['new'][index]['changes'] as List<dynamic>).fold('', (data, object) => data += '${Constants.TEXT_BULLET}\t$object\n').trim(),
                                ),
                            ),
                        ),
                        if((changelog['tweaks'] as List<dynamic>).length != 0) LSTableBlock(
                            title: 'Tweaks',
                            children: List.generate(
                                (changelog['tweaks'] as List<dynamic>).length,
                                (index) => LSTableContent(
                                    title: changelog['tweaks'][index]['module'],
                                    body: (changelog['tweaks'][index]['changes'] as List<dynamic>).fold('', (data, object) => data += '${Constants.TEXT_BULLET}\t$object\n').trim(),
                                ),
                            ),
                        ),
                        if((changelog['fixes'] as List<dynamic>).length != 0) LSTableBlock(
                            title: 'Fixes',
                            children: List.generate(
                                (changelog['fixes'] as List<dynamic>).length,
                                (index) => LSTableContent(
                                    title: changelog['fixes'][index]['module'],
                                    body: (changelog['fixes'][index]['changes'] as List<dynamic>).fold('', (data, object) => data += '${Constants.TEXT_BULLET}\t$object\n').trim(),
                                ),
                            ),
                        ),
                        LSButton(text: 'Full Changelog', onTap: () async => Constants.URL_CHANGELOG.lunaOpenGenericLink()),
                    ],
                ),
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to fetch changelog', error, stack);
            showLunaErrorSnackBar(context: context, title: 'Failed to Fetch Changelog', error: error);
        });
    }
}
