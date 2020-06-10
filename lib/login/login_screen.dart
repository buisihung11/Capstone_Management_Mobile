import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/authentication/authentication_event.dart';
import 'package:flutter_login_demo/authentication/index.dart';
import 'package:flutter_login_demo/login/login_bloc.dart';
import 'package:flutter_login_demo/main.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'index.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String msg;
  LoginScreen({Key key, @required UserRepository userRepository, this.msg})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print('msg $msg');
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(msg: msg),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final Function onLogin;
  final String msg;
  const LoginForm({Key key, this.onLogin, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccessState) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        if (state is ErrorLoginState && state.errorCode == "network_error") {
          print("$state ${state.errorCode == "network_error"}");
          final snackbar = SnackBar(
            content: Text(
              "Network error. Please try again!",
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          );
          Scaffold.of(context).showSnackBar(snackbar);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            color: Colors.orange[300],
            child: Stack(
              children: <Widget>[
                Image.asset('assets/FPT.png'),
                Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (state is ErrorLoginState &&
                          state.errorCode != "network_error")
                        Text(
                          'Login err: ${state.errorMessage}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      if (msg != null) Text(msg),
                      Text(
                        'Please Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 15,
                        ),
                      ),
                      state is InLoginState
                          ? RaisedButton(
                              color: Colors.white,
                              onPressed: () {},
                              child: CircularProgressIndicator(),
                            )
                          : SignInButton(
                              Buttons.Google,
                              onPressed: () {
                                if (state is! InLoginState) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginWithGooglePressed());
                                }
                              },
                            ),
                    ],
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
