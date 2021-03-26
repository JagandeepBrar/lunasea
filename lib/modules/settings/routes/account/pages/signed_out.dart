import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSignedOutPage extends StatefulWidget {
    final ScrollController scrollController;

    SettingsAccountSignedOutPage({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedOutPage> {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    LunaLoadingState _state = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) {
        return LunaListView(
            controller: widget.scrollController,
            children: [
                Padding(
                    child: Center(
                        child: Image.asset(
                            'assets/images/branding/splash.png',
                            width: 200.0,
                        ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                AutofillGroup(
                    child: LunaCard(
                        context: context,
                        child: Column(
                            children: [
                                LunaTextInputBar(
                                    controller: _emailController,
                                    isFormField: true,
                                    margin: EdgeInsets.all(12.0),
                                    labelIcon: Icons.person,
                                    labelText: 'Email',
                                    action: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: [AutofillHints.username, AutofillHints.email],
                                ),
                                LunaTextInputBar(
                                    controller: _passwordController,
                                    isFormField: true,
                                    margin: EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
                                    labelIcon: Icons.vpn_key,
                                    labelText: 'Password',
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    autofillHints: [AutofillHints.password, AutofillHints.newPassword],
                                    action: TextInputAction.done,
                                ),
                            ],
                        ),
                    ),
                ),
                LunaButtonContainer(
                    children: [
                        LunaButton(
                            type: LunaButtonType.TEXT,
                            text: 'Register',
                            backgroundColor: LunaColours.blueGrey,
                            onTap: _register,
                            loadingState: _state,
                        ),
                        LunaButton(
                            type: LunaButtonType.TEXT,
                            backgroundColor: LunaColours.accent,
                            text: 'Sign In',
                            onTap: _signIn,
                            loadingState: _state,
                        ),
                    ],
                ),
                Padding(
                    child: Center(
                        child: InkWell(
                            child: Text(
                                "Forgot Your Password?",
                                style: TextStyle(
                                    color: LunaColours.accent,
                                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                ),
                                textAlign: TextAlign.center,
                            ),
                            onTap: () async => SettingsAccountPasswordResetRouter().navigateTo(context),
                        ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                )
                
            ],
        );
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

    bool _validatePassword({ bool showSnackBarOnFailure = true }) {
        if(_passwordController.text.isEmpty) {
            if(showSnackBarOnFailure) showLunaErrorSnackBar(
                context: context,
                title: 'Invalid Password',
                message: 'The password is invalid',
            );
            return false;
        }
        return true;
    }

    Future<void> _register() async {
        if(!_validateEmailAddress() || !_validatePassword()) return;
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        await LunaFirebaseAuth().registerUser(_emailController.text, _passwordController.text)
        .then((response) {
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            response.state
            ? showLunaSuccessSnackBar(context: context, title: 'Successfully Registered', message: response.user.email)
            : showLunaErrorSnackBar(context: context, title: 'Failed to Register', message: response.error?.message ?? 'Unknown Error');
        })
        .catchError((error, stack) {
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            showLunaErrorSnackBar(context: context, title: 'Failed to Register', error: error);
        });
    }

    Future<void> _signIn() async {
        if(!_validateEmailAddress() || !_validatePassword()) return;
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        await LunaFirebaseAuth().signInUser(_emailController.text, _passwordController.text)
        .then((response) {
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            response.state
            ? showLunaSuccessSnackBar(context: context, title: 'Successfully Signed In', message: response.user.email)
            : showLunaErrorSnackBar(context: context, title: 'Failed to Sign In', message: response.error?.message ?? 'Unknown Error');
        })
        .catchError((error, stack) {
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            showLunaErrorSnackBar(context: context, title: 'Failed to Sign In', error: error);
        });
    }
}
