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
        child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Padding(
                        child: Center(
                            child: Image.asset(
                                'assets/branding/splash.png',
                                width: 200.0,
                            ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    LSCard(
                        child: Padding(
                            child: Column(
                                children: [
                                    Padding(
                                        child: TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                                hintText: 'Email',
                                                labelStyle: TextStyle(
                                                    color: Colors.white54,
                                                    decoration: TextDecoration.none,
                                                    fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: LunaColours.accent),
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: LunaColours.accent.withOpacity(0.3)),
                                                ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                            ),
                                            autocorrect: false,
                                            validator: (value) {
                                                if(value.isEmpty) return 'Email Required';
                                                return null;
                                            },
                                            keyboardType: TextInputType.emailAddress,
                                        ),
                                        padding: EdgeInsets.only(bottom: 16.0),
                                    ),
                                    Padding(
                                        child: TextFormField(
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                                hintText: 'Password',
                                                labelStyle: TextStyle(
                                                    color: Colors.white54,
                                                    decoration: TextDecoration.none,
                                                    fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: LunaColours.accent),
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: LunaColours.accent.withOpacity(0.3)),
                                                ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                            ),
                                            validator: (value) {
                                                if(value.isEmpty) return 'Password Required';
                                                return null;
                                            },
                                            autocorrect: false,
                                            obscureText: true,
                                        ),
                                        padding: EdgeInsets.only(bottom: 8.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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