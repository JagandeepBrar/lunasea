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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
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

  SliverToBoxAdapter _motd() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text(
          'To exit please fully close and restart the application.',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    const actions = [
      BootstrapTile(),
      ClearDatabaseTile(),
    ];

    return CustomScrollView(
      slivers: [
        SliverPadding(
          sliver: _motd(),
          padding: const EdgeInsets.all(12.0),
        ),
        SliverList(
          delegate: SliverChildListDelegate(actions),
        ),
      ],
    );
  }
}
