import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/authentication/index.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';

class AuthenticationPage extends StatefulWidget {
  static const String routeName = '/authentication';
  final UserRepository userRepository;

  const AuthenticationPage({Key key, this.userRepository}) : super(key: key);
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return AuthenticationScreen();
        },
      ),
    );
  }
}
