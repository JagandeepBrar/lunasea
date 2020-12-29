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
                AutofillGroup(
                    child: LSCard(
                        child: Column(
                            children: [
                                LSTextInputBar(
                                    controller: _emailController,
                                    isFormField: true,
                                    margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 12.0, right: 12.0),
                                    labelIcon: Icons.person,
                                    labelText: 'Email...',
                                    action: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: [AutofillHints.username, AutofillHints.email],
                                    onChanged: (value, updateController) => setState(() {
                                        if(updateController) _emailController.text = value;
                                    }),
                                    validator: (value) {
                                        if(value.isEmpty) return 'Email Required';
                                        return null;
                                    },
                                ),
                                LSTextInputBar(
                                    controller: _passwordController,
                                    isFormField: true,
                                    margin: EdgeInsets.only(top: 6.0, bottom: 12.0, left: 12.0, right: 12.0),
                                    labelIcon: Icons.vpn_key,
                                    labelText: 'Password...',
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    autofillHints: [AutofillHints.password, AutofillHints.newPassword],
                                    action: TextInputAction.done,
                                    onChanged: (value, updateController) => setState(() {
                                        if(updateController) _passwordController.text = value;
                                    }),
                                    validator: (value) {
                                        if(value.isEmpty) return 'Password Required';
                                        return null;
                                    },
                                ),
                            ],
                        ),
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
        // Set button state
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        // Check form, then register user
        if(_formKey.currentState.validate()) await LunaFirebaseAuth().registerUser(_emailController.text, _passwordController.text)
        .then((response) => response.state
            ? showLunaSuccessSnackBar(context: context, title: 'Successfully Registered', message: response.user.email)
            : showLunaErrorSnackBar(context: context, title: 'Failed to Register', message: response.error?.message ?? 'Unknown Error'))
        .catchError((error, stack) => showLunaErrorSnackBar(context: context, title: 'Failed to Register', error: error));
        // Set button state
        if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
    }

    Future<void> _signIn() async {
        // Set button state
        if(mounted) setState(() => _state = LunaLoadingState.ACTIVE);
        // Check form, then login user
        if(_formKey.currentState.validate()) await LunaFirebaseAuth().signInUser(_emailController.text, _passwordController.text)
        .then((response) => response.state
            ? showLunaSuccessSnackBar(context: context, title: 'Successfully Signed In', message: response.user.email)
            : showLunaErrorSnackBar(context: context, title: 'Failed to Sign In', message: response.error?.message ?? 'Unknown Error'))
        .catchError((error, stack) => showLunaErrorSnackBar(context: context, title: 'Failed to Sign In', error: error));
        // Set button state
        if(mounted) setState(() => _state = LunaLoadingState.INACTIVE);
    }
}