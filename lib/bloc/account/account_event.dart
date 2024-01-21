part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountEvent extends AccountEvent {
  final String nik;

  const GetAccountEvent(this.nik);
}