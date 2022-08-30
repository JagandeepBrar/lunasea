import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings/routes/account/widgets/change_email_tile.dart';
import 'package:lunasea/modules/settings/routes/account/widgets/change_password_tile.dart';
import 'package:lunasea/modules/settings/routes/account/widgets/delete_account_tile.dart';

class AccountSettingsRoute extends StatefulWidget {
  const AccountSettingsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountSettingsRoute> createState() => _State();
}

class _State extends State<AccountSettingsRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'settings.AccountSettings'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: const [
        ChangeEmailTile(),
        ChangePasswordTile(),
        DeleteAccountTile(),
      ],
    );
  }
}
