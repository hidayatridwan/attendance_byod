part of 'absen_bloc.dart';

abstract class AbsenState extends Equatable {
  const AbsenState();

  @override
  List<Object> get props => [];
}

class AbsenInitial extends AbsenState {}

class AbsenLoading extends AbsenState {}

class AbsenSuccess extends AbsenState {
  final AbsenModel data;

  const AbsenSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AbsenError extends AbsenState {
  final String error;

  const AbsenError(this.error);

  @override
  List<Object> get props => [error];
}
