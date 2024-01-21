import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/repositories.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final KaryawanRepository _karyawanRepository;

  ChangePasswordBloc(this._karyawanRepository)
      : super(ChangePasswordInitial()) {
    on<ChangeOldPasswordEvent>((event, emit) async {
      emit(ChangePasswordLoading());
      if (event.newPassword != event.confirmNewPassword) {
        emit(const ChangePasswordError(
            'New password and Confirm new password is not match'));
      }

      final result = await _karyawanRepository.changePassword(
          event.nik, event.newPassword, event.oldPassword);
      result.fold((l) => emit(ChangePasswordError(l)), (r) {
        emit(ChangePasswordSuccess(r));
      });
    });
  }
}
