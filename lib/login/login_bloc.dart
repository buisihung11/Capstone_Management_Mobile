import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/login/index.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({@required this.userRepository});

  @override
  LoginState get initialState => UnLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      try {
        yield InLoginState();
        FirebaseUser user = await userRepository.signInWithGoogle();
        await user.getIdToken();
        yield LoginSuccessState();
      } on PlatformException catch (e) {
        print('Catch Error In Bloc');
        yield ErrorLoginState(e.toString(), e.code);
      }
    }
  }
}
