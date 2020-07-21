import 'package:equatable/equatable.dart';
import 'package:flutter_login_demo/models/capstone.dart';

abstract class CapstoneState extends Equatable {
  final List propss;
  CapstoneState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class CapstoneInitialState extends CapstoneState {}

class CapstoneLoadInProgressState extends CapstoneState {}

/// Initialized
class CapstoneLoadSuccess extends CapstoneState {
  final List<Capstone> result;
  final int totalPage;

  CapstoneLoadSuccess(this.result, [this.totalPage])
      : super([result, totalPage]);
}

class CapstoneFailureState extends CapstoneState {
  final String errorMessage;

  CapstoneFailureState({this.errorMessage = "Error when loading"})
      : super([errorMessage]);

  @override
  String toString() => 'ErrorCapstoneState';
}
