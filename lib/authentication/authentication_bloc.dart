import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/authentication/index.dart';
import 'package:flutter_login_demo/repositories/user_repository.dart';

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
    final _isSignnedIn = await _userRepository.isSignedIn();
    if (_isSignnedIn) {
      final name = await _userRepository.getUser();
      yield AuthenticatedState(name);
    } else {
      yield UnAuthenticationState();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final name = await _userRepository.getUser();
    yield AuthenticatedState(name);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticationState();
    _userRepository.signOut();
  }
}
