part of 'global_bloc.dart';

class GlobalState {
  final Map<String, dynamic> user;
  final Map<String, dynamic> currentData;

  GlobalState({this.user = const {}, this.currentData = const {}});

  GlobalState copyWith({
    Map<String, dynamic>? user,
    Map<String, dynamic>? currentData,
  }) {
    return GlobalState(
      user: user ?? this.user,
      currentData: currentData ?? this.currentData,
    );
  }
}
