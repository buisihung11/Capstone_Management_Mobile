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

