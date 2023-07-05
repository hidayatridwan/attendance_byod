part of 'karyawan_bloc.dart';

abstract class KaryawanEvent extends Equatable {
  const KaryawanEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends KaryawanEvent {
  final String nik;
  final String password;

  const LoginEvent(this.nik, this.password);
}

class UserEvent extends KaryawanEvent {
  final String nik;

  const UserEvent(this.nik);
}
