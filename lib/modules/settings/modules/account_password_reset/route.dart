import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsAccountPasswordResetRouter extends LunaPageRouter {
    SettingsAccountPasswordResetRouter() : super('/settings/account/passwordreset');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsAccountPasswordResetRoute());
}

class _SettingsAccountPasswordResetRoute extends StatefulWidget {
    @override
    State<_SettingsAccountPasswordResetRoute> createState() => _State();
}

class _State extends State<_SettingsAccountPasswordResetRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final TextEditingController _emailController = TextEditingController();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(title: 'Password Reset');

    Widget get _body => LunaListView(
        children: [
            AutofillGroup(
                child: LSCard(
                    child: Column(
                        children: [
                            LSTextInputBar(
                                controller: _emailController,
                                isFormField: true,
                                margin: EdgeInsets.all(12.0),
                                labelIcon: Icons.person,
                                labelText: 'Email',
                                action: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: [AutofillHints.username, AutofillHints.email],
                                onChanged: (value, updateController) => setState(() {
                                    if(updateController) _emailController.text = value;
                                }),
                            ),
                        ],
                    ),
                ),
            ),
            LSButton(
                text: 'Reset Password',
                onTap: _resetPassword,
            ),
        ],
    );

    Future<void> _resetPassword() async {
        if(_validateEmailAddress()) {
            LunaFirebaseAuth().resetPassword(_emailController.text)
            .then((_) => showLunaSuccessSnackBar(
                context: context,
                title: 'Email Sent',
                message: 'An email to reset your password has been sent!',
            ))
            .catchError((error, stack) {
                LunaLogger().error('Failed to reset password: ${_emailController.text}', error, stack);
                showLunaErrorSnackBar(context: context, title: 'Failed to Reset Password', error: error);
            });
        }
    }

    bool _validateEmailAddress({ bool showSnackBarOnFailure = true }) {
        const _regex = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
        if(!RegExp(_regex).hasMatch(_emailController.text)) {
            if(showSnackBarOnFailure) showLunaErrorSnackBar(
                context: context,
                title: 'Invalid Email',
                message: 'The email address is invalid',
            );
            return false;
        }
        return true;
    }
}
