import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/karyawan_model.dart';
import '../../data/repositories/repositories.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final KaryawanRepository _karyawanRepository;

  AccountBloc(this._karyawanRepository) : super(AccountInitial()) {
    on<GetAccountEvent>((event, emit) async {
      emit(AccountLoading());
      final result = await _karyawanRepository.user(event.nik);
      result.fold((l) => emit(AccountError(l)), (r) {
        emit(AccountSuccess(r));
      });
    });
  }
}
