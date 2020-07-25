import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/blocs/authentication/index.dart';
import 'package:flutter_login_demo/models/user.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';

import '../../utils/index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState =>
      InAuthenticationState("Processing Loggin");

  final UserRepository _userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final _isSignnedIn = await _userRepository.isSignedIn();
      print("LoggedIn $_isSignnedIn");
      if (_isSignnedIn) {
        final res = await _userRepository.getUser();
        // send FCM Token to server
        final fcmToken = await getFCMToken();
        final resSaveToken = await _userRepository.saveFCMToken(fcmToken);
        yield AuthenticatedState(User.fromJSON(res.data));
      } else {
        yield UnAuthenticationState();
      }
    } catch (e) {
      yield ErrorAuthenticationState(e.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      final res = await _userRepository.getUser();
      // send FCM Token to server
      final fcmToken = await getFCMToken();
      final resSaveToken = await _userRepository.saveFCMToken(fcmToken);
      yield AuthenticatedState(User.fromJSON(res.data));
    } catch (e) {
      yield ErrorAuthenticationState(e.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticationState();
    _userRepository.signOut();
  }
}
