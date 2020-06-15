import 'package:equatable/equatable.dart';

abstract class CapstoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CapstoneRequest extends CapstoneEvent {}

class CapstoneRefreshRequest extends CapstoneEvent {}
