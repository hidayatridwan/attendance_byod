part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final KaryawanModel data;

  const AccountSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AccountError extends AccountState {
  final String error;

  const AccountError(this.error);

  @override
  List<Object> get props => [error];
}
