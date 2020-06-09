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

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final Function onLogin;
  const LoginForm({Key key, this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccessState) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
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
                      if (state is ErrorLoginState)
                        Text('Login err: ${state.errorMessage}'),
                      Text(
                        'Please Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 15,
                        ),
                      ),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginWithGooglePressed());
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
