import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsAccountSignedOutBody extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedOutBody> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    LunaLoadingState _state = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) => Form(
        key: _formKey,
        child: LSListView(
            children: [
                Padding(
                    child: Center(
                        child: Image.asset(
                            'assets/branding/splash.png',
                            width: 200.0,
                        ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                LSCard(
                    child: Column(
                        children: [
                            LSTextInputBar(
                                controller: _emailController,
                                margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 12.0, right: 12.0),
                                labelIcon: Icons.person,
                                labelText: 'Email...',
                                onChanged: (value, updateController) => setState(() {
                                    if(updateController) _emailController.text = value;
                                }),
                            ),
                            LSTextInputBar(
                                controller: _passwordController,
                                margin: EdgeInsets.only(top: 6.0, bottom: 12.0, left: 12.0, right: 12.0),
                                labelIcon: Icons.vpn_key,
                                labelText: 'Password...',
                                obscureText: true,
                                onChanged: (value, updateController) => setState(() {
                                    if(updateController) _passwordController.text = value;
                                }),
                            ),
                        ],
                    ),
                ),
                LSContainerRow(
                    children: [
                        Expanded(
                            child: LSButton(
                                text: 'Register',
                                backgroundColor: LunaColours.blueGrey,
                                onTap: _register,
                                reducedMargin: true,
                                isLoading: _state == LunaLoadingState.ACTIVE,
                            ),
                        ),
                        Expanded(
                            child: LSButton(
                                text: 'Sign In',
                                onTap: _signIn,
                                reducedMargin: true,
                                isLoading: _state == LunaLoadingState.ACTIVE,
                            ),
                        ),
                    ],
                ),
            ],
        ),
    );

    Future<void> _register() async {
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        if(_formKey.currentState.validate()) LunaFirebaseAuth().registerUser(_emailController.text, _passwordController.text)
        .then((response) {
            if(response.state) {
                showLunaSuccessSnackBar(context: context, title: 'Successfully Registered', message: response.user.email);
            } else {
                showLunaErrorSnackBar(context: context, title: 'Failed to Register', message: response.error?.message ?? 'Unknown Error');
                if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            }
        })
        .catchError((error, stack) {
            showLunaErrorSnackBar(context: context, title: 'Failed to Register User', error: error);
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
        });
    }

    Future<void> _signIn() async {
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        if(_formKey.currentState.validate()) LunaFirebaseAuth().signInUser(_emailController.text, _passwordController.text)
        .then((response) {
            if(response.state) {
                showLunaSuccessSnackBar(context: context, title: 'Successfully Signed In', message: response.user.email);
            } else {
                showLunaErrorSnackBar(context: context, title: 'Failed to Sign In', message: response.error?.message ?? 'Unknown Error');
                if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
            }
        })
        .catchError((error, stack) {
            showLunaErrorSnackBar(context: context, title: 'Failed to Register User', error: error);
            if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
        });
    }
}