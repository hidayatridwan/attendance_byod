part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class UserEvent extends LoginEvent {
  final String nik;
  final String password;

  const UserEvent(this.nik, this.password);
}