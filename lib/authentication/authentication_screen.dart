import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/authentication/index.dart';
import 'package:flutter_login_demo/login/index.dart';
import 'package:flutter_login_demo/main.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    Key key,
  }) : super(key: key);

  @override
  AuthenticationScreenState createState() {
    return AuthenticationScreenState();
  }
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthenticationScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (
      BuildContext context,
      AuthenticationState currentState,
    ) {
      if (currentState is InAuthenticationState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (currentState is UnAuthenticationState) {
        return Center(
          child: LoginForm(onLogin: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }),
        );
      }
      if (currentState is ErrorAuthenticationState) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentState.errorMessage ?? 'Error'),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: RaisedButton(
                color: Colors.blue,
                child: Text('reload'),
                onPressed: _load,
              ),
            ),
          ],
        ));
      }
      if (currentState is AuthenticatedState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(currentState.user.displayName),
            ],
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  void _load() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
  }
}
