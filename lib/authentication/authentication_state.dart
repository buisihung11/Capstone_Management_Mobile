import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {

  final List propss;
  AuthenticationState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class UnAuthenticationState extends AuthenticationState {


  @override
  String toString() => 'UnAuthenticationState';
}

/// Initialized
class InAuthenticationState extends AuthenticationState {
  final String hello;

  InAuthenticationState(this.hello) : super([hello]);

  @override
  String toString() => 'InAuthenticationState $hello';

}

class AuthenticatedState extends AuthenticationState {
  final String displayName;

  AuthenticatedState(this.displayName) : super([displayName]);

  @override
  String toString() => 'AuthenticatedState $displayName';

}

class ErrorAuthenticationState extends AuthenticationState {
  final String errorMessage;

  ErrorAuthenticationState(this.errorMessage): super([errorMessage]);
  
  @override
  String toString() => 'ErrorAuthenticationState';
}
