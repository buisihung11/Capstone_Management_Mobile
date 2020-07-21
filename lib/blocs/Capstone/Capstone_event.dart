import 'package:equatable/equatable.dart';

abstract class CapstoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CapstoneRequest extends CapstoneEvent {}

class CapstoneRefreshRequest extends CapstoneEvent {}

class CapstoneRequestFilter extends CapstoneEvent {
  final String name;

  CapstoneRequestFilter({this.name});
  @override
  List<Object> get props => [name];
}
