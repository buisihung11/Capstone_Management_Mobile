import 'package:equatable/equatable.dart';

abstract class CapstoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CapstoneRequest extends CapstoneEvent {}

class CapstoneRefreshRequest extends CapstoneEvent {}

class CapstoneLoadMoreRequest extends CapstoneEvent {
  final int page;

  CapstoneLoadMoreRequest(this.page);
}

class CapstoneRequestFilter extends CapstoneEvent {
  final String name;

  CapstoneRequestFilter({this.name});
  @override
  List<Object> get props => [name];
}
