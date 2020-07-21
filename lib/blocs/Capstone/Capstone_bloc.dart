import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_demo/blocs/Capstone/index.dart';
import 'package:flutter_login_demo/repositories/capstoneRepository.dart';

class CapstoneBloc extends Bloc<CapstoneEvent, CapstoneState> {
  final CapstoneRepository capstoneRepository;

  CapstoneBloc({@required this.capstoneRepository});

  @override
  CapstoneState get initialState => CapstoneInitialState();

  @override
  Stream<CapstoneState> mapEventToState(
    CapstoneEvent event,
  ) async* {
    try {
      if (event is CapstoneRequest) {
        yield CapstoneLoadInProgressState();
        final result = await capstoneRepository.getCapstoneList();
        yield CapstoneLoadSuccess(result);
      }
      if (event is CapstoneRequestFilter) {
        yield CapstoneLoadInProgressState();
        final result =
            await capstoneRepository.getCapstoneListWithFilter(event.name);
        yield CapstoneLoadSuccess(result);
      }
      if (event is CapstoneRefreshRequest) {
        final result = await capstoneRepository.getCapstoneList();
        yield CapstoneLoadSuccess(result);
      }
    } catch (err) {
      print(err);
      yield CapstoneFailureState(errorMessage: err.toString());
      print("error at capstone bloc");
    }
  }
}
