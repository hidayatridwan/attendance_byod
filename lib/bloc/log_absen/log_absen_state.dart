part of 'log_absen_bloc.dart';

abstract class LogAbsenState extends Equatable {
  const LogAbsenState();

  @override
  List<Object> get props => [];
}

class LogAbsenInitial extends LogAbsenState {}

class LogAbsenLoading extends LogAbsenState {}

class LogAbsenSuccess extends LogAbsenState {
  final List<AbsenModel> data;

  const LogAbsenSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class LogAbsenError extends LogAbsenState {
  final String error;

  const LogAbsenError(this.error);

  @override
  List<Object> get props => [error];
}
