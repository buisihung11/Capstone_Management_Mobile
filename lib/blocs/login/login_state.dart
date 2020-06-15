import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final List propss;
  LoginState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);

  get errorMessage => null;
}

/// UnInitialized
class UnLoginState extends LoginState {
  UnLoginState();

  @override
  String toString() => 'UnLoginState';
}

/// Initialized
class InLoginState extends LoginState {
  InLoginState();

  @override
  String toString() => 'InLoginState';
}

/// Logged in
class LoginSuccessState extends LoginState {
  LoginSuccessState();

  @override
  String toString() => 'InLoginState';
}

class ErrorLoginState extends LoginState {
  final String errorMessage;
  final String errorCode;

  ErrorLoginState(this.errorMessage, this.errorCode) : super([errorMessage]);

  @override
  String toString() => 'ErrorLoginState';
}
