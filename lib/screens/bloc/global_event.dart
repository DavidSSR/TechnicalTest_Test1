part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

class CreateUserEvent extends GlobalEvent {
  final Map<String, dynamic> nuevo;
  CreateUserEvent(this.nuevo);
}

class SetUser extends GlobalEvent {
  final Map<String, dynamic> user;
  SetUser(this.user);
}

class DataEvent extends GlobalEvent {
  final Map<String, dynamic> currentData;
  DataEvent(this.currentData);
}

class SetData extends GlobalEvent {
  final Map<String, dynamic> currentData;
  SetData(this.currentData);
}
