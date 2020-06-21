import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/blocs/login/index.dart';
import 'package:flutter_login_demo/models/login.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';
import 'package:flutter_login_demo/utils/index.dart';

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
        final firebaseToken = await user.getIdToken();

        // send token to server
        Response res =
            await userRepository.loginWithServer(firebaseToken.token);

        if (res.statusCode == 200) {
          if (res.data["success"]) {
            String jwtToken = res.data["data"]["token"];
            if (await setToken(jwtToken.toString())) {
              yield LoginSuccessState();
            } else {
              yield ErrorLoginState("Cannot save jwtToken", "Unknown");
            }
          } else {
            yield ErrorLoginState(res.data["error"], "Unknown");
          }
        } else {
          yield ErrorLoginState(res.statusMessage, "Unknown");
        }
        // save JWT Token

      } on Exception catch (e) {
        print('Catch Error When login');
        yield ErrorLoginState(e.toString(), e.toString());
      }
    }
  }
}
