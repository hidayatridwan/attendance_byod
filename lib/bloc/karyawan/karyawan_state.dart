part of 'karyawan_bloc.dart';

abstract class KaryawanState extends Equatable {
  const KaryawanState();

  @override
  List<Object> get props => [];
}

class KaryawanInitial extends KaryawanState {}

class LoginLoading extends KaryawanState {}

class LoginSuccess extends KaryawanState {
  final KaryawanModel data;

  const LoginSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class LoginError extends KaryawanState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
