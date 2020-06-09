import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_login_demo/authentication/index.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}
class LoggedIn extends AuthenticationEvent {}
class LoggedOut extends AuthenticationEvent {}


// @immutable
// abstract class AuthenticationEvent {
//   Stream<AuthenticationState> applyAsync(
//       {AuthenticationState currentState, AuthenticationBloc bloc});
// }

// class UnAuthenticationEvent extends AuthenticationEvent {
//   @override
//   Stream<AuthenticationState> applyAsync({AuthenticationState currentState, AuthenticationBloc bloc}) async* {
//     yield UnAuthenticationState();
//   }
// }

// class LoadAuthenticationEvent extends AuthenticationEvent {

//   @override
//   Stream<AuthenticationState> applyAsync(
//       {AuthenticationState currentState, AuthenticationBloc bloc}) async* {
//     try {
//       yield UnAuthenticationState();
//       await Future.delayed(Duration(seconds: 1));
//       yield InAuthenticationState('Hello world');
//     } catch (_, stackTrace) {
//       developer.log('$_', name: 'LoadAuthenticationEvent', error: _, stackTrace: stackTrace);
//       yield ErrorAuthenticationState( _?.toString());
//     }
//   }
// }
