import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<SetUser>((event, emit) async {
      _setUser(event, emit);
    });
    on<CreateUserEvent>((event, emit) async {
      _createUserEvent(event, emit);
    });
        on<DataEvent>((event, emit) async {
      _dataEvent(event, emit);
    });
        on<SetData>((event, emit) async {
      _setData(event, emit);
    });
  }

  // Acciones

  Future<void> _createUserEvent(
      CreateUserEvent event, Emitter<GlobalState> emit) async {
    Map<String, dynamic>? user = event.nuevo;
    add(SetUser(user));
  }

  Future<void> _setUser(SetUser event, Emitter<GlobalState> emit) async {
    emit(state.copyWith(user: event.user));
  }
    Future<void> _dataEvent(
      DataEvent event, Emitter<GlobalState> emit) async {
    Map<String, dynamic>? data= event.currentData;
    add(SetData(data));
  }

  Future<void> _setData(SetData event, Emitter<GlobalState> emit) async {
    emit(state.copyWith(currentData: event.currentData));
  }
}
