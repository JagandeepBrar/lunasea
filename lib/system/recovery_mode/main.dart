import 'package:flutter/material.dart';
import 'package:lunasea/system/recovery_mode/actions/clear_database.dart';
import 'package:lunasea/system/recovery_mode/actions/bootstrap.dart';

class LunaRecoveryMode extends StatelessWidget {
  const LunaRecoveryMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _home(),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
    );
  }

  Widget _home() {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text('Recovery Mode'),
    );
  }

  Widget _motd() {
    return const Padding(
      child: Center(
        child: Text(
          'To exit please fully close and restart the application.',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      padding: EdgeInsets.all(12.0),
    );
  }

  Widget _body() {
    const actions = [
      BootstrapTile(),
      ClearDatabaseTile(),
    ];

    return ListView.separated(
      itemCount: actions.length + 1,
      itemBuilder: (context, idx) {
        if (idx == 0) return _motd();
        return actions[idx - 1];
      },
      separatorBuilder: (context, idx) {
        if (idx == 0) return const SizedBox();
        return const Divider();
      },
    );
  }
}
