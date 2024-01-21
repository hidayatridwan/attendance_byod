part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangeOldPasswordEvent extends ChangePasswordEvent {
  final String nik;
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  const ChangeOldPasswordEvent(
      this.nik, this.oldPassword, this.newPassword, this.confirmNewPassword);
}
