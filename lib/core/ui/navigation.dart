import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/core.dart';

class Navigation {
    Navigation._();
    
    /*
     * getAppBar(): Returns an AppBar widget with the passed in title
     */
    static AppBar getAppBar(String title, BuildContext context) {
        return AppBar(
            title: Text(
                title,
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
        );
    }

    /*
     * getAppBarTabs(): Returns an AppBar widget with the passed in title and TabBar
     */
    static AppBar getAppBarTabs(String title, List<String> tabTitles, BuildContext context) {
        return AppBar(
            title: Text(
                title,
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            bottom: TabBar(
                tabs: [
                    for(int i =0; i<tabTitles.length; i++)
                        Tab(
                            child: Text(
                                tabTitles[i],
                                style: TextStyle(
                                    letterSpacing: Constants.LETTER_SPACING,
                                ),
                            )
                        )
                ],
                isScrollable: true,
            ),
        );
    }

    /*
     * getDrawer(): Returns a Drawer widget, with _getDrawerEntries as the children
     */
    static Drawer getDrawer(String page, BuildContext context) {
        return Drawer(
            child: ListView(
                children: _getDrawerEntries(context, page),
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                physics: ClampingScrollPhysics(),
            ),
        );
    }

    /*
     * _getDrawerEntries(): Returns a list of Widgets for the drawer
     */
    static List<Widget> _getDrawerEntries(BuildContext context, String page) {
        return <Widget> [
            DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                    color: Color(Constants.ACCENT_COLOR),
                ),
            ),
            _getDrawerEntry(context, 'Home', page, '/', CustomIcons.home),
            _getDrawerEntry(context, 'Settings', page, '/settings', CustomIcons.settings, justPush: true),
            Elements.getDivider(padding: 18.0),
            Values.anyAutomationEnabled() ? (
                ExpansionTile(
                    leading: Icon(CustomIcons.layers),
                    title: Text('Automation'),
                    initiallyExpanded: true,
                    children: <Widget>[
                        Values.lidarrValues[0] ? (
                            _getDrawerEntry(context, 'Lidarr', page, '/lidarr', CustomIcons.music, padLeft: true)
                        ) : (
                            Container()
                        ),
                        Values.radarrValues[0] ? (
                            _getDrawerEntry(context, 'Radarr', page, '/radarr', CustomIcons.movies, padLeft: true)
                        ) : (
                            Container()
                        ),
                        Values.sonarrValues[0] ? (
                            _getDrawerEntry(context, 'Sonarr', page, '/sonarr', CustomIcons.television, padLeft: true)
                        ) : (
                            Container()
                        ),
                    ],
                )
            ) : (
                Container()
            ),
            Values.anyClientsEnabled() ? (
                ExpansionTile(
                    leading: Icon(CustomIcons.clients),
                    title: Text( 'Clients'),
                    initiallyExpanded: true,
                    children: <Widget>[
                        Values.nzbgetValues[0] ? (
                            _getDrawerEntry(context, 'NZBGet', page, '/nzbget', CustomIcons.nzbget, padLeft: true)
                        ) : (
                            Container()
                        ),
                        Values.sabnzbdValues[0] ? (
                            _getDrawerEntry(context, 'SABnzbd', page, '/sabnzbd', CustomIcons.sabnzbd, padLeft: true)
                        ) : (
                            Container()
                        ),
                    ],
                )
            ) : (
                Container()
            ),
        ];
    }

    static ListTile _getDrawerEntry(BuildContext context, String title, String page, String route, IconData icon, {bool justPush = false, bool padLeft = false}) {
        return ListTile(
            leading: Icon(
                icon,
                color: page != title.toLowerCase() ? Colors.white : Color(Constants.ACCENT_COLOR),
            ),
            title: Text(
                title,
                style: TextStyle(
                    color: page != title.toLowerCase() ? Colors.white : Color(Constants.ACCENT_COLOR),
                ),
            ),
            onTap: () async {
                Navigator.of(context).pop();
                if(page != title.toLowerCase()) {
                    if(justPush) {
                        await Navigator.of(context).pushNamed(route);
                    } else {
                        await Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
                    }
                }
            },
            contentPadding: padLeft ? EdgeInsets.fromLTRB(42.0, 0.0, 0.0, 0.0) : EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }

    /*
     * getBottomNavigationBar(): Returns a BottomNavigationBar widget
     */
    static BottomNavyBar getBottomNavigationBar(int index, List<Icon> icons, List<String> titles, Function onTap) {
        return BottomNavyBar(
            selectedIndex: index,
            onItemSelected: onTap,
            showElevation: false,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: Color(Constants.PRIMARY_COLOR),
            curve: Curves.easeInOut,
            items: [
                for(int i=0; i<icons.length; i++)
                    BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        icon: icons[i],
                        title: Text(titles[i]),
                        inactiveColor: Colors.white,
                        activeColor: Color(Constants.ACCENT_COLOR),
                    )
            ],
        );
    }
}